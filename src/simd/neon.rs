use core::arch::aarch64::*;

const STANDARD: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
const URL_SAFE: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";

/// Encode complete 48-byte blocks, returning the number of input bytes used.
///
/// # Safety
/// The CPU and OS must support NEON. No padding outside either slice is needed.
#[target_feature(enable = "neon")]
pub(crate) unsafe fn encode(input: &[u8], output: &mut [u8], url: bool) -> usize {
    let alphabet = if url { URL_SAFE } else { STANDARD };
    // SAFETY: alphabet contains all 64 bytes loaded by the four vectors.
    let table = unsafe {
        uint8x16x4_t(
            vld1q_u8(alphabet.as_ptr()),
            vld1q_u8(alphabet.as_ptr().add(16)),
            vld1q_u8(alphabet.as_ptr().add(32)),
            vld1q_u8(alphabet.as_ptr().add(48)),
        )
    };
    let mut i = 0;
    let mut o = 0;
    while input.len() - i >= 48 && output.len() - o >= 64 {
        // SAFETY: vld3q reads exactly 48 bytes and vst4q writes exactly 64;
        // the loop bounds establish both ranges, with no alignment requirement.
        unsafe {
            let bytes = vld3q_u8(input.as_ptr().add(i));
            let a = vshrq_n_u8::<2>(bytes.0);
            let b = vorrq_u8(
                vandq_u8(vshlq_n_u8::<4>(bytes.0), vdupq_n_u8(48)),
                vshrq_n_u8::<4>(bytes.1),
            );
            let c = vorrq_u8(
                vandq_u8(vshlq_n_u8::<2>(bytes.1), vdupq_n_u8(60)),
                vshrq_n_u8::<6>(bytes.2),
            );
            let d = vandq_u8(bytes.2, vdupq_n_u8(63));
            vst4q_u8(
                output.as_mut_ptr().add(o),
                uint8x16x4_t(
                    vqtbl4q_u8(table, a),
                    vqtbl4q_u8(table, b),
                    vqtbl4q_u8(table, c),
                    vqtbl4q_u8(table, d),
                ),
            );
        }
        i += 48;
        o += 64;
    }
    i
}

/// Decode complete 64-character blocks, returning input consumed or the first
/// invalid input offset. Only preceding, validated blocks may have been written.
///
/// # Safety
/// The CPU and OS must support NEON. No padding outside either slice is needed.
#[target_feature(enable = "neon")]
pub(crate) unsafe fn decode(input: &[u8], output: &mut [u8], url: bool) -> Result<usize, usize> {
    // SAFETY: this entrypoint has the same NEON contract as either specialization.
    unsafe {
        if url {
            decode_inner::<true>(input, output)
        } else {
            decode_inner::<false>(input, output)
        }
    }
}

#[target_feature(enable = "neon")]
unsafe fn decode_inner<const URL: bool>(input: &[u8], output: &mut [u8]) -> Result<usize, usize> {
    let high_table = [
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
    ];
    let low_table = if URL {
        [
            21, 17, 17, 17, 17, 17, 17, 17, 17, 17, 19, 59, 59, 58, 59, 51,
        ]
    } else {
        [
            21, 17, 17, 17, 17, 17, 17, 17, 17, 17, 19, 26, 27, 27, 27, 26,
        ]
    };
    let offsets = [
        0,
        0,
        if URL { 17 } else { 19 },
        4,
        191,
        191,
        185,
        185,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
    ];
    // SAFETY: each table contains exactly the 16 bytes read by vld1q_u8.
    let (hi, lo, offsets) = unsafe {
        (
            vld1q_u8(high_table.as_ptr()),
            vld1q_u8(low_table.as_ptr()),
            vld1q_u8(offsets.as_ptr()),
        )
    };
    let mut i = 0;
    let mut o = 0;
    while input.len() - i >= 64 && output.len() - o >= 48 {
        // SAFETY: the loop proves the exact 64-byte load and 48-byte store.
        // Conversion and validation are fused; invalid blocks are not stored.
        unsafe {
            let chars = vld4q_u8(input.as_ptr().add(i));
            let (a, ea) = map::<URL>(chars.0, hi, lo, offsets);
            let (b, eb) = map::<URL>(chars.1, hi, lo, offsets);
            let (c, ec) = map::<URL>(chars.2, hi, lo, offsets);
            let (d, ed) = map::<URL>(chars.3, hi, lo, offsets);
            let invalid = vorrq_u8(vorrq_u8(ea, eb), vorrq_u8(ec, ed));
            if vmaxvq_u8(invalid) != 0 {
                // Preserve source order after the deinterleaved validation.
                // This bounded rescan is only reached for an invalid block.
                for (j, &byte) in input[i..i + 64].iter().enumerate() {
                    let valid = byte.is_ascii_alphanumeric()
                        || byte == if URL { b'-' } else { b'+' }
                        || byte == if URL { b'_' } else { b'/' };
                    if !valid {
                        return Err(i + j);
                    }
                }
                unreachable!("SIMD validation agrees with the Base64 alphabet");
            }
            vst3q_u8(
                output.as_mut_ptr().add(o),
                uint8x16x3_t(
                    vorrq_u8(vshlq_n_u8::<2>(a), vshrq_n_u8::<4>(b)),
                    vorrq_u8(vshlq_n_u8::<4>(b), vshrq_n_u8::<2>(c)),
                    vorrq_u8(vshlq_n_u8::<6>(c), d),
                ),
            );
        }
        i += 64;
        o += 48;
    }
    Ok(i)
}

#[inline]
#[target_feature(enable = "neon")]
#[allow(unused_unsafe)] // Register-only NEON operations are unsafe on Rust 1.70.
unsafe fn map<const URL: bool>(
    chars: uint8x16_t,
    high_table: uint8x16_t,
    low_table: uint8x16_t,
    offsets: uint8x16_t,
) -> (uint8x16_t, uint8x16_t) {
    // SAFETY: the enclosing function requires NEON; these operate only on registers.
    unsafe {
        let high = vshrq_n_u8::<4>(chars);
        let low = vandq_u8(chars, vdupq_n_u8(15));
        let invalid = vandq_u8(vqtbl1q_u8(high_table, high), vqtbl1q_u8(low_table, low));
        let special = vceqq_u8(chars, vdupq_n_u8(if URL { b'_' } else { b'/' }));
        let correction = vandq_u8(special, vdupq_n_u8(if URL { 33 } else { 253 }));
        let values = vaddq_u8(vaddq_u8(chars, vqtbl1q_u8(offsets, high)), correction);
        (values, invalid)
    }
}
