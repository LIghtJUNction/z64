# Scalar input chunk study

The candidate removes eight repeated input bounds checks from the measured decode loop. It uses safe `split_first_chunk::<8>()` while preserving the 512-byte inverse tables, SWAR arithmetic, two output stores, eight-symbol validation boundary, and four-symbol tail. Compare the [baseline](baseline.rs) at [cda77a6](https://github.com/LIghtJUNction/z64/commit/cda77a6bd866be19831decc420e95a5a5bd79e75) with the [candidate](candidate.rs).

## Evidence

The [equivalence probe](bench.rs) passed 1,048,576 byte/position/offset/alphabet combinations and 2,112 valid-length/offset/alphabet combinations. It compares error kind, original byte offset, the complete modified output, and guard bytes. Both implementations validate each eight-symbol block before writing any output from that block.

The [old assembly](old-assembly.s) contains eight per-symbol input bounds checks; the [candidate assembly](new-assembly.s) eliminates them. Both retain the SWAR packing and two output stores. The candidate adds no division, and both measured wrappers still use a 104-byte stack frame. The [complete emitted assembly](scalar-pair.s) is also retained.

The [raw CSV](samples.csv) contains all 560 samples across 80 cases: two alphabets, ten encoded lengths from 4 to 4,096 bytes, and valid input or invalid characters at the head, middle, or tail. Nineteen of twenty valid workloads improved by paired-median ratio; their geometric mean was **1.077×**. Standard 24/32-character cases measured **1.146× / 1.173×**. Regressions remain: Standard eight-character valid input measured **0.979×**, and its middle-error case **0.861×**. [All summaries and sample ranges](summary.json) are retained.

Measurements used Rust 1.99.1 / LLVM 23.1.1, a shared Xeon Platinum 8573C VM pinned to CPU 2, identical input/output buffers, a fixed seed, 1 ms warmup per sample, seven samples per case, and alternating implementation order. Shared-host dispersion remains visible. These scalar-kernel results support full API validation; they do not establish a competitor speed claim. [Metadata, source hashes, and exact settings](study.json) document the scope.

## Reproduce

Run from this directory with Rust 1.99.1 installed:

```sh
rustc +1.99.1 --edition=2021 -O -C target-cpu=x86-64 -C codegen-units=1 --emit=asm,link bench.rs -o scalar-pair
./scalar-pair --check
taskset -c 2 ./scalar-pair > reproduced-samples.csv
```

The benchmark runs its correctness checks before sampling. Choose an available fixed CPU if CPU 2 is unavailable, and record that change. The original CSV remains unchanged by this command.
