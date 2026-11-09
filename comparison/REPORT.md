# Performance result — 2026-11-09

**The 2x research target was not met. z64 was generally slower than the strongest
current baseline.** None of the 96 primary comparisons reached 2x: each build
has 24 encode and 24 decode cases, comprising six sizes and four modes. Every
competitor, loss and invalid-input measurement is retained.

## Scope and evidence

The measured source is commit
[`3efb106e87868b33b48b7e54aaa0e5f926b56d50`](https://github.com/LIghtJUNction/z64/commit/3efb106e87868b33b48b7e54aaa0e5f926b56d50).
The host reports an Intel Xeon Platinum 8573C with AVX2 and AVX-512 VBMI. Runs
were pinned to logical CPU 2 using Rust 1.99.1 / LLVM 23.1.1, optimization level
3, fat LTO and one codegen unit. This is a shared virtual machine; exclusive CPU
time and fixed frequency were unavailable. These are diagnostic measurements,
not a hardware-independent speed guarantee or a dedicated-hardware result.

The predefined primary sizes are 32, 128, 4,096, 65,536, 1,048,576 and 4,194,304
binary bytes. The complete sweep includes 34 lengths, all four modes, seven
samples per case, and illegal characters at the head, middle and tail. Six
independent differential test groups passed before timing, including all
single- and double-byte inputs and strict malformed-input checks. The
[associated CI run](https://github.com/LIghtJUNction/z64/actions/runs/42647263424)
also covers the repository's correctness gates; CI smoke measurements are not
used in the tables below.

## Comparison with the strongest baseline

For each case, the denominator is z64's median latency and the numerator is the
fastest competitor's median latency. Ratios above 1 favor z64; below 1 favor the
competitor. The competitors are base64 0.23.1's scalar and SIMD engines,
base64-simd 0.8.0, base64-turbo 0.6.0 and encodify 1.0.2. All enforce the same
alphabet, padding and unused-bit acceptance rules and receive equally sized,
preallocated output buffers.

| Build | Operation | Primary cases | Cases at least 2x | Geometric mean ratio | Ratio range |
|---|---|---:|---:|---:|---:|
| Generic | Encode | 24 | 0 | 0.481x | 0.195–0.896x |
| Generic | Decode | 24 | 0 | 0.512x | 0.209–0.928x |
| Native | Encode | 24 | 0 | 0.422x | 0.147–0.854x |
| Native | Decode | 24 | 0 | 0.559x | 0.289–1.011x |

Current SIMD competitors set a substantially stronger baseline than historical
scalar-only comparisons. base64-turbo wins most primary cases on this host;
encodify and base64-simd win some large-buffer and short-token cases. z64's
x86 SIMD kernel uses AVX2, while this host also permits competitors to select
wider AVX-512 kernels. Instruction width, kernel scheduling and short-call
overhead are plausible contributors to the gap; this experiment does not
separate their individual causes. No validation is removed to improve rankings.

## Independent implementation controls

These ratios compare z64 with its own retained reference or disabled-feature
builds. They describe implementation changes, not wins over competing crates.

| Change | Cases per operation | Encode ratio | Decode ratio |
|---|---:|---:|---:|
| Reference → lookup/SWAR scalar | 24 | 1.539x | 4.732x |
| Scalar → default SIMD dispatch | 24 | 3.808x | 5.751x |
| Generic → native compilation | 24 | 0.937x | 0.969x |
| Native → native with runtime detection disabled | 24 | 0.969x | 1.056x |
| Short dispatch bypass disabled → enabled | 52 | 1.106x | 1.132x |

The lookup/SWAR and SIMD changes reduce the reference implementation's measured
cost. Small native/dispatch differences have wide case-to-case ranges and
remain diagnostic. In particular, the short-path ratios span 0.290–2.511x for
encoding and 0.421–2.561x for decoding; an approximately 10% aggregate difference
on this shared host is not an established short-path benefit. Native AVX2
compilation already resolves the feature check statically, so the
runtime-detection-disabled native row is an equivalence control rather than
evidence of an additional dispatch optimization.

## Reproduce and inspect

Run `Z64_BENCH_CPU=2 bash comparison/run.sh results/local` on an otherwise idle,
fixed machine, selecting an allowed CPU. The
[protocol](README.md) and [workload manifest](workloads.json) define the setup.
The [complete summary](results/20261109-xeon8573c/summary.md) links the scope of
every table; [all-case medians](results/20261109-xeon8573c/summary.csv.gz) and
[raw artifacts](results/20261109-xeon8573c/) preserve 74,816 samples plus hardware,
toolchain, dependency versions, commands and the differential log. CSV files are
losslessly gzip-compressed; `gzip -dc file.csv.gz` recovers every row.

Valid-input throughput uses original binary bytes. Invalid inputs report
latency only, because an early rejection does not process the remaining suffix.
There is no AArch64 performance claim from this x86-64 run. The target remains
unmet pending further optimization and evaluation on controlled hardware.
