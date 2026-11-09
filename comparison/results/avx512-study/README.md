# AVX-512 VBMI kernel study

This paired probe compares the AVX2 kernels from commit `d91c6bf` with the new
AVX-512 VBMI kernels in one executable. It measures whole Base64 quanta directly;
public API validation, padding, dispatch, and scalar tails are measured by the
separate full-API comparison suite. The results come from a shared virtual
machine and do not establish fixed-hardware performance guarantees.

`first.csv` records the initial VBMI implementation. `final.csv` records its
two-block decode path and early return when no partial vector remains. Both
snapshots and the original AVX2 source are included so each measurement can be
reproduced independently. Encoding and decoding use preallocated buffers, both
alphabets, deterministic input, warmup, alternating implementation order, nine
samples, `black_box`, and output checks outside timing. `binary_bytes` is the
throughput denominator for both operations.

The VBMI kernels improved the measured 4 KiB and larger-buffer cases. The
96-byte binary / 128-character decode case remained slower after the two-block
change, so the public dispatch threshold must account for that result. The
full-API benchmark is the basis for selecting that threshold and reporting
end-user performance; no cases are omitted from these raw files.

## Reproduce

On a host supporting AVX512F, AVX512BW, and AVX512VBMI, run from this directory:

```sh
rustc +1.99.1 --edition=2021 -C opt-level=3 -C target-cpu=x86-64 probe.rs -o /tmp/z64-vbmi-probe
taskset -c 2 /tmp/z64-vbmi-probe > /tmp/z64-vbmi-final.csv
rustc +1.99.1 --edition=2021 -C opt-level=3 -C target-cpu=x86-64 probe_first.rs -o /tmp/z64-vbmi-probe
taskset -c 2 /tmp/z64-vbmi-probe > /tmp/z64-vbmi-first.csv
```

Choose an available CPU if CPU 2 is outside the host's affinity mask. Hardware,
compiler details, and exact sampling parameters are in `environment.txt`.
