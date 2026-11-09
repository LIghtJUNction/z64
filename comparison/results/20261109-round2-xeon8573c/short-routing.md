# Short-input review of commit 181babf

This analysis uses the unmodified raw samples in this directory, measured at
`181babfff853fd32154939793b4b936815e700ba`. It does not change the predefined
primary set or remove regressions from the summary.

## Decode boundary

The old/current columns use the median of seven sample-index-paired ratios in
`paired.csv.gz`, followed by a geometric mean across all four modes. A value
above 1 favors current z64. The AVX2 column instead divides current generic
median latency by `no-avx512` median latency in `summary.csv.gz`; a value above
1 favors AVX2. Those two builds were measured at different times, so their
ratios are a diagnostic ablation, not a paired experiment.

| Binary bytes | Old/current, generic | Old/current, native | Generic default / AVX2 latency |
|---|---:|---:|---:|
| 24 | 0.784x | 0.769x | 1.203x |
| 25 | 0.758x | 0.846x | 1.174x |
| 31 | 1.136x | 1.169x | 0.884x |
| 32 | 1.192x | 1.241x | 0.837x |
| 33 | 1.327x | 1.474x | 0.731x |
| 48 | 1.144x | 0.942x | 0.722x |

The AVX2 ablation's individual mode ratios show the uncertainty rather than
supporting an unconditional 20% claim:

| Binary bytes | Standard | Standard without padding | URL-safe | URL-safe without padding |
|---|---:|---:|---:|---:|
| 24 | 1.367x | 1.276x | 0.910x | 1.317x |
| 25 | 1.294x | 1.256x | 0.970x | 1.205x |
| 31 | 1.087x | 0.885x | 0.774x | 0.821x |
| 32 | 0.873x | 0.916x | 0.745x | 0.823x |
| 33 | 0.747x | 0.699x | 0.805x | 0.679x |
| 48 | 0.899x | 0.389x | 0.863x | 0.900x |

At 24 and 25 bytes every mode regresses against the old version in both generic
and native paired measurements. The generic AVX2 ablation is faster in three
of four modes at these sizes. By contrast, default VBMI is faster in every
32-byte mode. The AVX2 decoder is unchanged from the old version. After the
public API removes the incomplete tail, raw inputs of 24, 25 and 26 bytes pass
exactly 32 encoded characters to the SIMD decoder. This makes routing that
single block to AVX2 a specific candidate for correction. The 26-byte case is
an inference from the body-length calculation; it is not present in this
predefined full sweep.

Encoding shows default/AVX2 aggregate ratios of 1.199x and 1.150x at 24 and
25 bytes, with conflicting individual modes. That is insufficient evidence
for a broader encode threshold change. Inputs below the vector threshold
continue through the scalar path; isolated large changes there cannot be
attributed to the new vector kernel.

## Complete sweep and rejected inputs

Of 272 valid cases per build, 42 generic and 58 native paired medians favor
the old implementation; seven and four respectively have ratios below 0.8.
All 96 predefined primary cases favor current z64. These facts describe the
same retained dataset and do not establish uniform speedups across all sizes.

| Invalid-byte position | Cases per build | Generic old/current | Native old/current |
|---|---:|---:|---:|
| Head | 132 | 0.916x | 0.814x |
| Middle | 132 | 1.263x | 1.137x |
| Tail | 132 | 1.573x | 1.519x |

The new implementation is slower in 94/132 generic and 122/132 native
head-error cases. Wider-kernel setup is a plausible explanation, but this
experiment does not isolate that cost. Invalid rows use latency, because
early rejection does not consume the remaining suffix. Shared-VM noise is
visible in several short and large-buffer samples, and readable cgroup
throttling counters were unavailable; no significance claim is made for
small differences.
