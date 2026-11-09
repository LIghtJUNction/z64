#[cfg(target_arch = "x86")]
use core::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use core::arch::x86_64::*;

/// Encode complete 24-byte blocks, returning the number of input bytes used.
///
/// # Safety
/// The CPU and OS must support AVX2. No padding outside either slice is needed.
#[target_feature(enable = "avx2")]
#[allow(unused_unsafe)] // Vector constructors are unsafe on Rust 1.70.
pub(crate) unsafe fn encode(input: &[u8], output: &mut [u8], url: bool) -> usize {
    // Whole constants avoid rebuilding individual alphabet bytes at runtime.
    // SAFETY: either branch constructs an AVX2 register constant.
    let alphabet_offsets = unsafe {
        if url {
            _mm256_setr_epi8(
                65, 71, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -17, 32, 0, 0, 65, 71, -4, -4, -4,
                -4, -4, -4, -4, -4, -4, -4, -17, 32, 0, 0,
            )
        } else {
            _mm256_setr_epi8(
                65, 71, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -19, -16, 0, 0, 65, 71, -4, -4, -4,
                -4, -4, -4, -4, -4, -4, -4, -19, -16, 0, 0,
            )
        }
    };
    // SAFETY: the entrypoint requires AVX2; this only constructs a register constant.
    let shuffle = unsafe {
        _mm256_setr_epi8(
            1, 0, 2, 1, 4, 3, 5, 4, 7, 6, 8, 7, 10, 9, 11, 10, 1, 0, 2, 1, 4, 3, 5, 4, 7, 6, 8, 7,
            10, 9, 11, 10,
        )
    };
    let blocks = (input.len() / 24).min(output.len() / 32);
    let end = blocks * 24;
    let mut i = 0;
    let mut o = 0;
    macro_rules! encode_group {
        ($joined:expr, $output:expr) => {{
            let joined = $joined;
            let groups = _mm256_shuffle_epi8(joined, shuffle);
            let even;
            let odd;
            // LLVM can expand these constant multiplications into longer
            // widening/shift/pack sequences. Keep the exact AVX2 operations.
            // Both instructions operate only on registers and preserve flags.
            core::arch::asm!(
                "vpmulhuw {even}, {groups}, {scale}",
                even = out(ymm_reg) even,
                groups = in(ymm_reg) _mm256_and_si256(groups, _mm256_set1_epi32(0x0fc0_fc00)),
                scale = in(ymm_reg) _mm256_set1_epi32(0x0400_0040),
                options(pure, nomem, nostack, preserves_flags),
            );
            core::arch::asm!(
                "vpmullw {odd}, {groups}, {scale}",
                odd = out(ymm_reg) odd,
                groups = in(ymm_reg) _mm256_and_si256(groups, _mm256_set1_epi32(0x003f_03f0)),
                scale = in(ymm_reg) _mm256_set1_epi32(0x0100_0010),
                options(pure, nomem, nostack, preserves_flags),
            );
            let sextets = _mm256_or_si256(even, odd);
            // The lookup indices are 0 for A..Z, 1 for a..z, 2..11 for
            // digits, 12 and 13 for the alphabet's final two characters.
            let ranges = _mm256_sub_epi8(
                _mm256_subs_epu8(sextets, _mm256_set1_epi8(51)),
                _mm256_cmpgt_epi8(sextets, _mm256_set1_epi8(25)),
            );
            let encoded = _mm256_add_epi8(sextets, _mm256_shuffle_epi8(alphabet_offsets, ranges));
            _mm256_storeu_si256($output, encoded);
        }};
    }
    // A 32-byte load contains two 12-byte lanes and eight unused bytes.
    // Keeping one whole 24-byte block for the tail bounds every wide load.
    while end - i >= 120 {
        // SAFETY: four 32-byte loads end at i + 104 <= end, and four
        // 32-byte stores exactly fill 128 bytes of the caller's output.
        unsafe {
            let lanes = _mm256_setr_epi32(0, 1, 2, 0, 3, 4, 5, 0);
            for block in 0..4 {
                let wide = _mm256_loadu_si256(input.as_ptr().add(i + block * 24).cast());
                let joined = _mm256_permutevar8x32_epi32(wide, lanes);
                encode_group!(joined, output.as_mut_ptr().add(o + block * 32).cast());
            }
        }
        i += 96;
        o += 128;
    }
    while end - i >= 48 {
        // SAFETY: two remaining blocks provide 48 readable bytes; only 32
        // are loaded and one complete 32-byte encoded block is stored.
        unsafe {
            let wide = _mm256_loadu_si256(input.as_ptr().add(i).cast());
            let joined =
                _mm256_permutevar8x32_epi32(wide, _mm256_setr_epi32(0, 1, 2, 0, 3, 4, 5, 0));
            encode_group!(joined, output.as_mut_ptr().add(o).cast());
        }
        i += 24;
        o += 32;
    }
    if end - i == 24 {
        // SAFETY: the last block uses only 0..16 and 8..24, with no
        // lookahead beyond the input, and has exactly 32 output bytes.
        unsafe {
            let lo = _mm_loadu_si128(input.as_ptr().add(i).cast());
            let hi = _mm_loadu_si128(input.as_ptr().add(i + 8).cast());
            let joined = _mm256_set_m128i(_mm_srli_si128::<4>(hi), lo);
            encode_group!(joined, output.as_mut_ptr().add(o).cast());
        }
    }
    end
}

