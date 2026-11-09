use z64::{decode, decoded_capacity, encode, encoded_len, Error, Mode};

const MODES: [Mode; 4] = [
    Mode::Standard,
    Mode::StandardNoPad,
    Mode::UrlSafe,
    Mode::UrlSafeNoPad,
];
const STANDARD: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
const URL: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";

fn padded(mode: Mode) -> bool {
    matches!(mode, Mode::Standard | Mode::UrlSafe)
}
fn alphabet(mode: Mode) -> &'static [u8; 64] {
    if matches!(mode, Mode::UrlSafe | Mode::UrlSafeNoPad) {
        URL
    } else {
        STANDARD
    }
}

// Independent bit accumulator: deliberately does not use three-byte quanta,
// the library's lookup table, or any of its length/decoding helpers.
fn reference_encode(input: &[u8], mode: Mode) -> Vec<u8> {
    let mut result = Vec::new();
    let mut bits = 0u32;
    let mut count = 0;
    for &byte in input {
        bits = (bits << 8) | u32::from(byte);
        count += 8;
        while count >= 6 {
            count -= 6;
            result.push(alphabet(mode)[((bits >> count) & 63) as usize]);
        }
    }
    if count != 0 {
        result.push(alphabet(mode)[((bits << (6 - count)) & 63) as usize]);
    }
    if padded(mode) {
        while result.len() % 4 != 0 {
            result.push(b'=');
        }
    }
    result
}

fn reference_decode(input: &[u8], mode: Mode) -> Option<Vec<u8>> {
    let pad_start = input.iter().position(|&b| b == b'=').unwrap_or(input.len());
    let pad_count = input.len() - pad_start;
    if padded(mode) {
        if input.len() % 4 != 0 || pad_count > 2 || input[pad_start..].iter().any(|&b| b != b'=') {
            return None;
        }
    } else if pad_count != 0 || input.len() % 4 == 1 {
        return None;
    }
    let data = &input[..pad_start];
    if data.len() % 4 == 1 {
        return None;
    }
    let mut result = Vec::new();
    let mut bits = 0u32;
    let mut count = 0;
    for byte in data {
        let value = alphabet(mode).iter().position(|c| c == byte)? as u32;
        bits = (bits << 6) | value;
        count += 6;
        if count >= 8 {
            count -= 8;
            result.push((bits >> count) as u8);
        }
    }
    if bits & ((1 << count) - 1) != 0 {
        return None;
    }
    if reference_encode(&result, mode) != input {
        return None;
    }
    Some(result)
}

fn check(input: &[u8], mode: Mode) {
    let expected = reference_encode(input, mode);
    assert_eq!(encoded_len(input.len(), mode), Some(expected.len()));
    let mut encoded = vec![0xa5; expected.len() + 7];
    assert_eq!(encode(input, &mut encoded, mode), Ok(expected.len()));
    assert_eq!(&encoded[..expected.len()], expected);
    assert_eq!(&encoded[expected.len()..], &[0xa5; 7]);
    let mut decoded = vec![0xa5; input.len() + 7];
    assert_eq!(
        decode(&expected, &mut decoded[..input.len()], mode),
        Ok(input.len())
    );
    assert_eq!(&decoded[..input.len()], input);
    assert_eq!(&decoded[input.len()..], &[0xa5; 7]);
}

#[test]
fn rfc4648_vectors() {
    let vectors: &[(&[u8], &[u8])] = &[
        (b"", b""),
        (b"f", b"Zg=="),
        (b"fo", b"Zm8="),
        (b"foo", b"Zm9v"),
        (b"foob", b"Zm9vYg=="),
        (b"fooba", b"Zm9vYmE="),
        (b"foobar", b"Zm9vYmFy"),
    ];
    for &(plain, text) in vectors {
        for mode in MODES {
            let n = if padded(mode) {
                text.len()
            } else {
                text.iter().position(|&b| b == b'=').unwrap_or(text.len())
            };
            let mut out = [0; 16];
            assert_eq!(encode(plain, &mut out, mode), Ok(n));
            assert_eq!(&out[..n], &text[..n]);
            assert_eq!(decode(&text[..n], &mut out, mode), Ok(plain.len()));
            assert_eq!(&out[..plain.len()], plain);
        }
    }
}

