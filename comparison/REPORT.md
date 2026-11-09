# Performance result — 2026-11-09, second optimization round

**The new implementation substantially improves the previous z64, while the
2x target against the strongest current competitor remains unmet.** The fixed
primary workloads show old/current paired geometric means of 2.034x encoding
and 1.644x decoding for a generic build, and 2.215x / 1.629x for a native build.
94 of 96 primary paired medians favor the new version. One external-comparison
median crosses 2x in a visibly noisy case; it does not establish a reliable
2x advantage. Short-input, large-buffer and early-error losses are retained.

## Source and measurement scope

The measured source is
[`08affc4e90f07e1dc90709fdb0eb8b4bb1431889`](https://github.com/LIghtJUNction/z64/commit/08affc4e90f07e1dc90709fdb0eb8b4bb1431889).
The previous version,
[`d91c6bfbc447061ab4fd2f04feeb65045a6de329`](https://github.com/LIghtJUNction/z64/commit/d91c6bfbc447061ab4fd2f04feeb65045a6de329),
is a pinned dependency in the same benchmark binary. Both receive identical
compiler flags, input bytes, output capacities and output alignment. The new
code adds AVX-512 VBMI, improves AVX2 encoding and caches the selected backend.
A single 32-character decode body uses AVX2 to avoid the wider kernel's setup
cost. The published crate still uses only `core`; competitor dependencies
remain in the separate, unpublished comparison workspace.

The [recorded host](results/20261109-final-xeon8573c/environment.txt) is an
Intel Xeon Platinum 8573C with AVX2 and AVX-512 VBMI. Runs use logical CPU 2,
Rust 1.99.1 / LLVM 23.1.1, optimization level 3, fat LTO and one codegen unit.
Native builds additionally use `-C target-cpu=native`. This is a shared VM:
exclusive CPU time and stable frequency were unavailable, and cgroup CPU
throttling counters were unreadable. These diagnostic measurements do not
establish dedicated-hardware results or a hardware-independent speed guarantee.

The [predefined manifest](workloads.json) fixes six primary sizes, four modes
and separate encode/decode operations: 24 cases per operation per build,
96 total. The full sweep includes 34 lengths from zero through 4 MiB, vector
boundaries and invalid characters at the head, middle and tail. Seven samples
rotate implementation order after warmup. Each old/current case uses the
median of ratios paired by sample index; tables aggregate cases with an
equally weighted geometric mean. These are warmed-call, reused-buffer results.

## Improvement over the previous z64

Ratios use old latency divided by current latency, so values above 1 favor
current z64. Each entry aggregates all four modes, including losses.

| Binary bytes | Generic encode | Generic decode | Native encode | Native decode |
|---|---:|---:|---:|---:|
| 32 | 1.24x | 1.16x | 1.43x | 1.19x |
| 128 | 1.77x | 1.49x | 1.64x | 1.47x |
| 4,096 | 5.04x | 2.84x | 5.76x | 2.50x |
| 65,536 | 3.25x | 2.24x | 3.45x | 1.94x |
| 1,048,576 | 1.57x | 1.41x | 2.22x | 1.97x |
| 4,194,304 | 1.25x | 1.28x | 1.14x | 1.12x |
| All primary cases | 2.034x | 1.644x | 2.215x | 1.629x |

The 4 KiB improvement repeats across modes, generic/native builds and the
[preceding frozen-source matrix](results/20261109-round2-xeon8573c/summary.md).
Multi-MiB results are less stable: native Standard 4 MiB encoding and decoding
have paired ratios of 0.692x and 0.456x, while one native 1 MiB decoding case
reaches 6.747x with a 0.260–11.855x sample-pair range. Those extremes remain
in the aggregates. Memory traffic, cache state and scheduling can limit or
obscure conversion-loop gains; this experiment does not isolate their costs.
The [complete summary](results/20261109-final-xeon8573c/summary.md) and
[paired table](results/20261109-final-xeon8573c/paired.csv.gz) contain every mode.

## Comparison with current competitors

The baselines are base64 0.23.1's scalar and SIMD engines, base64-simd 0.8.0,
base64-turbo 0.6.0 and encodify 1.0.2. Versions were checked against the
crates.io sparse index on the measurement date and locked. Every engine uses
the same strict alphabet, padding and unused-bit acceptance rules. Output is
preallocated and starts on a 64-byte boundary: exact encoded capacity for
encoding, the same rounded safe bound for every decoder. Guard bytes stay
outside the passed slices. Allocation, preparation and content checks occur
outside timing; `black_box` covers inputs and results. The
[protocol and source links](README.md) document these choices.

Here the numerator is the fastest external competitor's median latency for
that exact case, and the denominator is current z64's median latency. The
previous z64 is excluded from external competitor selection.

| Build | Operation | Cases | Medians at least 2x | Geometric mean ratio | Case range |
|---|---|---:|---:|---:|---:|
| Generic | Encode | 24 | 0 | 0.949x | 0.420–1.188x |
| Generic | Decode | 24 | 0 | 0.857x | 0.505–1.098x |
| Native | Encode | 24 | 1 | 0.895x | 0.282–2.213x |
| Native | Decode | 24 | 0 | 0.921x | 0.520–1.608x |

The sole 2.213x case is native StandardNoPad encoding at 4 MiB. Its fastest
competitor's samples range from 0.310 to 20.964 ms, and z64's from 0.321 to
2.302 ms. The preceding full matrix had zero cases reaching 2x. This isolated
crossing is reported transparently, without treating host noise as a speed
claim. Across the fixed set, z64 remains generally slower than the strongest
baseline. base64-turbo wins most primary cases; base64-simd and encodify win
others. The research goal remains unmet without relaxing validation.

## Ablations and remaining regressions

These controls compare z64's own builds. They are separate process runs,
unlike the paired old/current comparison, and are more exposed to temporal
noise. Ratios above 1 favor the second build. Except for the last row, each
operation aggregates its 24 primary cases.

| Change | Encode ratio | Decode ratio |
|---|---:|---:|
| Reference → lookup/SWAR scalar | 2.095x | 6.944x |
| Scalar → AVX2 dispatch | 5.103x | 5.050x |
| AVX2 dispatch → default VBMI dispatch | 1.456x | 1.673x |
| Generic → native compilation | 0.999x | 1.045x |
| Native → native with runtime detection disabled | 1.038x | 1.025x |
| Short bypass disabled → enabled, 52 cases per operation | 1.194x | 1.168x |

The large scalar/SIMD changes support retaining optimized conversion paths.
Small native and dispatch differences do not establish independent benefits:
the short-path case ratios span 0.545–3.945x for encoding and 0.527–13.317x for
decoding. Its preceding-matrix aggregate ratios were only 1.033x / 1.015x.
Native compilation already resolves the backend from target features, making
its runtime-detection-disabled row an equivalence control. Rejected candidates
and raw measurements remain in the [AVX2](results/avx2-study/),
[AVX-512](results/avx512-study/) and [scalar](results/scalar-study/) studies.

Across all 544 valid paired cases, 84 have ratios below 1 and four below 0.8.
The initial wide-kernel version regressed at 24- and 25-byte decoding in every
mode; these lengths pass one 32-character body to the SIMD decoder. The narrow
AVX2 route reduced that regression. In this final matrix, generic 24/25-byte
decode aggregates are 0.906x / 0.948x, while native is 1.035x / 0.982x. Generic
24-byte decoding therefore remains slower. The
[initial review](results/20261109-round2-xeon8573c/short-routing.md) and
[19-sample focused check](results/round2-routing-recovery/review.md) preserve
all modes, contradictory observations and the additional 26-byte probe.
Unchanged scalar paths also exhibit outliers; no uniform short-input win is claimed.

Rejected inputs have a distinct tradeoff. Across 132 cases per error position
and build, old/current geometric mean ratios for head errors are 0.911x
generic and 0.849x native. Middle errors improve to 1.225x / 1.185x, and tail
errors to 1.526x / 1.574x. These rows report latency only, because early rejection
does not process the remaining suffix. Wider setup cost is a plausible cause
of the head-error regression, not an isolated measurement of that cost.

## Validation and reproduction

Six independent differential test groups passed on the final source before
measurement, including all one- and two-byte inputs, fixed-seed random cases,
padding combinations, every byte replacement at boundaries, canonical tails
and mode separation. Each measured case also checks results and output guards.
The [final-source CI run](https://github.com/LIghtJUNction/z64/actions/runs/42659907982)
passed all ten jobs, including actual x86 AVX2/AVX-512 tests on MSRV 1.89,
AArch64 NEON, Miri and bare-metal compilation. Shared-runner benchmark smoke
output is not used for these performance conclusions.

Run `Z64_BENCH_CPU=2 bash comparison/run.sh results/local`, choosing an allowed
CPU and a new output directory. The
[final result directory](results/20261109-final-xeon8573c/) preserves **88,844
raw samples** across seven builds, plus compiler/hardware information,
dependencies, exact commands, workload manifest and the differential log.
CSV files are losslessly gzip-compressed; `gzip -dc file.csv.gz` recovers every
row. Valid throughput always uses original binary bytes. No AArch64 speed
advantage is claimed from this x86 run. The
[first-round results](results/20261109-xeon8573c/),
[intermediate matrix](results/20261109-round2-xeon8573c/) and development trials
remain separate from this final-source matrix.
