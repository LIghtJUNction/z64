extern crate std;

use self::std::vec;
use self::std::vec::Vec;

fn reference(input: &[u8], url: bool) -> Vec<u8> {
    let alphabet = if url {
        b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"
    } else {
        b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    };
    let mut out = Vec::new();
    for chunk in input.as_chunks::<3>().0 {
        let n = u32::from(chunk[0]) << 16 | u32::from(chunk[1]) << 8 | u32::from(chunk[2]);
        for shift in [18, 12, 6, 0] {
            out.push(alphabet[((n >> shift) & 63) as usize]);
        }
    }
    out
}

type Encoder = unsafe fn(&[u8], &mut [u8], bool) -> usize;
type Decoder = unsafe fn(&[u8], &mut [u8], bool) -> Result<usize, usize>;

fn check(encode: Encoder, decode: Decoder, enc_block: usize, dec_block: usize) {
    for url in [false, true] {
        for n in 0..=257 {
            let input: Vec<u8> = (0..n).map(|i| (i * 73 + n * 17) as u8).collect();
            let expected = reference(&input, url);
            for offset in 0..32 {
                let mut aligned = vec![0xa5; n + offset];
                aligned[offset..].copy_from_slice(&input);
                let written = n / enc_block * (enc_block / 3 * 4);
                let mut output = vec![0xa5; offset + written + 17];
                // SAFETY: check is only called after a runtime ISA check.
                let consumed = unsafe {
                    encode(
                        &aligned[offset..],
                        &mut output[offset..offset + written],
                        url,
                    )
                };
                assert_eq!(consumed, n / enc_block * enc_block);
                assert_eq!(&output[offset..offset + written], &expected[..written]);
                assert!(
                    output[..offset]
                        .iter()
                        .chain(&output[offset + written..])
                        .all(|&b| b == 0xa5)
                );

                let consumed = expected.len() / dec_block * dec_block;
                let written = consumed / 4 * 3;
                let mut encoded = vec![0xa5; offset + expected.len()];
                encoded[offset..].copy_from_slice(&expected);
                let mut output = vec![0xa5; offset + written + 17];
                // SAFETY: check is only called after a runtime ISA check.
                assert_eq!(
                    unsafe {
                        decode(
                            &encoded[offset..],
                            &mut output[offset..offset + written],
                            url,
                        )
                    },
                    Ok(consumed)
                );
                assert_eq!(&output[offset..offset + written], &input[..written]);
                assert!(
                    output[..offset]
                        .iter()
                        .chain(&output[offset + written..])
                        .all(|&b| b == 0xa5)
                );
            }
        }
        for position in 0..dec_block * 2 {
            for byte in 0..=255 {
                let mut input = vec![b'A'; dec_block * 2];
                input[position] = byte;
                let mut output = vec![0xa5; dec_block / 4 * 3 * 2];
                // SAFETY: check is only called after a runtime ISA check.
                let result = unsafe { decode(&input, &mut output, url) };
                let valid = byte.is_ascii_alphanumeric()
                    || byte == if url { b'-' } else { b'+' }
                    || byte == if url { b'_' } else { b'/' };
                if valid {
                    assert_eq!(result, Ok(input.len()));
                } else {
                    assert_eq!(
                        result,
                        Err(position),
                        "byte {byte} at {position}, URL {url}"
                    );
                    let untouched = position / dec_block * (dec_block / 4 * 3);
                    assert!(output[untouched..].iter().all(|&b| b == 0xa5));
                }
            }
        }
    }
}

#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
#[test]
fn avx2_exact_slices_offsets_and_every_invalid_byte() {
    if std::is_x86_feature_detected!("avx2") {
        check(super::avx2::encode, super::avx2::decode, 24, 32);
    }
}

#[cfg(target_arch = "aarch64")]
#[test]
fn neon_exact_slices_offsets_and_every_invalid_byte() {
    if std::arch::is_aarch64_feature_detected!("neon") {
        check(super::neon::encode, super::neon::decode, 48, 64);
    }
}
