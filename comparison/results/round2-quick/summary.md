# Measured comparison

These samples describe the recorded host and build only. They do not establish dedicated-hardware results or a general speed guarantee.
All baselines use strict alphabet, padding and unused-bit rules; the differential gate must pass before measurement.
Latency is the median of repeated samples. Throughput uses original binary bytes; rejected inputs have latency only.

## All predefined primary workloads

The 24 primary cases per operation cover six sizes and all four modes. Each ratio uses the fastest competitor in that same case. A ratio above 1 favors z64.

| Build | Operation | Cases | At least 2x | Geometric mean ratio | Minimum ratio | Maximum ratio |
|---|---|---:|---:|---:|---:|---:|

## Paired comparison with the previous z64

The previous version is Git commit d91c6bfbc447061ab4fd2f04feeb65045a6de329. Both versions share one binary, compiler, flags, input bytes and output capacities. Each case uses the median of old/new ratios paired by sample index; ratios above 1 favor the current code. The old version is excluded from external competitor rankings.

| Build | Operation | Primary cases | Current faster | At least 2x | Geometric mean paired ratio | Minimum | Maximum |
|---|---|---:|---:|---:|---:|---:|---:|
| quick-paired | encode | 16 | 12 | 6 | 1.802x | 0.597x | 5.428x |
| quick-paired | decode | 16 | 12 | 5 | 1.415x | 0.496x | 5.754x |

## Per-case primary results

| Build | Mode | Binary bytes | Operation | z64 ns | Fastest competitor | Competitor ns | Ratio |
|---|---|---:|---|---:|---|---:|---:|

## Ablations

Rows aggregate all primary mode/size cases for z64, except the short-path row, which uses every predefined short-path size (0–33 bytes) and all four modes. Ratios above 1 favor the second build.

| Comparison | Operation | Cases | Geometric mean speedup | Minimum | Maximum |
|---|---|---:|---:|---:|---:|

Raw samples include every non-primary boundary length, every baseline and invalid characters at the head, middle and tail. The *.csv.gz files contain losslessly compressed CSV; summary.csv.gz contains all medians, ranges and sample counts; paired.csv.gz contains every available before/after comparison, including errors and regressions.
