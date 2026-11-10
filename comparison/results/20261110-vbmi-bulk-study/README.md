# Rejected AVX512 bulk packing experiment

**Keep the existing production kernels.** Both proposed replacements regress the
4,095-byte workload in generic and native builds, and the decoder also regresses
384-byte inputs. Larger decode buffers sometimes improve, but this experiment
does not support an unconditional replacement. All results, including losses,
are retained in [aggregate.csv.gz](aggregate.csv.gz) and [summary.csv.gz](summary.csv.gz).

## Scope and candidates

This is a direct-kernel comparison against z64 commit
`cda77a6bd866be19831decc420e95a5a5bd79e75`, using the retained
[baseline.rs](baseline.rs). It does not compare against the strongest competing
crate, and it does not measure the public API, dispatch, or padding tails. Inputs
contain complete three-byte/four-character groups; both alphabets are exercised.

The candidates isolate two changes: [encode3.rs](encode3.rs) reads a 192-byte
block with three full vector loads and constructs four encoding vectors;
[decode3.rs](decode3.rs) packs four validated vectors into three full stores.
[combined.rs](combined.rs) applies both. Tail algorithms remain unchanged.

## Results

Each value below is baseline median time divided by candidate median time, then
geometrically averaged across both alphabets and all three alignment pairs.
Values below 1 mean the candidate is slower. These are all tested sizes for the
single-change candidates; the complete combined and error results are in
[aggregate.csv.gz](aggregate.csv.gz).

| Raw bytes | Encode generic | Encode native | Decode generic | Decode native |
|---:|---:|---:|---:|---:|
| 24 | 0.940 | 0.971 | 0.987 | 0.911 |
| 48 | 1.081 | 0.928 | 1.082 | 0.996 |
| 96 | 1.146 | 1.038 | 0.930 | 0.929 |
| 189 | 1.022 | 0.969 | 1.023 | 1.003 |
| 192 | 1.017 | 0.996 | 1.024 | 1.034 |
| 195 | 1.117 | 1.013 | 0.988 | 0.966 |
| 384 | 0.941 | 0.965 | 0.878 | 0.901 |
| 4,095 | 0.893 | 0.908 | 0.924 | 0.931 |
| 65,535 | 1.036 | 1.002 | 1.120 | 1.128 |
| 1,048,575 | 1.034 | 1.027 | 1.049 | 1.121 |
| 4,194,303 | 1.049 | 1.044 | 1.026 | 1.037 |

Combining the changes does not remove the 4,095-byte regression: encoding is
0.888/0.885 and decoding is 0.959/0.949 for generic/native builds. The combined
384-byte decoder is also slower at 0.865/0.890. Head, middle, and tail invalid-byte
results show mixed changes rather than a consistent benefit; their latency
records are preserved alongside successful inputs in [summary.csv.gz](summary.csv.gz).

Unchanged operations expose substantial variation. For example, `decode3` uses
the same compiler-merged encoding function as the baseline, yet individual bulk
workloads range from 0.904 to 1.179 in the generic build and 0.898 to 1.228 in the
native build. `encode3` also retains the original decoder. These controls are
included in [summary.csv.gz](summary.csv.gz); small or isolated gains should not be
treated as established improvements.

## Method and validation

The [probe](probe.rs) runs all four variants in the same binary, rotates their
order across 11 samples, uses a fixed seed and warmup, and keeps allocation and
preparation outside timing. Buffers are preallocated, inputs/results use
`black_box`, and output or exact error positions are checked outside timing.
Offsets are `(0,0)`, `(1,1)`, and `(31,47)` from 64-byte-aligned bases. Each build
produced 14,520 records: [generic.csv.gz](generic.csv.gz) and [native.csv.gz](native.csv.gz).

The host is a virtualized Xeon Platinum 8573C with Rust 1.99.1 and LLVM 23.1.1.
Runs used CPU 2 while other team CPU work was paused; frequency was not controlled.
Both builds use optimization level 3, one codegen unit, and thin LTO, with
`target-cpu=x86-64` or `target-cpu=native`. Full parameters and validation records
are in [metadata.json](metadata.json). Successful throughput uses original binary
bytes; invalid inputs report latency only.

All 12 direct-kernel test suites passed: exact slices, lengths 0–577, 64 offsets,
both alphabets, all 256 byte values at every position of the specified boundary
lengths, insufficient capacity, earliest errors, and output sentinels. The
[tests](avx512_tests.rs) use an independent reference encoder and check the allowed
modified output range. Every timed case also validates its result.

## Assembly findings

The emitted code achieves the intended instruction changes without bulk-loop
vector spills. Encoding replaces four masked loads with three full loads, while
two input `VPERMB` instructions become `VPERMT2B`. Decoding replaces four compaction
`VPERMB` instructions and four masked stores with three `VPERMT2B` instructions
and three full stores. The added index constants load only after bulk size guards.
See the [encoder](encode3-disassembly.txt.gz) and [decoder](decode3-disassembly.txt.gz)
against their [encoding](baseline-encode-disassembly.txt.gz) and
[decoding](baseline-decode-disassembly.txt.gz) baselines.

The explanation remains a hypothesis: cross-vector permutations couple adjacent
vectors and change scheduling requirements, while additional constants can affect
calls near bulk boundaries. No instruction-level counters or isolated instruction
benchmarks establish the dominant cause. Fewer load/store instructions alone did
not produce a consistent full-kernel improvement.

## Reproduction

Run `sh reproduce.sh` on an AVX512F/BW/VBMI-capable Linux host with Rust 1.89 or
newer; the measured compiler was 1.99.1. Set `Z64_STUDY_RUSTC` and `Z64_STUDY_CPU`
to select the compiler and CPU. Fresh outputs use `*-reproduction.csv.gz` and preserve
the original measurements. `python3 analyze.py` regenerates summaries of the
retained compressed originals. CSVs and assembly text use lossless gzip with
zero timestamps and no stored filename. Their uncompressed hashes are retained
in [metadata.json](metadata.json). [sha256.json](sha256.json) identifies the archived inputs and
outputs; executable hashes are in [metadata.json](metadata.json).
