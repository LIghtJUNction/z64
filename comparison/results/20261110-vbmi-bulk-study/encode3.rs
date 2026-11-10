//! AVX-512 VBMI kernels: byte permutation and bit extraction for encoding;
//! a strict 128-entry lookup, validation, and packed arithmetic for decoding.
//!
//! The bit grouping is derived from RFC 4648. The use of VBMI follows Muła and
//! Lemire, "Base64 encoding and decoding at almost the speed of a memory copy",
//! https://arxiv.org/abs/1910.05109. Every masked load/store enables only bytes
//! inside the caller's slices. Padding and unused bits remain the caller's job.

#[cfg(target_arch = "x86")]
use core::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use core::arch::x86_64::*;

const STANDARD: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
const URL_SAFE: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
const MASK48: u64 = (1_u64 << 48) - 1;

const fn encode_indices() -> [u8; 64] {
    let mut indices = [0; 64];
    let mut lane = 0;
    while lane < 8 {
        // Each little-endian qword holds two big-endian 24-bit input words.
        let base = (lane * 6) as u8;
        indices[lane * 8] = base + 2;
        indices[lane * 8 + 1] = base + 1;
        indices[lane * 8 + 2] = base;
        indices[lane * 8 + 3] = base + 5;
        indices[lane * 8 + 4] = base + 4;
        indices[lane * 8 + 5] = base + 3;
        lane += 1;
    }
    indices
}

const fn decode_indices() -> [u8; 64] {
    let mut indices = [0; 64];
    let mut group = 0;
    while group < 16 {
        // Multiplication produces one big-endian 24-bit word per four bytes.
        indices[group * 3] = (group * 4 + 2) as u8;
        indices[group * 3 + 1] = (group * 4 + 1) as u8;
        indices[group * 3 + 2] = (group * 4) as u8;
        group += 1;
    }
    indices
}

const fn decode_table(alphabet: &[u8; 64]) -> [u8; 128] {
    let mut table = [128; 128];
    let mut i = 0;
    while i < 64 {
        table[alphabet[i] as usize] = i as u8;
        i += 1;
    }
    table
}

const ENCODE_INDICES: [u8; 64] = encode_indices();

const fn encode_offset(offset: u8) -> [u8; 64] {
    let mut indices = encode_indices();
    let mut i = 0;
    while i < 64 {
        indices[i] += offset;
        i += 1;
    }
    indices
}
const ENCODE_BULK_48: [u8; 64] = encode_offset(48);
const ENCODE_BULK_32: [u8; 64] = encode_offset(32);
const ENCODE_BULK_16: [u8; 64] = encode_offset(16);

const DECODE_INDICES: [u8; 64] = decode_indices();
const DECODE_STANDARD: [u8; 128] = decode_table(STANDARD);
const DECODE_URL: [u8; 128] = decode_table(URL_SAFE);