/// Decode complete 32-character blocks, returning input consumed or the first
/// invalid input offset. Only preceding, validated blocks may have been written.
///
/// # Safety
/// The CPU and OS must support AVX2. No padding outside either slice is needed.
#[target_feature(enable = "avx2")]
pub(crate) unsafe fn decode(input: &[u8], output: &mut [u8], url: bool) -> Result<usize, usize> {
    // SAFETY: this entrypoint has the same AVX2 contract as either specialization.
    unsafe {
        if url {
            decode_inner::<true>(input, output)
        } else {
            decode_inner::<false>(input, output)
        }
    }
}

#[target_feature(enable = "avx2")]
#[allow(unused_unsafe)] // Vector constructors are unsafe on Rust 1.70.
unsafe fn decode_inner<const URL: bool>(input: &[u8], output: &mut [u8]) -> Result<usize, usize> {
    // Each high nibble selects one validity bit. Each low nibble marks which
    // high-nibble classes are illegal. Bit 16 rejects control/non-ASCII bytes.
    // SAFETY: the entrypoint requires AVX2; this only constructs a register constant.
    let high_classes = unsafe {
        _mm256_setr_epi8(
            16,
            16,
            1,
            2,
            4,
            8,
            4,
            if URL { 32 } else { 8 },
            16,
            16,
            16,
            16,
            16,
            16,
            16,
            16,
            16,
            16,
            1,
            2,
            4,
            8,
            4,
            if URL { 32 } else { 8 },
            16,
            16,
            16,
            16,
            16,
            16,
            16,
            16,
        )
    };
    // SAFETY: either branch constructs an AVX2 register constant.
    let low_classes = if URL {
        unsafe {
            _mm256_setr_epi8(
                21, 17, 17, 17, 17, 17, 17, 17, 17, 17, 19, 59, 59, 58, 59, 51, 21, 17, 17, 17, 17,
                17, 17, 17, 17, 17, 19, 59, 59, 58, 59, 51,
            )
        }
    } else {
        unsafe {
            _mm256_setr_epi8(
                21, 17, 17, 17, 17, 17, 17, 17, 17, 17, 19, 26, 27, 27, 27, 26, 21, 17, 17, 17, 17,
                17, 17, 17, 17, 17, 19, 26, 27, 27, 27, 26,
            )
        }
    };
    // SAFETY: the entrypoint requires AVX2; this only constructs a register constant.
    let offsets = unsafe {
        _mm256_setr_epi8(
            0,
            16,
            if URL { 17 } else { 19 },
            4,
            -65,
            -65,
            -71,
            -71,
            0,
            0,
            0,
            0,
            0,
            -32,
            0,
            0,
            0,
            16,
            if URL { 17 } else { 19 },
            4,
            -65,
            -65,
            -71,
            -71,
            0,
            0,
            0,
            0,
            0,
            -32,
            0,
            0,
        )
    };
    // SAFETY: the entrypoint requires AVX2; this only constructs a register constant.
    let shuffle = unsafe {
        _mm256_setr_epi8(
            2, 1, 0, 6, 5, 4, 10, 9, 8, 14, 13, 12, -1, -1, -1, -1, 2, 1, 0, 6, 5, 4, 10, 9, 8, 14,
            13, 12, -1, -1, -1, -1,
        )
    };
    let blocks = (input.len() / 32).min(output.len() / 24);
    let end = blocks * 32;
    let mut i = 0;
    let mut o = 0;
    macro_rules! invalid {
        ($chars:expr) => {{
            let low = _mm256_and_si256($chars, _mm256_set1_epi8(15));
            let high = _mm256_and_si256(_mm256_srli_epi16::<4>($chars), _mm256_set1_epi8(15));
            _mm256_and_si256(
                _mm256_shuffle_epi8(high_classes, high),
                _mm256_shuffle_epi8(low_classes, low),
            )
        }};
    }
    macro_rules! valid_mask {
        ($chars:expr) => {
            _mm256_movemask_epi8(_mm256_cmpeq_epi8(invalid!($chars), _mm256_setzero_si256())) as u32
        };
    }
    macro_rules! convert {
        ($chars:expr) => {{
            let high = _mm256_and_si256(_mm256_srli_epi16::<4>($chars), _mm256_set1_epi8(15));
            // '/' uses slot 1; '_' uses slot 13. Other characters use their
            // high-nibble class. The caller validates all input bytes first.
            let special = _mm256_cmpeq_epi8(
                $chars,
                _mm256_set1_epi8(if URL { b'_' } else { b'/' } as i8),
            );
            let index = if URL {
                _mm256_or_si256(high, _mm256_and_si256(special, _mm256_set1_epi8(8)))
            } else {
                _mm256_add_epi8(high, special)
            };
            let values = _mm256_add_epi8($chars, _mm256_shuffle_epi8(offsets, index));
            let pairs = _mm256_maddubs_epi16(values, _mm256_set1_epi32(0x0140_0140));
            let words = _mm256_madd_epi16(pairs, _mm256_set1_epi32(0x0001_1000));
            let lanes = _mm256_shuffle_epi8(words, shuffle);
            _mm256_permutevar8x32_epi32(lanes, _mm256_setr_epi32(0, 1, 2, 4, 5, 6, 0, 0))
        }};
    }
    while end - i >= 64 {
        // Both blocks are validated before any store. The 32-byte first store
        // overlaps only the validated next block; the final store writes 24 bytes.
        unsafe {
            let c0 = _mm256_loadu_si256(input.as_ptr().add(i).cast());
            let c1 = _mm256_loadu_si256(input.as_ptr().add(i + 32).cast());
            let errors = _mm256_or_si256(invalid!(c0), invalid!(c1));
            if _mm256_testz_si256(errors, errors) == 0 {
                let v0 = valid_mask!(c0);
                if v0 != u32::MAX { return Err(i + (!v0).trailing_zeros() as usize); }
                let v1 = valid_mask!(c1);
                return Err(i + 32 + (!v1).trailing_zeros() as usize);
            }
            _mm256_storeu_si256(output.as_mut_ptr().add(o).cast(), convert!(c0));
            let last = convert!(c1);
            _mm_storeu_si128(output.as_mut_ptr().add(o + 24).cast(), _mm256_castsi256_si128(last));
            _mm_storel_epi64(output.as_mut_ptr().add(o + 40).cast(), _mm256_extracti128_si256::<1>(last));
        }
        i += 64;
        o += 48;
    }
    while i < end {
        // SAFETY: the remaining block proves a 32-byte read and exactly 24
        // writable bytes. The output remains unchanged on a validation error.
        unsafe {
            let chars = _mm256_loadu_si256(input.as_ptr().add(i).cast());
            let mask = valid_mask!(chars);
            if mask != u32::MAX {
                return Err(i + (!mask).trailing_zeros() as usize);
            }
            let packed = convert!(chars);
            _mm_storeu_si128(
                output.as_mut_ptr().add(o).cast(),
                _mm256_castsi256_si128(packed),
            );
            _mm_storel_epi64(
                output.as_mut_ptr().add(o + 16).cast(),
                _mm256_extracti128_si256::<1>(packed),
            );
        }
        i += 32;
        o += 24;
    }
    Ok(end)
}
