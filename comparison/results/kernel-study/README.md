# AVX2 encoder implementation study

These measurements compare whole-block AVX2 encoder implementations. They were
used to investigate setup cost and compiler lowering; they are not complete-API
benchmarks or fixed-hardware performance claims. No candidate replaced the
production kernel because improvements did not remain consistent across input
sizes and both compiler versions.

The initial probe uses `probe.rs`; the final probe uses `probe_final.rs`. Each
imports the exact source snapshots beside it. All kernels encode the same bytes
and return the same consumed length. They process 24 input bytes per block, so
the CSV records both supplied length and consumed binary bytes. Any throughput
calculated from these files must use `consumed_bytes`.

| Variant | Change from the original kernel |
| --- | --- |
| `baseline` | Original dynamic-alphabet AVX2 encoder |
| `url-specialized` | Const-generic alphabet specialization |
| `specialized-opaque` | Specialization plus opaque multiply constants outside the loop |
| `specialized-shifts` | Specialization plus explicit shifts and masks instead of multiplications |
| `table` | Select one complete constant offset table |
| `count` | Calculate the minimum number of input/output blocks before looping |
| `table-count` | Combine static table selection and a precomputed block count |

All variants receive preallocated output, fixed deterministic input, 32 warmup
calls, nine samples, rotating variant order, and `black_box` on call arguments
and results. Each variant's output and consumed length are checked before timing;
output is checked again after every sample. Preparation and checking are outside
the timed region. Each raw row includes iteration count and elapsed nanoseconds.
This is a short diagnostic probe on a shared virtual machine, so noise and
compiler differences constrain interpretation.

Static table selection reduced setup time for small blocks in both compiler
runs. Explicit shifts helped some large-buffer cases on Rust 1.99.1 and hurt
large-buffer cases on Rust 1.70.0. Opaque constants and block-count changes had
mixed results. The raw files retain every case and candidate, including
regressions; these observations do not support a general speed claim.

## Reproduce

Run from the repository root on an AVX2-capable x86-64 host:

```sh
rustc +1.99.1 --edition=2021 -C opt-level=3 -C target-cpu=x86-64 comparison/results/kernel-study/probe.rs -o /tmp/z64-kernel-probe
/tmp/z64-kernel-probe > /tmp/z64-kernel-rust-1.99.1.csv
rustc +1.99.1 --edition=2021 -C opt-level=3 -C target-cpu=x86-64 comparison/results/kernel-study/probe_final.rs -o /tmp/z64-kernel-probe
/tmp/z64-kernel-probe > /tmp/z64-kernel-final-rust-1.99.1.csv
```

Repeat with `+1.70.0` for the MSRV compiler. These isolated probes do not link the
public API and do not substitute for the full comparison matrix.