/// Encode whole three-byte quanta and return consumed input bytes.
///
/// # Safety
/// CPU/OS support for AVX512F, AVX512BW, and AVX512VBMI is required. XCR0 must
/// enable XMM, YMM, opmask, ZMM_Hi256, and Hi16_ZMM state. Slices need no padding.
#[target_feature(enable = "avx512f,avx512bw,avx512vbmi")]
pub(crate) unsafe fn encode(input: &[u8], output: &mut [u8], url: bool) -> usize {
    let alphabet = if url { URL_SAFE } else { STANDARD };
    // SAFETY: each constant has exactly the 64 bytes loaded here.
    let (alphabet, indices) = unsafe {
        (
            _mm512_loadu_si512(alphabet.as_ptr().cast()),
            _mm512_loadu_si512(ENCODE_INDICES.as_ptr().cast()),
        )
    };
    let shifts = _mm512_set1_epi64(i64::from_le_bytes([18, 12, 6, 0, 42, 36, 30, 24]));
    let mut i = 0;
    let mut o = 0;
    if input.len() >= 192 && output.len() >= 256 {
        // SAFETY: each permutation table contains exactly 64 bytes. Bulk-only
        // constants are prepared only when at least one complete block fits.
        let (indices48, indices32, indices16) = unsafe {
            (
                _mm512_loadu_si512(ENCODE_BULK_48.as_ptr().cast()),
                _mm512_loadu_si512(ENCODE_BULK_32.as_ptr().cast()),
                _mm512_loadu_si512(ENCODE_BULK_16.as_ptr().cast()),
            )
        };
        while input.len() - i >= 192 && output.len() - o >= 256 {
            // SAFETY: three exact 64-byte loads cover precisely 192 input bytes;
            // four 64-byte stores cover precisely the 256-byte output block.
            unsafe {
                let a = _mm512_loadu_si512(input.as_ptr().add(i).cast());
                let b = _mm512_loadu_si512(input.as_ptr().add(i + 64).cast());
                let c = _mm512_loadu_si512(input.as_ptr().add(i + 128).cast());
                let wa = _mm512_permutexvar_epi8(indices, a);
                let wb = _mm512_permutex2var_epi8(a, indices48, b);
                let wc = _mm512_permutex2var_epi8(b, indices32, c);
                let wd = _mm512_permutexvar_epi8(indices16, c);
                let a = _mm512_permutexvar_epi8(_mm512_multishift_epi64_epi8(shifts, wa), alphabet);
                let b = _mm512_permutexvar_epi8(_mm512_multishift_epi64_epi8(shifts, wb), alphabet);
                let c = _mm512_permutexvar_epi8(_mm512_multishift_epi64_epi8(shifts, wc), alphabet);
                let d = _mm512_permutexvar_epi8(_mm512_multishift_epi64_epi8(shifts, wd), alphabet);
                _mm512_storeu_si512(output.as_mut_ptr().add(o).cast(), a);
                _mm512_storeu_si512(output.as_mut_ptr().add(o + 64).cast(), b);
                _mm512_storeu_si512(output.as_mut_ptr().add(o + 128).cast(), c);
                _mm512_storeu_si512(output.as_mut_ptr().add(o + 192).cast(), d);
            }
            i += 192;
            o += 256;
        }
    }
    while input.len() - i >= 48 && output.len() - o >= 64 {
        // SAFETY: only the first 48 load lanes are enabled; the store has 64
        // writable bytes, established by the loop bounds.
        unsafe {
            let bytes = _mm512_maskz_loadu_epi8(MASK48, input.as_ptr().add(i).cast());
            let encoded = encode_vector(bytes, indices, shifts, alphabet);
            _mm512_storeu_si512(output.as_mut_ptr().add(o).cast(), encoded);
        }
        i += 48;
        o += 64;
    }
    if input.len() - i < 3 || output.len() - o < 4 {
        return i;
    }
    let groups = core::cmp::min((input.len() - i) / 3, (output.len() - o) / 4);
    if groups != 0 {
        // The preceding loop leaves at most 15 complete groups. Both shift
        // counts are therefore below 64, and enabled lanes fit the slices.
        let bytes = groups * 3;
        let encoded = groups * 4;
        // SAFETY: mask bits precisely delimit the remaining input and output.
        unsafe {
            let tail = _mm512_maskz_loadu_epi8((1_u64 << bytes) - 1, input.as_ptr().add(i).cast());
            let tail = encode_vector(tail, indices, shifts, alphabet);
            _mm512_mask_storeu_epi8(
                output.as_mut_ptr().add(o).cast(),
                (1_u64 << encoded) - 1,
                tail,
            );
        }
        i += bytes;
    }
    i
}

#[inline]
#[target_feature(enable = "avx512f,avx512bw,avx512vbmi")]
unsafe fn encode_vector(
    bytes: __m512i,
    indices: __m512i,
    shifts: __m512i,
    alphabet: __m512i,
) -> __m512i {
    let words = _mm512_permutexvar_epi8(indices, bytes);
    let sextets = _mm512_multishift_epi64_epi8(shifts, words);
    // VPERMB uses only the low six bits of each index, exactly one sextet.
    _mm512_permutexvar_epi8(sextets, alphabet)
}

