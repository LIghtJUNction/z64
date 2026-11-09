use z64_comparison::{reference_decode, reference_encode, Codecs, Mode, Rng, LENGTHS, MODES, SEED};

fn decode_case(input: &[u8], mode: Mode, codecs: &Codecs) {
    let expected = reference_decode(input, mode);
    for codec in codecs.all() {
        let capacity = input.len().div_ceil(4) * 3;
        let mut output = vec![0xA5; capacity + 64];
        let result = codec.decode(input, &mut output[31..31 + capacity]);
        assert_eq!(
            result.is_ok(),
            expected.is_ok(),
            "{} {mode:?} {input:?}",
            codec.name()
        );
        if let (Ok(length), Ok(bytes)) = (result, &expected) {
            assert_eq!(&output[31..31 + length], bytes, "{}", codec.name());
        }
        assert!(output[..31]
            .iter()
            .chain(output[31 + capacity..].iter())
            .all(|&b| b == 0xA5));
    }
}

fn encode_case(input: &[u8], mode: Mode, codecs: &Codecs) {
    let expected = reference_encode(input, mode);
    for codec in codecs.all() {
        let mut output = vec![0xA5; expected.len() + 64];
        let length = codec
            .encode(input, &mut output[17..17 + expected.len()])
            .unwrap();
        assert_eq!(
            &output[17..17 + length],
            expected,
            "{} {mode:?}",
            codec.name()
        );
        assert!(output[..17]
            .iter()
            .chain(output[17 + expected.len()..].iter())
            .all(|&b| b == 0xA5));
    }
    decode_case(&expected, mode, codecs);
}

#[test]
fn all_one_and_two_byte_inputs_match_independent_reference_and_competitors() {
    for mode in MODES {
        let codecs = Codecs::new(mode);
        encode_case(&[], mode, &codecs);
        for first in 0..=255 {
            encode_case(&[first], mode, &codecs);
            for second in 0..=255 {
                encode_case(&[first, second], mode, &codecs);
            }
        }
    }
}

#[test]
fn fixed_seed_random_boundaries_offsets_and_large_buffers() {
    let mut rng = Rng::new(SEED);
    for mode in MODES {
        let codecs = Codecs::new(mode);
        for length in (0..=256).chain(LENGTHS.iter().copied()) {
            let input = rng.bytes(length + 63);
            // Exact-size outputs and non-aligned input starts exercise vector tails.
            encode_case(&input[31..31 + length], mode, &codecs);
        }
    }
}

#[test]
fn all_padding_positions_and_counts() {
    for mode in MODES {
        let codecs = Codecs::new(mode);
        for length in 0..=10 {
            for bits in 0..(1 << length) {
                let input: Vec<_> = (0..length)
                    .map(|i| if bits & (1 << i) != 0 { b'=' } else { b'A' })
                    .collect();
                decode_case(&input, mode, &codecs);
            }
        }
    }
}

#[test]
fn every_byte_at_every_short_position_and_vector_boundary() {
    let mut rng = Rng::new(SEED);
    for mode in MODES {
        let codecs = Codecs::new(mode);
        for length in [1, 2, 3, 16, 23, 24, 25, 47, 48, 49, 96, 128] {
            let text = reference_encode(&rng.bytes(length), mode);
            for index in 0..text.len() {
                for value in 0..=255 {
                    let mut changed = text.clone();
                    changed[index] = value;
                    decode_case(&changed, mode, &codecs);
                }
            }
        }
    }
}

#[test]
fn canonical_tail_bits_and_mode_separation() {
    for mode in MODES {
        let codecs = Codecs::new(mode);
        for text in [
            b"Zg==".as_slice(),
            b"Zh==",
            b"Zm8=",
            b"Zm9=",
            b"Zg",
            b"Zh",
            b"Zm8",
            b"Zm9",
            b"+///",
            b"-___",
            b"+___",
            b"-///",
            b"AA A",
            b"AA\nA",
            b"AA\rA",
            b"AA\tA",
        ] {
            decode_case(text, mode, &codecs);
        }
    }
}

#[test]
fn long_invalid_inputs_at_head_middle_and_tail() {
    let mut rng = Rng::new(SEED);
    for mode in MODES {
        let codecs = Codecs::new(mode);
        for length in [4096, 65536, 1048576] {
            let text = reference_encode(&rng.bytes(length), mode);
            for index in [
                0,
                1,
                31,
                32,
                63,
                64,
                text.len() / 2,
                text.len() - 2,
                text.len() - 1,
            ] {
                for byte in [b'!', b'=', b' ', b'\n', 0, 0x80, 0xFF] {
                    let mut changed = text.clone();
                    changed[index] = byte;
                    decode_case(&changed, mode, &codecs);
                }
            }
        }
    }
}