#[test]
fn all_single_and_double_bytes_against_independent_reference() {
    for mode in MODES {
        check(&[], mode);
        for a in 0..=255 {
            check(&[a], mode);
            for b in 0..=255 {
                check(&[a, b], mode);
            }
        }
    }
}

#[test]
fn all_padding_placements_and_impossible_lengths() {
    for mode in MODES {
        for len in 0..=12 {
            for mask in 0..(1 << len) {
                let text: Vec<u8> = (0..len)
                    .map(|i| if mask & (1 << i) == 0 { b'A' } else { b'=' })
                    .collect();
                let expected = reference_decode(&text, mode);
                let mut out = [0xa5; 12];
                match expected {
                    Some(bytes) => {
                        assert_eq!(
                            decode(&text, &mut out, mode),
                            Ok(bytes.len()),
                            "{mode:?} {text:?}"
                        );
                        assert_eq!(&out[..bytes.len()], bytes);
                    }
                    None => assert!(decode(&text, &mut out, mode).is_err(), "{mode:?} {text:?}"),
                }
            }
        }
    }
}

#[test]
fn rejects_every_nonzero_unused_bit_pattern() {
    for mode in MODES {
        for byte in 0..=255 {
            let mut text = reference_encode(&[byte], mode);
            let canonical = (byte & 3) << 4;
            for bits in 1..16 {
                text[1] = alphabet(mode)[(canonical | bits) as usize];
                let mut out = [0xa5; 3];
                assert_eq!(
                    decode(&text, &mut out, mode),
                    Err(Error::NonCanonical { index: 1 })
                );
                assert_eq!(out, [0xa5; 3]);
            }
            let mut text = reference_encode(&[byte, byte], mode);
            let canonical = (byte & 15) << 2;
            for bits in 1..4 {
                text[2] = alphabet(mode)[(canonical | bits) as usize];
                let mut out = [0xa5; 3];
                assert_eq!(
                    decode(&text, &mut out, mode),
                    Err(Error::NonCanonical { index: 2 })
                );
                assert_eq!(out, [0xa5; 3]);
            }
        }
    }
}

#[test]
fn alphabet_and_padding_modes_are_explicit() {
    for mode in MODES {
        let other_alphabet: &[u8] = if matches!(mode, Mode::Standard | Mode::StandardNoPad) {
            b"-_"
        } else {
            b"+/"
        };
        for &byte in other_alphabet {
            let mut text = *b"AAAA";
            text[0] = byte;
            assert_eq!(
                decode(&text, &mut [0; 3], mode),
                Err(Error::InvalidByte { index: 0, byte })
            );
        }
        for text in [b"Zg".as_slice(), b"Zm8".as_slice()] {
            assert_eq!(decode(text, &mut [0; 3], mode).is_ok(), !padded(mode));
        }
        for text in [b"Zg==".as_slice(), b"Zm8=".as_slice()] {
            assert_eq!(decode(text, &mut [0; 3], mode).is_ok(), padded(mode));
        }
        assert_eq!(decode(b"Zm9v", &mut [0; 3], mode), Ok(3));
    }
}

