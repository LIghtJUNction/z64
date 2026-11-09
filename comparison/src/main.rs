use std::hint::black_box;
use std::io::{self, Write};
use std::time::{Duration, Instant};
use z64_comparison::{
    mode_name, reference_encode, Codec, Codecs, Mode, Rejected, Rng, LENGTHS, MODES, SEED,
};

struct Options {
    smoke: bool,
    only_z64: bool,
    samples: usize,
    target: Duration,
    build: String,
}

fn options() -> Options {
    let mut options = Options {
        smoke: false,
        only_z64: false,
        samples: 7,
        target: Duration::from_millis(2),
        build: "unspecified".into(),
    };
    let mut args = std::env::args().skip(1);
    while let Some(arg) = args.next() {
        match arg.as_str() {
            "--smoke" => {
                options.smoke = true;
                options.samples = 1;
                options.target = Duration::from_micros(20);
            }
            "--only-z64" => options.only_z64 = true,
            "--samples" => options.samples = args.next().expect("sample count").parse().unwrap(),
            "--build" => options.build = args.next().expect("build label"),
            "--target-ns" => {
                options.target =
                    Duration::from_nanos(args.next().expect("sample duration").parse().unwrap())
            }
            _ => panic!("unknown argument: {arg}"),
        }
    }
    assert!(options.samples > 0 && !options.target.is_zero());
    assert!(options
        .build
        .chars()
        .all(|c| c.is_ascii_alphanumeric() || "-_.".contains(c)));
    options
}

struct Case<'a> {
    mode: Mode,
    raw: &'a [u8],
    text: &'a [u8],
    kind: &'static str,
    encode: bool,
}

fn sample<F: FnMut() -> Result<usize, Rejected>>(
    mut operation: F,
    options: &Options,
) -> Vec<(usize, u128)> {
    let warmup = if options.smoke {
        Duration::from_micros(5)
    } else {
        Duration::from_micros(250)
    };
    let start = Instant::now();
    let mut count = 0usize;
    while start.elapsed() < warmup {
        for _ in 0..16 {
            black_box(operation()).ok();
        }
        count += 16;
    }
    let elapsed = start.elapsed().as_nanos().max(1);
    let iterations =
        ((options.target.as_nanos() * count as u128 / elapsed).max(1) as usize).min(5_000_000);
    let mut result = Vec::with_capacity(options.samples);
    for _ in 0..options.samples {
        let start = Instant::now();
        for _ in 0..iterations {
            black_box(operation()).ok();
        }
        result.push((iterations, start.elapsed().as_nanos()));
    }
    result
}

fn run<C: Codec>(codec: &C, case: &Case<'_>, options: &Options, csv: &mut impl Write) {
    let capacity = if case.encode {
        case.text.len()
    } else {
        case.text.len().div_ceil(4) * 3
    };
    let mut output = vec![0xCCu8; capacity];
    let expected = if case.kind == "valid" {
        Ok(if case.encode {
            case.text.len()
        } else {
            case.raw.len()
        })
    } else {
        Err(Rejected)
    };
    let check = |result: Result<usize, Rejected>, output: &[u8]| {
        assert_eq!(
            result,
            expected,
            "{} {} {} {:?}",
            codec.name(),
            mode_name(case.mode),
            case.kind,
            &case.text[..case.text.len().min(64)]
        );
        if let Ok(length) = result {
            assert_eq!(
                &output[..length],
                if case.encode { case.text } else { case.raw },
                "{}",
                codec.name()
            );
        }
    };
    let samples = if case.encode {
        check(codec.encode(case.raw, &mut output), &output);
        let samples = sample(
            || codec.encode(black_box(case.raw), black_box(&mut output)),
            options,
        );
        check(codec.encode(case.raw, &mut output), &output);
        samples
    } else {
        check(codec.decode(case.text, &mut output), &output);
        let samples = sample(
            || codec.decode(black_box(case.text), black_box(&mut output)),
            options,
        );
        check(codec.decode(case.text, &mut output), &output);
        samples
    };
    for (index, (iterations, elapsed)) in samples.into_iter().enumerate() {
        let ns = elapsed as f64 / iterations as f64;
        // For invalid inputs the unconsumed suffix is not throughput. Keep latency only.
        let gbps = if case.kind == "valid" {
            format!("{:.9}", case.raw.len() as f64 / ns)
        } else {
            String::new()
        };
        writeln!(
            csv,
            "{},{},{},{},{},{},{},{},{},{},{:.6},{}",
            options.build,
            case.kind,
            mode_name(case.mode),
            case.raw.len(),
            if case.encode {
                case.raw.len()
            } else {
                case.text.len()
            },
            if case.encode { "encode" } else { "decode" },
            codec.name(),
            index,
            iterations,
            elapsed,
            ns,
            gbps
        )
        .unwrap();
    }
}

fn run_all(
    codecs: &Codecs,
    case: &Case<'_>,
    options: &Options,
    rotation: usize,
    csv: &mut impl Write,
) {
    if options.only_z64 {
        run(&codecs.z64, case, options, csv);
        return;
    }
    // Rotate independent implementations deterministically to reduce order/thermal bias.
    for index in 0..6 {
        match (index + rotation) % 6 {
            0 => run(&codecs.z64, case, options, csv),
            1 => run(&codecs.scalar, case, options, csv),
            2 => run(&codecs.vector, case, options, csv),
            3 => run(&codecs.simd, case, options, csv),
            4 => run(&codecs.turbo, case, options, csv),
            5 => run(&codecs.encodify, case, options, csv),
            _ => unreachable!(),
        }
    }
}

fn main() {
    let options = options();
    let lengths: &[usize] = if options.smoke {
        &[0, 1, 2, 3, 31, 32, 33, 4096]
    } else {
        LENGTHS
    };
    let mut rng = Rng::new(SEED);
    let stdout = io::stdout();
    let mut csv = io::BufWriter::new(stdout.lock());
    writeln!(csv, "build,case,mode,binary_bytes,input_bytes,operation,implementation,sample,iterations,elapsed_ns,ns_per_call,gb_per_s").unwrap();
    for (size_index, &length) in lengths.iter().enumerate() {
        let raw = rng.bytes(length);
        for (mode_index, mode) in MODES.into_iter().enumerate() {
            let text = reference_encode(&raw, mode);
            let codecs = Codecs::new(mode);
            for encode in [true, false] {
                let case = Case {
                    mode,
                    raw: &raw,
                    text: &text,
                    kind: "valid",
                    encode,
                };
                run_all(&codecs, &case, &options, size_index + mode_index, &mut csv);
            }
            if !text.is_empty() {
                for (kind, index) in [
                    ("invalid-head", 0),
                    ("invalid-middle", text.len() / 2),
                    ("invalid-tail", text.len() - 1),
                ] {
                    let mut invalid = text.clone();
                    invalid[index] = b'!';
                    let case = Case {
                        mode,
                        raw: &raw,
                        text: &invalid,
                        kind,
                        encode: false,
                    };
                    run_all(&codecs, &case, &options, size_index + mode_index, &mut csv);
                }
            }
        }
        csv.flush().unwrap();
        if !options.smoke {
            eprintln!("{}: measured {length} binary bytes", options.build);
        }
    }
}
