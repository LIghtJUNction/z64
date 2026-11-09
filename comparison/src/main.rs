use std::hint::black_box;
use std::io::{self, Write};
use std::time::{Duration, Instant};
use z64_comparison::{
    mode_name, reference_encode, Codec, Codecs, Mode, Rejected, Rng, LENGTHS, MODES, SEED,
};

struct Options {
    smoke: bool,
    quick: bool,
    valid_only: bool,
    only_z64: bool,
    pair_only: bool,
    before_only: bool,
    samples: usize,
    target: Duration,
    build: String,
}

fn options() -> Options {
    let mut options = Options {
        smoke: false,
        quick: false,
        valid_only: false,
        only_z64: false,
        pair_only: false,
        before_only: false,
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
            "--quick" => options.quick = true,
            "--valid-only" => options.valid_only = true,
            "--only-z64" => options.only_z64 = true,
            "--pair-only" => options.pair_only = true,
            "--before-only" => options.before_only = true,
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
    assert!(
        u8::from(options.only_z64) + u8::from(options.pair_only) + u8::from(options.before_only)
            <= 1
    );
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

fn calibrate<F: FnMut() -> Result<usize, Rejected>>(mut operation: F, options: &Options) -> usize {
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
    ((options.target.as_nanos() * count as u128 / elapsed).max(1) as usize).min(5_000_000)
}

struct Prepared<'a, C> {
    codec: &'a C,
    output: Vec<u8>,
    start: usize,
    end: usize,
    iterations: usize,
}

impl<'a, C: Codec> Prepared<'a, C> {
    fn new(codec: &'a C, case: &Case<'_>, options: &Options) -> Self {
        let capacity = if case.encode {
            case.text.len()
        } else {
            case.text.len().div_ceil(4) * 3
        };
        let output = vec![0xCCu8; capacity + 63];
        let start = (64 - (output.as_ptr() as usize & 63)) & 63;
        let mut state = Self {
            codec,
            output,
            start,
            end: start + capacity,
            iterations: 0,
        };
        state.check(case);
        state.iterations = if case.encode {
            calibrate(
                || {
                    codec.encode(
                        black_box(case.raw),
                        black_box(&mut state.output[state.start..state.end]),
                    )
                },
                options,
            )
        } else {
            calibrate(
                || {
                    codec.decode(
                        black_box(case.text),
                        black_box(&mut state.output[state.start..state.end]),
                    )
                },
                options,
            )
        };
        state.check(case);
        state
    }

    fn check(&mut self, case: &Case<'_>) {
        let result = if case.encode {
            self.codec
                .encode(case.raw, &mut self.output[self.start..self.end])
        } else {
            self.codec
                .decode(case.text, &mut self.output[self.start..self.end])
        };
        let expected = if case.kind == "valid" {
            Ok(if case.encode {
                case.text.len()
            } else {
                case.raw.len()
            })
        } else {
            Err(Rejected)
        };
        assert_eq!(
            result,
            expected,
            "{} {} {} {:?}",
            self.codec.name(),
            mode_name(case.mode),
            case.kind,
            &case.text[..case.text.len().min(64)]
        );
        assert!(
            self.output[..self.start]
                .iter()
                .chain(self.output[self.end..].iter())
                .all(|&byte| byte == 0xCC),
            "{} wrote outside the passed slice",
            self.codec.name()
        );
        if let Ok(length) = result {
            assert_eq!(
                &self.output[self.start..self.start + length],
                if case.encode { case.text } else { case.raw },
                "{}",
                self.codec.name()
            );
        }
    }

    fn sample(&mut self, case: &Case<'_>, options: &Options, index: usize, csv: &mut impl Write) {
        let elapsed = if case.encode {
            let start = Instant::now();
            for _ in 0..self.iterations {
                black_box(self.codec.encode(
                    black_box(case.raw),
                    black_box(&mut self.output[self.start..self.end]),
                ))
                .ok();
            }
            start.elapsed().as_nanos()
        } else {
            let start = Instant::now();
            for _ in 0..self.iterations {
                black_box(self.codec.decode(
                    black_box(case.text),
                    black_box(&mut self.output[self.start..self.end]),
                ))
                .ok();
            }
            start.elapsed().as_nanos()
        };
        self.check(case);
        let ns = elapsed as f64 / self.iterations as f64;
        // Early rejection does not process the remaining suffix: report latency only.
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
            self.codec.name(),
            index,
            self.iterations,
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
    if options.before_only {
        let mut before = Prepared::new(&codecs.before, case, options);
        for index in 0..options.samples {
            before.sample(case, options, index, csv);
        }
        return;
    }
    let mut current = Prepared::new(&codecs.z64, case, options);
    if options.only_z64 {
        for index in 0..options.samples {
            current.sample(case, options, index, csv);
        }
        return;
    }
    let mut before = Prepared::new(&codecs.before, case, options);
    if options.pair_only {
        for index in 0..options.samples {
            if (index + rotation).is_multiple_of(2) {
                current.sample(case, options, index, csv);
                before.sample(case, options, index, csv);
            } else {
                before.sample(case, options, index, csv);
                current.sample(case, options, index, csv);
            }
        }
        return;
    }
    let mut scalar = Prepared::new(&codecs.scalar, case, options);
    let mut vector = Prepared::new(&codecs.vector, case, options);
    let mut simd = Prepared::new(&codecs.simd, case, options);
    let mut turbo = Prepared::new(&codecs.turbo, case, options);
    let mut encodify = Prepared::new(&codecs.encodify, case, options);
    // Interleave each sample across implementations, rotating order. Old/new
    // share one binary, compiler, inputs, flags and equally sized output slices.
    for sample in 0..options.samples {
        for index in 0..7 {
            match (index + rotation + sample) % 7 {
                0 => current.sample(case, options, sample, csv),
                1 => before.sample(case, options, sample, csv),
                2 => scalar.sample(case, options, sample, csv),
                3 => vector.sample(case, options, sample, csv),
                4 => simd.sample(case, options, sample, csv),
                5 => turbo.sample(case, options, sample, csv),
                6 => encodify.sample(case, options, sample, csv),
                _ => unreachable!(),
            }
        }
    }
}

fn main() {
    let options = options();
    let lengths: &[usize] = if options.smoke {
        &[0, 1, 2, 3, 31, 32, 33, 4096]
    } else if options.quick {
        &[
            0, 1, 2, 3, 15, 16, 17, 23, 24, 25, 31, 32, 33, 47, 48, 49, 63, 64, 65, 95, 96, 97,
            127, 128, 129, 4096, 1048576,
        ]
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
            if !options.valid_only && !text.is_empty() {
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
