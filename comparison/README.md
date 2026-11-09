# Reproducible comparison

This separate Cargo workspace is unpublished and excluded from the `z64` package.
It compares caller-provided output slices under the same strict RFC 4648 rules.
The current baselines were checked against the crates.io sparse index on 2026-11-09:

| Crate | Version | Engines measured |
|---|---|---|
| base64 | 0.23.1 | GeneralPurpose scalar and runtime-dispatched Simd |
| base64-simd | 0.8.0 | Strict standard/URL-safe, padded/unpadded |
| base64-turbo | 0.6.0 | Strict engines; all supported automatic SIMD paths |
| encodify | 1.0.2 | Strict standard/URL-safe, padded/unpadded |

`base64` gained SIMD engines after 0.22.1. Comparing only its older scalar engine
would misrepresent the current baseline. `base64-turbo` and `encodify` are included
because their published benchmarks identify them as stronger SIMD candidates.
Their published speed claims are not reused as z64 measurements.

The previous z64 implementation is pinned to Git commit
`d91c6bfbc447061ab4fd2f04feeb65045a6de329` as the `z64-before` dependency. Old and
current implementations are linked into the same benchmark binary and receive
the same compiler flags, input bytes and output capacities. The old version is
reported separately from external competitor rankings.

## Run

Use current stable Rust: the newest comparison dependencies require Rust 1.93,
independently of z64's MSRV.

```sh
cargo test --manifest-path comparison/Cargo.toml --locked
cargo run --release --manifest-path comparison/Cargo.toml --locked -- --smoke
Z64_BENCH_CPU=2 bash comparison/run.sh results/local
```

Choose a CPU in the process's allowed affinity set. For performance conclusions,
run on an otherwise idle fixed machine with stable power/governor settings;
record those conditions. A shared CI runner is suitable for smoke checks only.
`run.sh` records hardware, affinity, toolchain, flags, source commit/status,
dependency versions, commands, the workload manifest and all raw CSV samples.
Raw tables are saved as lossless `.csv.gz` files. Read them with `gzip -dc`,
Python's `gzip.open`, or any gzip reader; no samples are dropped.
The optional affinity setting requires Linux `taskset`.
The runner records cgroup CPU counters before and after the matrix when they
are readable, and records their absence explicitly when they are unavailable.

`workloads.json` fixes the workloads before measurements. They include empty and
1–3 byte inputs, common token lengths, vector boundaries, 4 KiB through 4 MiB,
all four modes, and illegal bytes at the head, middle and tail. Encoders and
decoders are measured separately. Valid-input GB/s uses binary bytes per second;
invalid-input rows report latency, because an early rejection does not process
the remaining suffix.

## Fairness and validation

Every engine checks canonical unused bits, exact padding rules and its selected
alphabet. No whitespace stripping or forgiving decoding is timed. Output is
preallocated before timing: exact encoded size for encoding, and the same
rounded decoded upper bound for every decoder (required by base64-turbo's slice
API). Engine setup, input generation, reference output, allocation and result
comparison are outside the timer. Inputs, output references and results pass
through `black_box`. Every case is checked before and after measurement.
All output slices start at a 64-byte-aligned address. Allocation reserves up to
63 guard bytes outside the passed slice solely to choose that alignment;
codecs still receive exactly the same capacity and no extra tail padding.
Canary checks verify that every implementation stays within its passed slice.

An independent bit-buffer reference verifies all single- and double-byte inputs,
fixed-seed random and large buffers, all short padding combinations, every byte
replacement at short/vector boundaries, canonical tails and alphabet separation.
Any semantic disagreement fails the gate rather than silently removing a loser.
Error *acceptance* and successful bytes are compared; competitors use different
error types and priority rules.

The harness warms each case, calibrates iterations, records seven samples and
interleaves implementations within each sample while rotating their order.
Old/new paired ratios match the same sample index, reducing temporal drift.
Input and output buffers are reused, so these are warm
buffer measurements, not cold-cache or concurrent-throughput measurements.
All libraries share `opt-level=3`, fat LTO and one
codegen unit. Generic and `target-cpu=native` builds are separate. The scalar,
reference, compile-time-dispatch and short-path-disabled builds isolate z64 implementation choices;
these ablations do not disable competitor validation or widen their buffers.

`summarize.py` retains every competitor and every workload. Its primary summary
uses the strongest measured competitor independently for each mode, size and
operation. The target is a 2x ratio on the predefined primary set; report any
miss directly. `no-short-path` measures the cost of dispatch for short inputs;
the rest of the algorithm and its validation remain identical.

## Sources

- [RFC 4648](https://www.rfc-editor.org/rfc/rfc4648.html)
- [base64 release notes](https://docs.rs/crate/base64/0.23.1/source/RELEASE-NOTES.md)
- [base64 Simd engine](https://docs.rs/base64/0.23.1/base64/engine/simd/struct.Simd.html)
- [base64-simd documentation](https://docs.rs/base64-simd/0.8.0/base64_simd/)
- [base64-turbo source](https://docs.rs/crate/base64-turbo/0.6.0/source/)
- [encodify strict modes](https://docs.rs/encodify/1.0.2/encodify/base64/)
- [Sparse index: base64](https://index.crates.io/ba/se/base64)
- [Sparse index: base64-simd](https://index.crates.io/ba/se/base64-simd)
- [Sparse index: base64-turbo](https://index.crates.io/ba/se/base64-turbo)
- [Sparse index: encodify](https://index.crates.io/en/co/encodify)
