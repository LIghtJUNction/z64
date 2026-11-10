extern crate std;

use self::std::vec;
use self::std::vec::Vec;

fn available() -> bool {
    std::is_x86_feature_detected!("avx512f")
        && std::is_x86_feature_detected!("avx512bw")
        && std::is_x86_feature_detected!("avx512vbmi")
}

fn reference(input: &[u8], url: bool) -> Vec<u8> {
    let alphabet = if url {
        super::URL_SAFE
    } else {
        super::STANDARD
    };
    let mut out = Vec::new();
    for group in input.as_chunks::<3>().0 {
        let word = u32::from(group[0]) << 16 | u32::from(group[1]) << 8 | u32::from(group[2]);
        for shift in [18, 12, 6, 0] {
            out.push(alphabet[((word >> shift) & 63) as usize]);
        }
    }
    out
}

#[test]
fn exact_slices_offsets_masked_tails_and_bulk_boundaries() {
    if !available() {
        return;
    }
    for url in [false, true] {
        for n in 0..=577 {
            let binary: Vec<u8> = (0..n).map(|i| (i * 73 + n * 19) as u8).collect();
            let expected = reference(&binary, url);
            for offset in 0..64 {
                let mut input = vec![0xa5; offset + binary.len()];
                input[offset..].copy_from_slice(&binary);
                let mut encoded = vec![0xa5; offset + expected.len() + 17];
                // SAFETY: runtime detection establishes all required CPU/OS features.
                let used = unsafe {
                    super::encode(
                        &input[offset..],
                        &mut encoded[offset..offset + expected.len()],
                        url,
                    )
                };
                assert_eq!(used, n / 3 * 3);
                assert_eq!(&encoded[offset..offset + expected.len()], expected);
                assert!(encoded[..offset]
                    .iter()
                    .chain(&encoded[offset + expected.len()..])
                    .all(|&b| b == 0xa5));

                let mut decoded = vec![0xa5; offset + used + 17];
                // SAFETY: runtime detection establishes all required CPU/OS features.
                let result = unsafe {
                    super::decode(
                        &encoded[offset..offset + expected.len()],
                        &mut decoded[offset..offset + used],
                        url,
                    )
                };
                assert_eq!(result, Ok(expected.len()));
                assert_eq!(&decoded[offset..offset + used], &binary[..used]);
                assert!(decoded[..offset]
                    .iter()
                    .chain(&decoded[offset + used..])
                    .all(|&b| b == 0xa5));
            }
        }
    }
}

#[test]
fn every_byte_in_every_lane_and_partial_lane() {
    if !available() {
        return;
    }
    for url in [false, true] {
        for n in [4, 8, 28, 32, 60, 64, 68, 128, 252, 256, 260, 512] {
            for index in 0..n {
                for byte in 0..=255_u8 {
                    let mut input = vec![b'A'; n];
                    input[index] = byte;
                    let mut output = vec![0xa5; n / 4 * 3 + 17];
                    // SAFETY: runtime detection establishes all required CPU/OS features.
                    let result = unsafe { super::decode(&input, &mut output[..n / 4 * 3], url) };
                    let valid = byte.is_ascii_alphanumeric()
                        || byte == if url { b'-' } else { b'+' }
                        || byte == if url { b'_' } else { b'/' };
                    if valid {
                        assert_eq!(result, Ok(n));
                    } else {
                        assert_eq!(
                            result,
                            Err(index),
                            "byte {byte} at {index}, n={n}, URL={url}"
                        );
                        assert!(output[index / 4 * 3..].iter().all(|&b| b == 0xa5));
                    }
                    assert!(output[n / 4 * 3..].iter().all(|&b| b == 0xa5));
                }
            }
        }
    }
}

#[test]
fn earliest_error_and_short_output_are_bounded() {
    if !available() {
        return;
    }
    for first in 0..300 {
        let mut input = [b'A'; 320];
        input[first] = b'!';
        input[319] = 255;
        let mut output = [0xa5; 240];
        // SAFETY: runtime detection establishes all required CPU/OS features.
        assert_eq!(
            unsafe { super::decode(&input, &mut output, false) },
            Err(first)
        );
        assert!(output[first / 4 * 3..].iter().all(|&b| b == 0xa5));
    }
    for capacity in 0..260 {
        let input = [0x5a; 384];
        let mut output = vec![0xa5; capacity + 17];
        // SAFETY: kernels independently bound each memory operation by their slices.
        let used = unsafe { super::encode(&input, &mut output[..capacity], false) };
        assert_eq!(used, capacity / 4 * 3);
        assert!(output[used / 3 * 4..].iter().all(|&b| b == 0xa5));
        let input = [b'A'; 512];
        output.fill(0xa5);
        // SAFETY: kernels independently bound each memory operation by their slices.
        let used = unsafe { super::decode(&input, &mut output[..capacity], false) }.unwrap();
        assert_eq!(used, capacity / 3 * 4);
        assert!(output[used / 4 * 3..].iter().all(|&b| b == 0xa5));
    }
}
