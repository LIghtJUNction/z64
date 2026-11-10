# Measured comparison

These samples describe the recorded host and build only. They do not establish dedicated-hardware results or a general speed guarantee.
All baselines use strict alphabet, padding and unused-bit rules; the differential gate must pass before measurement.
Latency is the median of repeated samples. Throughput uses original binary bytes; rejected inputs have latency only.

## Recorded scope

Observed scope only (partial or unverified run). Full-matrix completeness was not requested; the tables describe available records and do not claim that absent cases or implementations were measured.

The case count below is the union of observed case identities within each build; it does not by itself imply identical coverage for every implementation.

| Build | Implementations | Observed cases | Raw samples | Samples per implementation/case |
|---|---:|---:|---:|---|
| generic | 2 | 224 | 4928 | 11 |
| native | 2 | 224 | 4928 | 11 |

## Observed primary workloads

The manifest defines 24 primary cases per operation. Each reported ratio uses the fastest observed external competitor in that same case; the table states how many cases were available. A ratio above 1 favors z64.

| Build | Operation | Cases | At least 2x | Geometric mean ratio | Minimum ratio | Maximum ratio |
|---|---|---:|---:|---:|---:|---:|

## Paired comparison with the previous z64

The previous version is Git commit cda77a6bd866be19831decc420e95a5a5bd79e75. Both versions share one binary, compiler, flags, input bytes and output capacities. Each case uses the median of old/new ratios paired by sample index; ratios above 1 favor the current code. The old version is excluded from external competitor rankings.

| Build | Operation | Primary cases | Current faster | At least 2x | Geometric mean paired ratio | Minimum | Maximum |
|---|---|---:|---:|---:|---:|---:|---:|
| generic | encode | 16 | 10 | 0 | 1.011x | 0.872x | 1.124x |
| generic | decode | 16 | 12 | 0 | 1.061x | 0.859x | 1.232x |
| native | encode | 16 | 6 | 0 | 0.962x | 0.791x | 1.102x |
| native | decode | 16 | 14 | 0 | 1.057x | 0.937x | 1.271x |

## Per-case primary results

| Build | Mode | Binary bytes | Operation | z64 ns | Fastest observed competitor | Competitor ns | Ratio |
|---|---|---:|---|---:|---|---:|---:|

## Ablations

Rows use z64 cases observed in both builds, restricted to the manifest's primary modes and sizes. The short-path row instead uses the manifest's short-path sizes. Each row states its observed case count; ratios above 1 favor the second build.

| Comparison | Operation | Cases | Geometric mean speedup | Minimum | Maximum |
|---|---|---:|---:|---:|---:|
| generic → native | encode | 16 | 1.051x | 0.870x | 1.512x |
| generic → native | decode | 16 | 1.046x | 0.958x | 1.168x |

Raw CSV files retain the recorded samples, including slower results and errors when measured. summary.csv.gz contains every observed median, range and sample count. When paired data exists, paired.csv.gz contains every observed before/after comparison, including errors and regressions present in the input. A complete-grid claim requires successful --complete validation.