#[test]
fn error_precedence_positions_and_write_bounds() {
    for mode in MODES {
        let mut out = [0xa5; 8];
        assert_eq!(
            decode(b"?", &mut out[..0], mode),
            Err(Error::InvalidLength { index: 1 })
        );
        assert_eq!(
            decode(b"?AAA", &mut out[..2], mode),
            Err(Error::OutputTooSmall { required: 3 })
        );
        assert_eq!(out, [0xa5; 8]);
        for input in [b"?=AA".as_slice(), b"=?AA".as_slice()] {
            let err = if input[0] == b'=' {
                Error::InvalidPadding { index: 0 }
            } else {
                Error::InvalidByte {
                    index: 0,
                    byte: b'?',
                }
            };
            assert_eq!(decode(input, &mut out, mode), Err(err));
            assert_eq!(out, [0xa5; 8]);
        }
        for index in 0..128 {
            for byte in 0..=255 {
                if alphabet(mode).contains(&byte) {
                    continue;
                }
                // A trailing '=' may be valid padding, so force it to be interior.
                let mut text = [b'A'; 132];
                text[index] = byte;
                let mut output = [0xa5; 104];
                let expected = if byte == b'=' {
                    Error::InvalidPadding { index }
                } else {
                    Error::InvalidByte { index, byte }
                };
                assert_eq!(decode(&text, &mut output, mode), Err(expected));
                assert!(output[(index / 4) * 3..].iter().all(|&b| b == 0xa5));
            }
        }
    }
}

#[test]
fn insufficient_capacity_is_atomic() {
    for mode in MODES {
        for len in 1..100 {
            let input = vec![42; len];
            let text = reference_encode(&input, mode);
            let mut output = vec![0xa5; text.len()];
            for capacity in 0..text.len() {
                assert_eq!(
                    encode(&input, &mut output[..capacity], mode),
                    Err(Error::OutputTooSmall {
                        required: text.len()
                    })
                );
                assert!(output.iter().all(|&b| b == 0xa5));
            }
            for capacity in 0..len {
                assert_eq!(
                    decode(&text, &mut output[..capacity], mode),
                    Err(Error::OutputTooSmall { required: len })
                );
                assert!(output.iter().all(|&b| b == 0xa5));
            }
        }
    }
}

fn random(state: &mut u64) -> u8 {
    *state ^= *state << 13;
    *state ^= *state >> 7;
    *state ^= *state << 17;
    *state as u8
}

#[test]
fn random_reference_offsets_vector_boundaries_and_large_buffers() {
    let mut state = 0x5a36_4b1d_c0de_0042;
    let mut lengths: Vec<usize> = (0..=260).collect();
    lengths.extend([
        511, 512, 513, 1023, 1024, 1025, 4095, 4096, 4097, 65535, 65536, 1048576,
    ]);
    for len in lengths {
        let input: Vec<u8> = (0..len).map(|_| random(&mut state)).collect();
        for mode in MODES {
            let expected = reference_encode(&input, mode);
            let offsets = if len <= 260 { 32 } else { 1 };
            for offset in 0..offsets {
                let mut aligned_input = vec![0xa5; offset];
                aligned_input.extend_from_slice(&input);
                let mut text = vec![0xa5; offset + expected.len() + 9];
                let n = encode(
                    &aligned_input[offset..],
                    &mut text[offset..offset + expected.len()],
                    mode,
                )
                .unwrap();
                assert_eq!(&text[offset..offset + n], expected);
                assert!(text[..offset].iter().all(|&b| b == 0xa5));
                assert!(text[offset + n..].iter().all(|&b| b == 0xa5));
                let mut output = vec![0xa5; offset + len + 9];
                assert_eq!(
                    decode(
                        &text[offset..offset + n],
                        &mut output[offset..offset + len],
                        mode
                    ),
                    Ok(len)
                );
                assert_eq!(&output[offset..offset + len], input);
                assert!(output[..offset].iter().all(|&b| b == 0xa5));
                assert!(output[offset + len..].iter().all(|&b| b == 0xa5));
            }
        }
    }
}

#[test]
fn lengths_are_overflow_safe() {
    for mode in MODES {
        assert_eq!(encoded_len(0, mode), Some(0));
        assert_eq!(encoded_len(usize::MAX, mode), None);
        let groups = usize::MAX / 4;
        assert_eq!(encoded_len(groups * 3, mode), Some(groups * 4));
        for n in 0..100 {
            assert!(encoded_len(n, mode).unwrap() >= n);
            assert!(decoded_capacity(n).unwrap() <= n);
        }
    }
    assert_eq!(decoded_capacity(usize::MAX), Some((usize::MAX / 4) * 3 + 2));
}
