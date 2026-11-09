use z64::{decode, encode, encoded_len, Error, Mode};

#[test]
fn exact_allocations_offsets_and_error_tails() {
    for mode in [
        Mode::Standard,
        Mode::StandardNoPad,
        Mode::UrlSafe,
        Mode::UrlSafeNoPad,
    ] {
        for len in [
            0, 1, 2, 3, 4, 23, 24, 25, 31, 32, 33, 47, 48, 49, 63, 64, 65, 97,
        ] {
            let input: Vec<u8> = (0..len).map(|n| (n * 37) as u8).collect();
            for offset in [0, 1, 7] {
                let n = encoded_len(len, mode).unwrap();
                let mut text = vec![0xa5; n + offset];
                assert_eq!(encode(&input, &mut text[offset..], mode), Ok(n));
                let mut output = vec![0xa5; len + offset];
                assert_eq!(
                    decode(&text[offset..], &mut output[offset..], mode),
                    Ok(len)
                );
                assert_eq!(&output[offset..], input);
                assert!(text[..offset]
                    .iter()
                    .chain(&output[..offset])
                    .all(|&b| b == 0xa5));
                if n >= 4 {
                    text[offset] = 0xff;
                    assert_eq!(
                        decode(&text[offset..], &mut output[offset..], mode),
                        Err(Error::InvalidByte {
                            index: 0,
                            byte: 0xff
                        })
                    );
                }
            }
        }
    }
    let mut out = [0xa5; 4];
    assert_eq!(
        decode(b"AAAB", &mut out[..2], Mode::Standard),
        Err(Error::OutputTooSmall { required: 3 })
    );
    assert_eq!(
        decode(b"AAB=", &mut out, Mode::Standard),
        Err(Error::NonCanonical { index: 2 })
    );
    assert_eq!(out, [0xa5; 4]);
}