/// Decode whole four-character quanta, returning input consumed or the earliest
/// invalid input offset. Only earlier validated groups may have been stored.
///
/// # Safety
/// CPU/OS support for AVX512F, AVX512BW, and AVX512VBMI is required, with the
/// complete AVX-512 state enabled in XCR0. Slices need no extra readable bytes.
#[target_feature(enable = "avx512f,avx512bw,avx512vbmi")]
pub(crate) unsafe fn decode(input: &[u8], output: &mut [u8], url: bool) -> Result<usize, usize> {
    let table = if url { &DECODE_URL } else { &DECODE_STANDARD };
    // SAFETY: both table halves and the permutation contain a full 64 bytes.
    let (low, high, indices) = unsafe {
        (
            _mm512_loadu_si512(table.as_ptr().cast()),
            _mm512_loadu_si512(table.as_ptr().add(64).cast()),
            _mm512_loadu_si512(DECODE_INDICES.as_ptr().cast()),
        )
    };
    let mut i = 0;
    let mut o = 0;
    while input.len() - i >= 256 && output.len() - o >= 192 {
        // SAFETY: the loop proves four complete 64-byte reads and four exact
        // 48-byte masked writes. Validate the entire group before any write.
        unsafe {
            let a = _mm512_loadu_si512(input.as_ptr().add(i).cast());
            let b = _mm512_loadu_si512(input.as_ptr().add(i + 64).cast());
            let c = _mm512_loadu_si512(input.as_ptr().add(i + 128).cast());
            let d = _mm512_loadu_si512(input.as_ptr().add(i + 192).cast());
            let va = _mm512_permutex2var_epi8(low, a, high);
            let vb = _mm512_permutex2var_epi8(low, b, high);
            let vc = _mm512_permutex2var_epi8(low, c, high);
            let vd = _mm512_permutex2var_epi8(low, d, high);
            let ea = _mm512_or_si512(a, va);
            let eb = _mm512_or_si512(b, vb);
            let ec = _mm512_or_si512(c, vc);
            let ed = _mm512_or_si512(d, vd);
            let errors = _mm512_or_si512(_mm512_or_si512(ea, eb), _mm512_or_si512(ec, ed));
            if _mm512_movepi8_mask(errors) != 0 {
                // Only invalid groups need individual masks. Search original
                // block order before taking the earliest bit in that block.
                for (block, errors) in [ea, eb, ec, ed].into_iter().enumerate() {
                    let mask = _mm512_movepi8_mask(errors);
                    if mask != 0 {
                        return Err(i + block * 64 + mask.trailing_zeros() as usize);
                    }
                }
                unreachable!("combined invalid mask has an invalid block");
            }
            let a = decode_vector(va, indices);
            let b = decode_vector(vb, indices);
            let c = decode_vector(vc, indices);
            let d = decode_vector(vd, indices);
            _mm512_mask_storeu_epi8(output.as_mut_ptr().add(o).cast(), MASK48, a);
            _mm512_mask_storeu_epi8(output.as_mut_ptr().add(o + 48).cast(), MASK48, b);
            _mm512_mask_storeu_epi8(output.as_mut_ptr().add(o + 96).cast(), MASK48, c);
            _mm512_mask_storeu_epi8(output.as_mut_ptr().add(o + 144).cast(), MASK48, d);
        }
        i += 256;
        o += 192;
    }
    if input.len() - i >= 128 && output.len() - o >= 96 {
        // SAFETY: two complete 64-byte reads and two exact 48-byte masked
        // writes fit. Neither block is written until both have been validated.
        unsafe {
            let a = _mm512_loadu_si512(input.as_ptr().add(i).cast());
            let b = _mm512_loadu_si512(input.as_ptr().add(i + 64).cast());
            let va = _mm512_permutex2var_epi8(low, a, high);
            let vb = _mm512_permutex2var_epi8(low, b, high);
            let ea = _mm512_or_si512(a, va);
            let eb = _mm512_or_si512(b, vb);
            if _mm512_movepi8_mask(_mm512_or_si512(ea, eb)) != 0 {
                let first = _mm512_movepi8_mask(ea);
                if first != 0 {
                    return Err(i + first.trailing_zeros() as usize);
                }
                return Err(i + 64 + _mm512_movepi8_mask(eb).trailing_zeros() as usize);
            }
            let a = decode_vector(va, indices);
            let b = decode_vector(vb, indices);
            _mm512_mask_storeu_epi8(output.as_mut_ptr().add(o).cast(), MASK48, a);
            _mm512_mask_storeu_epi8(output.as_mut_ptr().add(o + 48).cast(), MASK48, b);
        }
        i += 128;
        o += 96;
    }
    if input.len() - i >= 64 && output.len() - o >= 48 {
        // SAFETY: one complete read and exactly 48 enabled output bytes.
        unsafe {
            let chars = _mm512_loadu_si512(input.as_ptr().add(i).cast());
            let values = _mm512_permutex2var_epi8(low, chars, high);
            let invalid = _mm512_movepi8_mask(_mm512_or_si512(chars, values));
            if invalid != 0 {
                return Err(i + invalid.trailing_zeros() as usize);
            }
            let bytes = decode_vector(values, indices);
            _mm512_mask_storeu_epi8(output.as_mut_ptr().add(o).cast(), MASK48, bytes);
        }
        i += 64;
        o += 48;
    }
    if input.len() - i < 4 || output.len() - o < 3 {
        return Ok(i);
    }
    let groups = core::cmp::min((input.len() - i) / 4, (output.len() - o) / 3);
    if groups != 0 {
        let chars = groups * 4;
        let bytes = groups * 3;
        let mask = (1_u64 << chars) - 1;
        // SAFETY: at most 15 groups remain. The masks enable exactly the
        // readable/writable prefix; omitted lanes are excluded from validation.
        unsafe {
            let tail = _mm512_maskz_loadu_epi8(mask, input.as_ptr().add(i).cast());
            let values = _mm512_permutex2var_epi8(low, tail, high);
            let invalid = _mm512_movepi8_mask(_mm512_or_si512(tail, values)) & mask;
            if invalid != 0 {
                return Err(i + invalid.trailing_zeros() as usize);
            }
            let decoded = decode_vector(values, indices);
            _mm512_mask_storeu_epi8(
                output.as_mut_ptr().add(o).cast(),
                (1_u64 << bytes) - 1,
                decoded,
            );
        }
        i += chars;
    }
    Ok(i)
}

#[inline]
#[target_feature(enable = "avx512f,avx512bw,avx512vbmi")]
unsafe fn decode_vector(values: __m512i, indices: __m512i) -> __m512i {
    let pairs = _mm512_maddubs_epi16(values, _mm512_set1_epi32(0x0140_0140));
    let words = _mm512_madd_epi16(pairs, _mm512_set1_epi32(0x0001_1000));
    _mm512_permutexvar_epi8(indices, words)
}

#[cfg(all(test, not(miri)))]
#[path = "avx512_tests.rs"]
mod tests;
