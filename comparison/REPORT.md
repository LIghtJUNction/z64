# Performance result — 2026-11-10: token decoding

**This iteration improves many short decoding cases. It does not establish a
broad throughput increase, and the 2x target against the strongest current
competitor remains unmet: zero of 96 primary comparisons reaches 2x.** The
complete fixed matrix and both focused probes retain every regression.

## What changed and what is compared

The measured source is
[`7194d6bdc7148dc33a80678decf0301a2984d051`](https://github.com/LIghtJUNction/z64/commit/7194d6bdc7148dc33a80678decf0301a2984d051).
The previous version is the last delivered commit,
[`cda77a6bd866be19831decc420e95a5a5bd79e75`](https://github.com/LIghtJUNction/z64/commit/cda77a6bd866be19831decc420e95a5a5bd79e75),
pinned as a dependency in the same benchmark binary. This comparison measures
only the new iteration. The
[previous round's report](https://github.com/LIghtJUNction/z64/blob/cda77a6bd866be19831decc420e95a5a5bd79e75/comparison/REPORT.md)
uses an older baseline and remains separate.

Two decoding changes were accepted. The public API skips the scalar body helper
when SIMD has already consumed the complete body. The scalar loop obtains a
fixed eight-byte input chunk, allowing the compiler to remove eight repeated
input bounds checks while preserving the inverse tables, SWAR arithmetic,
validation boundary and two output stores. Encoding and the SIMD kernels are
unchanged; encoding measurements serve as controls.

The [accepted scalar study](results/20261110-scalar-chunks-study/README.md)
retains the assembly comparison, exact-output/error equivalence checks and all
560 timing samples. Its twenty valid direct-kernel cases have a 1.077x paired
geometric mean, including a 0.979x regression. The
[guard-only probe](results/20261110-noop-tail-probe/review.md) and
[combined API probe](results/20261110-combined-tail-swar-probe/review.md) each
retain 9,856 samples. Rejected
[direct scalar packing](results/20261110-scalar-direct-study/study.json) and
[AVX-512 bulk packing](results/20261110-vbmi-bulk-study/README.md) are also
archived. The bulk proposals repeatedly regress 4,095-byte cases, so fewer
loads/stores did not justify replacing the production kernels.

## Complete fixed primary workloads

The [manifest](results/20261110-final-xeon8573c/workloads.json) fixes six primary
sizes, four modes and separate encode/decode operations: 24 cases per operation
per build, 96 total. Both versions share compiler flags, inputs, output
capacities and output alignment. Each case uses the median of seven old/current
latency ratios paired by sample index. Each table entry below is the equally
weighted geometric mean across all four modes; values above 1 favor current z64.

| Binary bytes | Generic encode control | Generic decode | Native encode control | Native decode |
|---|---:|---:|---:|---:|
| 32 | 0.991x | 1.046x | 0.980x | 1.083x |
| 128 | 1.057x | 1.127x | 0.988x | 1.168x |
| 4,096 | 1.003x | 0.996x | 0.995x | 1.107x |
| 65,536 | 0.991x | 1.000x | 0.993x | 0.973x |
| 1,048,576 | 0.986x | 0.916x | 1.072x | 1.035x |
| 4,194,304 | 1.078x | 1.028x | 1.006x | 1.080x |
| All primary cases | 1.017x | 1.017x | 1.005x | 1.073x |

Sixteen of 24 generic and seventeen of 24 native primary decoding medians favor
the new version. The generic aggregate matches the unchanged encoding control,
and large-buffer results vary in direction. These results support a focused
short-input change rather than an unconditional percentage improvement.
The [complete summary](results/20261110-final-xeon8573c/summary.md) and
[paired table](results/20261110-final-xeon8573c/paired.csv.gz) preserve every mode.

Short lengths outside the primary set provide useful scope. Final 24-byte decode
aggregates are 1.178x generic / 1.292x native, and 25-byte aggregates are
1.199x / 1.308x; every mode improves at both lengths in both builds. The combined
focused probe also improves all modes at 15, 16, 17, 23, 24, 25 and 26 bytes.
Three-byte decoding is less stable: its final aggregates are 1.304x / 1.075x,
whereas the combined probe measured 0.966x / 0.994x and the guard-only probe
0.914x / 0.912x. These observations remain visible instead of being treated as
a uniformly resolved small-input regression.

Across all 272 valid decode cases in the full sweep, 34 paired medians regress.
Examples include generic StandardNoPad at 1 MiB, 0.787x; generic URL-safe at
1 MiB, 0.844x; and generic URL-safe at 33 bytes, 0.792x. Encoding controls also
scatter substantially: generic StandardNoPad encoding at three bytes measures
0.370x despite unchanged encoding source. Scheduling and code-layout effects
are possible contributors; this experiment does not isolate them.

Rejected-input latency is reported separately. Each position has 132 cases per
build. Early rejection does not process the suffix, so these rows have no
throughput figure.

| Invalid-byte position | Generic old/current ratio | Native old/current ratio |
|---|---:|---:|
| Head | 1.052x | 1.108x |
| Middle | 1.008x | 1.072x |
| Tail | 0.953x | 1.064x |

The generic tail-error aggregate regresses. All error cases and ranges remain
in the paired table; successful-input gains are not substituted for rejection
performance.

## Strongest external implementation

The baseline versions were freshly checked on 2026-11-10 against their primary
crates.io sparse indexes: base64 0.23.1, base64-simd 0.8.0, base64-turbo 0.6.0 and
encodify 1.0.2. base64's scalar and SIMD engines are measured separately. The
[version record](results/20261110-final-xeon8573c/baseline-versions.json) preserves
URLs, timestamps and checksums. Every engine passes the same strict alphabet,
padding and unused-bit acceptance gate.

For each case below, the numerator is the fastest external implementation's
median latency and the denominator is current z64's median latency. The previous
z64 is excluded from external rankings.

| Build | Operation | Cases | At least 2x | Geometric mean ratio | Case range |
|---|---|---:|---:|---:|---:|
| Generic | Encode | 24 | 0 | 0.921x | 0.744–1.159x |
| Generic | Decode | 24 | 0 | 0.888x | 0.635–1.281x |
| Native | Encode | 24 | 0 | 0.915x | 0.564–1.164x |
| Native | Decode | 24 | 0 | 0.876x | 0.609–1.523x |

z64 remains generally slower than the strongest competitor. No primary case
reaches the 2x research target, and no validation was removed to improve ranking.

## Implementation controls

The seven builds also compare retained implementations and dispatch settings.
These separate-process ablations are more exposed to temporal drift than the
same-binary paired comparison. They describe the current implementation's
components, not the marginal gain of this iteration alone.

| Change | Encode ratio | Decode ratio |
|---|---:|---:|
| Reference → lookup/SWAR scalar | 1.561x | 5.206x |
| Scalar → AVX2 dispatch | 5.397x | 5.499x |
| AVX2 dispatch → default VBMI dispatch | 1.342x | 1.574x |
| Generic → native compilation | 1.047x | 1.016x |
| Native → native with runtime detection disabled | 0.937x | 0.975x |
| Short bypass disabled → enabled | 0.874x | 1.031x |

All rows use 24 primary cases per operation except the short-path row, which
uses 52 predefined short cases. Its per-case ratios span 0.385–2.216x encoding
and 0.254–4.839x decoding, so it does not establish a general dispatch benefit.
Native target features already resolve backend selection, making its detection
control an equivalence check. The full summary retains every ablation range.

## Conditions, validation and reproduction

The [environment record](results/20261110-final-xeon8573c/environment.txt) identifies
an Intel Xeon Platinum 8573C, logical CPU 2, Rust 1.99.1 / LLVM 23.1.1,
optimization level 3, fat LTO and one codegen unit. Native adds
`-C target-cpu=native`. This is a shared VM with no exclusive-hardware or fixed
frequency guarantee; cgroup throttling counters were unavailable. No AArch64
performance conclusion follows from this x86 run.

The [protocol](README.md) uses fixed seeds, warmup, rotating implementation
order, `black_box`, reused buffers and checks outside timing. All output slices
start on a 64-byte boundary. Encoders receive exact encoded capacity; decoders
receive the same rounded safe bound. Guard bytes are outside those slices.
Valid throughput uses original binary bytes, and allocation/preparation are
excluded. These are warmed-call measurements.

All six differential groups and the provenance checks passed before timing.
Every measured case passed result and guard checks. The
[final-source CI run](https://github.com/LIghtJUNction/z64/actions/runs/42750973566)
passed all ten jobs, including actual x86 AVX2/VBMI and AArch64 NEON on stable
and MSRV, Miri, bare-metal compilation, zero-dependency/package checks and a
publish dry run. CI smoke timing is not used in these conclusions.

The [full result directory](results/20261110-final-xeon8573c/) preserves exactly
**88,844 raw samples**: 32,732 each for generic/native and 4,676 for each of five
controls. An [independent completeness check](results/20261110-final-xeon8573c/completeness-check.json)
verified every expected case, implementation and sample identity: 668 cases
per implementation, seven samples per case, with no missing, unexpected or
duplicate identities. Postprocessing now also checks full-run completeness
and labels focused probes by their actual scope. No measurement was discarded
or rerun for that correction.

To reproduce the exact measured code, use the recorded source commit in a
clean checkout and run `Z64_BENCH_CPU=2 bash comparison/run.sh results/local`,
choosing an allowed CPU and a new output directory. Commands, lockfile,
workloads, version checks and all raw rows are retained. CSV files use lossless
gzip; `gzip -dc file.csv.gz` recovers their complete contents.
