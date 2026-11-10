#![deny(unsafe_op_in_unsafe_fn)]
mod baseline;
mod combined;
mod decode3;
mod encode3;
use std::{
    hint::black_box,
    io::{self, Write},
    time::Instant,
};
type Encoder = unsafe fn(&[u8], &mut [u8], bool) -> usize;
type Decoder = unsafe fn(&[u8], &mut [u8], bool) -> Result<usize, usize>;
struct Kernel {
    name: &'static str,
    encode: Encoder,
    decode: Decoder,
}
fn aligned_offset(bytes: &[u8], offset: usize) -> usize {
    (64 - bytes.as_ptr() as usize % 64) % 64 + offset
}
fn reference(input: &[u8], url: bool) -> Vec<u8> {
    let alphabet = if url {
        b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"
    } else {
        b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    };
    input
        .as_chunks::<3>()
        .0
        .iter()
        .flat_map(|g| {
            let word = u32::from(g[0]) << 16 | u32::from(g[1]) << 8 | u32::from(g[2]);
            [
                alphabet[(word >> 18) as usize],
                alphabet[((word >> 12) & 63) as usize],
                alphabet[((word >> 6) & 63) as usize],
                alphabet[(word & 63) as usize],
            ]
        })
        .collect()
}
fn main() {
    assert!(
        std::is_x86_feature_detected!("avx512f")
            && std::is_x86_feature_detected!("avx512bw")
            && std::is_x86_feature_detected!("avx512vbmi")
    );
    let kernels = [
        Kernel {
            name: "baseline",
            encode: baseline::encode,
            decode: baseline::decode,
        },
        Kernel {
            name: "encode3",
            encode: encode3::encode,
            decode: encode3::decode,
        },
        Kernel {
            name: "decode3",
            encode: decode3::encode,
            decode: decode3::decode,
        },
        Kernel {
            name: "combined",
            encode: combined::encode,
            decode: combined::decode,
        },
    ];
    let verify_only = std::env::args().any(|x| x == "--verify-only");
    let mut csv = io::BufWriter::new(io::stdout().lock());
    writeln!(csv,"operation,case,variant,binary_bytes,input_offset,output_offset,url,sample,iterations,elapsed_ns,ns_per_call").unwrap();
    for n in [
        24usize, 48, 96, 189, 192, 195, 384, 4095, 65535, 1048575, 4194303,
    ] {
        let iterations = match n {
            0..=195 => 100000,
            196..=384 => 50000,
            385..=4095 => 10000,
            4096..=65535 => 500,
            65536..=1048575 => 16,
            _ => 8,
        };
        let warmup = if n >= 65535 { 4 } else { 32 };
        let mut state = 0x932a_788a_d72e_3a5bu64;
        let input: Vec<u8> = (0..n)
            .map(|_| {
                state ^= state << 13;
                state ^= state >> 7;
                state ^= state << 17;
                state as u8
            })
            .collect();
        for url in [false, true] {
            let expected = reference(&input, url);
            for (input_offset, output_offset) in [(0, 0), (1, 1), (31, 47)] {
                let mut raw_storage = vec![0xa5; n + 128];
                let raw_start = aligned_offset(&raw_storage, input_offset);
                raw_storage[raw_start..raw_start + n].copy_from_slice(&input);
                let raw = &raw_storage[raw_start..raw_start + n];
                let mut text_storage = vec![0xa5; expected.len() + 128];
                let text_start = aligned_offset(&text_storage, input_offset);
                text_storage[text_start..text_start + expected.len()].copy_from_slice(&expected);
                let mut text_output = vec![0xa5; expected.len() + 128];
                let encoded_start = aligned_offset(&text_output, output_offset);
                let mut byte_output = vec![0xa5; n + 128];
                let decoded_start = aligned_offset(&byte_output, output_offset);
                for kernel in &kernels {
                    let used = unsafe {
                        (kernel.encode)(
                            raw,
                            &mut text_output[encoded_start..encoded_start + expected.len()],
                            url,
                        )
                    };
                    assert_eq!(used, n);
                    assert_eq!(
                        &text_output[encoded_start..encoded_start + expected.len()],
                        expected
                    );
                    let used = unsafe {
                        (kernel.decode)(
                            &text_storage[text_start..text_start + expected.len()],
                            &mut byte_output[decoded_start..decoded_start + n],
                            url,
                        )
                    };
                    assert_eq!(used, Ok(expected.len()));
                    assert_eq!(&byte_output[decoded_start..decoded_start + n], input);
                    for _ in 0..warmup {
                        black_box(unsafe {
                            (kernel.encode)(
                                black_box(raw),
                                black_box(
                                    &mut text_output[encoded_start..encoded_start + expected.len()],
                                ),
                                black_box(url),
                            )
                        });
                        let _ = black_box(unsafe {
                            (kernel.decode)(
                                black_box(&text_storage[text_start..text_start + expected.len()]),
                                black_box(&mut byte_output[decoded_start..decoded_start + n]),
                                black_box(url),
                            )
                        });
                    }
                }
                for sample in 0..if verify_only { 0 } else { 11 } {
                    for shift in 0..4 {
                        let kernel = &kernels[(sample + shift) % 4];
                        let out = &mut text_output[encoded_start..encoded_start + expected.len()];
                        let start = Instant::now();
                        let mut last = 0;
                        for _ in 0..iterations {
                            last = black_box(unsafe {
                                (kernel.encode)(
                                    black_box(raw),
                                    black_box(&mut *out),
                                    black_box(url),
                                )
                            });
                        }
                        let elapsed = start.elapsed().as_nanos();
                        assert_eq!(last, n);
                        assert_eq!(out, expected);
                        writeln!(csv,"encode,valid,{},{n},{input_offset},{output_offset},{url},{sample},{iterations},{elapsed},{}",kernel.name,elapsed as f64/iterations as f64).unwrap();
                    }
                }
                for case in ["valid", "invalid-head", "invalid-middle", "invalid-tail"] {
                    text_storage[text_start..text_start + expected.len()]
                        .copy_from_slice(&expected);
                    let bad = match case {
                        "invalid-head" => Some(0),
                        "invalid-middle" => Some(expected.len() / 2),
                        "invalid-tail" => Some(expected.len() - 1),
                        _ => None,
                    };
                    if let Some(index) = bad {
                        text_storage[text_start + index] = b'!';
                    }
                    let text = &text_storage[text_start..text_start + expected.len()];
                    let wanted = bad.map_or(Ok(expected.len()), Err);
                    for kernel in &kernels {
                        let out = &mut byte_output[decoded_start..decoded_start + n];
                        out.fill(0xa5);
                        assert_eq!(unsafe { (kernel.decode)(text, out, url) }, wanted);
                        for _ in 0..warmup {
                            let _ = black_box(unsafe {
                                (kernel.decode)(
                                    black_box(text),
                                    black_box(&mut *out),
                                    black_box(url),
                                )
                            });
                        }
                    }
                    for sample in 0..if verify_only { 0 } else { 11 } {
                        for shift in 0..4 {
                            let kernel = &kernels[(sample + shift) % 4];
                            let out = &mut byte_output[decoded_start..decoded_start + n];
                            out.fill(0xa5);
                            let start = Instant::now();
                            let mut last = Ok(0);
                            for _ in 0..iterations {
                                last = black_box(unsafe {
                                    (kernel.decode)(
                                        black_box(text),
                                        black_box(&mut *out),
                                        black_box(url),
                                    )
                                });
                            }
                            let elapsed = start.elapsed().as_nanos();
                            assert_eq!(last, wanted);
                            if let Some(index) = bad {
                                assert!(out[index / 4 * 3..].iter().all(|&b| b == 0xa5));
                            } else {
                                assert_eq!(out, input);
                            }
                            writeln!(csv,"decode,{case},{},{n},{input_offset},{output_offset},{url},{sample},{iterations},{elapsed},{}",kernel.name,elapsed as f64/iterations as f64).unwrap();
                        }
                    }
                }
                assert!(text_output[..encoded_start]
                    .iter()
                    .chain(&text_output[encoded_start + expected.len()..])
                    .all(|&b| b == 0xa5));
                assert!(byte_output[..decoded_start]
                    .iter()
                    .chain(&byte_output[decoded_start + n..])
                    .all(|&b| b == 0xa5));
            }
        }
    }
}
