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
unsafe fn encode_inner<const URL: bool>(input: &[u8], output: &mut [u8]) -> usize {
    // SAFETY: the entrypoint requires AVX2; this only constructs a register constant.
    let alphabet_offsets = unsafe {
        _mm256_setr_epi8(
            65,
            71,
            -4,
            -4,
            -4,
            -4,
            -4,
            -4,
            -4,
            -4,
            -4,
            -4,
            if URL { -17 } else { -19 },
            if URL { 32 } else { -16 },
            0,
            0,
            65,
            71,
            -4,
            -4,
            -4,
            -4,
            -4,
            -4,
            -4,
            -4,
            -4,
            -4,
            if URL { -17 } else { -19 },
            if URL { 32 } else { -16 },
            0,
            0,
        )
    };
    // SAFETY: the entrypoint requires AVX2; this only constructs a register constant.
    let shuffle = unsafe {
        _mm256_setr_epi8(
            1, 0, 2, 1, 4, 3, 5, 4, 7, 6, 8, 7, 10, 9, 11, 10, 1, 0, 2, 1, 4, 3, 5, 4, 7, 6, 8, 7,
            10, 9, 11, 10,
        )
    };
    let multiply_hi = core::hint::black_box(unsafe { _mm256_set1_epi32(0x0400_0040) });
    let multiply_lo = core::hint::black_box(unsafe { _mm256_set1_epi32(0x0100_0010) });
    let mut i = 0;
    let mut o = 0;
    while input.len() - i >= 24 && output.len() - o >= 32 {
        // SAFETY: the loop proves both 16-byte loads (0..16, 8..24) and
        // the 32-byte store are in-bounds; their addresses need no alignment.
        unsafe {
            let lo = _mm_loadu_si128(input.as_ptr().add(i).cast());
            let hi = _mm_loadu_si128(input.as_ptr().add(i + 8).cast());
            let joined = _mm256_set_m128i(_mm_srli_si128::<4>(hi), lo);
            let groups = _mm256_shuffle_epi8(joined, shuffle);
            let even = _mm256_mulhi_epu16(
                _mm256_and_si256(groups, _mm256_set1_epi32(0x0fc0_fc00)),
                multiply_hi,
            );
            let odd = _mm256_mullo_epi16(
                _mm256_and_si256(groups, _mm256_set1_epi32(0x003f_03f0)),
                multiply_lo,
            );
            let sextets = _mm256_or_si256(even, odd);
            // The lookup indices are 0 for A..Z, 1 for a..z, 2..11 for
            // digits, 12 and 13 for the alphabet's final two characters.
            let ranges = _mm256_sub_epi8(
                _mm256_subs_epu8(sextets, _mm256_set1_epi8(51)),
                _mm256_cmpgt_epi8(sextets, _mm256_set1_epi8(25)),
            );
            let encoded = _mm256_add_epi8(sextets, _mm256_shuffle_epi8(alphabet_offsets, ranges));
            _mm256_storeu_si256(output.as_mut_ptr().add(o).cast(), encoded);
        }
        i += 24;
        o += 32;
    }
    i
}


#[target_feature(enable="avx2")]
pub(crate) unsafe fn encode(input:&[u8],output:&mut[u8],url:bool)->usize {
    unsafe { if url { encode_inner::<true>(input,output) } else { encode_inner::<false>(input,output) } }
}
