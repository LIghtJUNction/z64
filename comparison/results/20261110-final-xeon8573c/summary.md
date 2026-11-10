# Measured comparison

These samples describe the recorded host and build only. They do not establish dedicated-hardware results or a general speed guarantee.
All baselines use strict alphabet, padding and unused-bit rules; the differential gate must pass before measurement.
Latency is the median of repeated samples. Throughput uses original binary bytes; rejected inputs have latency only.

## Recorded scope

Complete matrix validation passed against the recorded manifest and Cargo.lock: 12692 implementation/case groups and 88844 raw samples. Every group contains exactly sample IDs 0 through 6.

The case count below is the union of observed case identities within each build; it does not by itself imply identical coverage for every implementation.

| Build | Implementations | Observed cases | Raw samples | Samples per implementation/case |
|---|---:|---:|---:|---|
| compiletime-native | 1 | 668 | 4676 | 7 |
| generic | 7 | 668 | 32732 | 7 |
| native | 7 | 668 | 32732 | 7 |
| no-avx512 | 1 | 668 | 4676 | 7 |
| no-short-path | 1 | 668 | 4676 | 7 |
| reference | 1 | 668 | 4676 | 7 |
| scalar | 1 | 668 | 4676 | 7 |

## All predefined primary workloads

The manifest defines 24 primary cases per operation. Each reported ratio uses the fastest observed external competitor in that same case; the table states how many cases were available. A ratio above 1 favors z64.

| Build | Operation | Cases | At least 2x | Geometric mean ratio | Minimum ratio | Maximum ratio |
|---|---|---:|---:|---:|---:|---:|
| generic | encode | 24 | 0 | 0.921x | 0.744x | 1.159x |
| generic | decode | 24 | 0 | 0.888x | 0.635x | 1.281x |
| native | encode | 24 | 0 | 0.915x | 0.564x | 1.164x |
| native | decode | 24 | 0 | 0.876x | 0.609x | 1.523x |

## Paired comparison with the previous z64

The previous version is Git commit cda77a6bd866be19831decc420e95a5a5bd79e75. Both versions share one binary, compiler, flags, input bytes and output capacities. Each case uses the median of old/new ratios paired by sample index; ratios above 1 favor the current code. The old version is excluded from external competitor rankings.

| Build | Operation | Primary cases | Current faster | At least 2x | Geometric mean paired ratio | Minimum | Maximum |
|---|---|---:|---:|---:|---:|---:|---:|
| generic | encode | 24 | 13 | 0 | 1.017x | 0.899x | 1.276x |
| generic | decode | 24 | 16 | 0 | 1.017x | 0.787x | 1.386x |
| native | encode | 24 | 13 | 0 | 1.005x | 0.863x | 1.176x |
| native | decode | 24 | 17 | 0 | 1.073x | 0.908x | 1.241x |

## Per-case primary results

| Build | Mode | Binary bytes | Operation | z64 ns | Fastest observed competitor | Competitor ns | Ratio |
|---|---|---:|---|---:|---|---:|---:|
| generic | standard | 32 | decode | 15.723 | base64-simd-0.8.0 | 14.824 | 0.943x |
| generic | standard | 32 | encode | 14.759 | base64-turbo-0.6.0 | 13.057 | 0.885x |
| generic | standard | 128 | decode | 15.989 | base64-turbo-0.6.0 | 19.346 | 1.210x |
| generic | standard | 128 | encode | 17.427 | base64-turbo-0.6.0 | 14.908 | 0.855x |
| generic | standard | 4096 | decode | 192.699 | base64-turbo-0.6.0 | 152.423 | 0.791x |
| generic | standard | 4096 | encode | 122.649 | base64-turbo-0.6.0 | 108.511 | 0.885x |
| generic | standard | 65536 | decode | 3344.567 | base64-turbo-0.6.0 | 3038.212 | 0.908x |
| generic | standard | 65536 | encode | 2805.004 | base64-turbo-0.6.0 | 2888.162 | 1.030x |
| generic | standard | 1048576 | decode | 88597.125 | base64-turbo-0.6.0 | 72675.429 | 0.820x |
| generic | standard | 1048576 | encode | 90111.933 | base64-turbo-0.6.0 | 80319.913 | 0.891x |
| generic | standard | 4194304 | decode | 418768.500 | base64-turbo-0.6.0 | 420682.200 | 1.005x |
| generic | standard | 4194304 | encode | 542610.000 | base64-turbo-0.6.0 | 412668.500 | 0.761x |
| generic | standard-no-pad | 32 | decode | 15.652 | base64-simd-0.8.0 | 12.593 | 0.805x |
| generic | standard-no-pad | 32 | encode | 14.338 | base64-turbo-0.6.0 | 14.507 | 1.012x |
| generic | standard-no-pad | 128 | decode | 17.910 | base64-turbo-0.6.0 | 21.814 | 1.218x |
| generic | standard-no-pad | 128 | encode | 15.736 | base64-turbo-0.6.0 | 18.236 | 1.159x |
| generic | standard-no-pad | 4096 | decode | 182.818 | base64-turbo-0.6.0 | 162.796 | 0.890x |
| generic | standard-no-pad | 4096 | encode | 114.741 | base64-turbo-0.6.0 | 107.818 | 0.940x |
| generic | standard-no-pad | 65536 | decode | 3293.101 | base64-turbo-0.6.0 | 3176.312 | 0.965x |
| generic | standard-no-pad | 65536 | encode | 2922.478 | base64-turbo-0.6.0 | 2812.912 | 0.963x |
| generic | standard-no-pad | 1048576 | decode | 112254.077 | base64-turbo-0.6.0 | 71316.308 | 0.635x |
| generic | standard-no-pad | 1048576 | encode | 106864.714 | base64-turbo-0.6.0 | 83461.727 | 0.781x |
| generic | standard-no-pad | 4194304 | decode | 533453.250 | base64-turbo-0.6.0 | 408811.800 | 0.766x |
| generic | standard-no-pad | 4194304 | encode | 495116.500 | base64-turbo-0.6.0 | 410919.200 | 0.830x |
| generic | url-safe | 32 | decode | 15.842 | base64-simd-0.8.0 | 14.153 | 0.893x |
| generic | url-safe | 32 | encode | 14.231 | base64-turbo-0.6.0 | 12.011 | 0.844x |
| generic | url-safe | 128 | decode | 17.304 | base64-turbo-0.6.0 | 21.625 | 1.250x |
| generic | url-safe | 128 | encode | 16.218 | base64-turbo-0.6.0 | 14.317 | 0.883x |
| generic | url-safe | 4096 | decode | 184.608 | base64-turbo-0.6.0 | 157.191 | 0.851x |
| generic | url-safe | 4096 | encode | 118.748 | base64-turbo-0.6.0 | 102.903 | 0.867x |
| generic | url-safe | 65536 | decode | 3241.054 | base64-turbo-0.6.0 | 2649.267 | 0.817x |
| generic | url-safe | 65536 | encode | 2909.871 | base64-turbo-0.6.0 | 2723.376 | 0.936x |
| generic | url-safe | 1048576 | decode | 102684.077 | base64-turbo-0.6.0 | 79595.867 | 0.775x |
| generic | url-safe | 1048576 | encode | 109632.160 | base64-turbo-0.6.0 | 81602.593 | 0.744x |
| generic | url-safe | 4194304 | decode | 447769.667 | base64-turbo-0.6.0 | 327636.000 | 0.732x |
| generic | url-safe | 4194304 | encode | 430234.750 | base64-turbo-0.6.0 | 392286.000 | 0.912x |
| generic | url-safe-no-pad | 32 | decode | 14.469 | base64-simd-0.8.0 | 11.806 | 0.816x |
| generic | url-safe-no-pad | 32 | encode | 13.192 | base64-turbo-0.6.0 | 14.502 | 1.099x |
| generic | url-safe-no-pad | 128 | decode | 18.611 | encodify-1.0.2 | 23.832 | 1.281x |
| generic | url-safe-no-pad | 128 | encode | 16.236 | base64-turbo-0.6.0 | 17.777 | 1.095x |
| generic | url-safe-no-pad | 4096 | decode | 203.244 | base64-turbo-0.6.0 | 161.845 | 0.796x |
| generic | url-safe-no-pad | 4096 | encode | 129.618 | base64-turbo-0.6.0 | 110.405 | 0.852x |
| generic | url-safe-no-pad | 65536 | decode | 3301.652 | base64-turbo-0.6.0 | 2757.428 | 0.835x |
| generic | url-safe-no-pad | 65536 | encode | 3098.044 | base64-turbo-0.6.0 | 3208.034 | 1.036x |
| generic | url-safe-no-pad | 1048576 | decode | 105802.684 | base64-turbo-0.6.0 | 92352.414 | 0.873x |
| generic | url-safe-no-pad | 1048576 | encode | 96117.550 | base64-turbo-0.6.0 | 85226.800 | 0.887x |
| generic | url-safe-no-pad | 4194304 | decode | 479804.000 | base64-turbo-0.6.0 | 371569.250 | 0.774x |
| generic | url-safe-no-pad | 4194304 | encode | 473676.667 | base64-turbo-0.6.0 | 534203.000 | 1.128x |
| native | standard | 32 | decode | 12.504 | base64-simd-0.8.0 | 12.246 | 0.979x |
| native | standard | 32 | encode | 11.173 | base64-turbo-0.6.0 | 12.147 | 1.087x |
| native | standard | 128 | decode | 18.146 | base64-turbo-0.6.0 | 18.263 | 1.006x |
| native | standard | 128 | encode | 13.074 | base64-turbo-0.6.0 | 14.249 | 1.090x |
| native | standard | 4096 | decode | 179.052 | base64-turbo-0.6.0 | 159.440 | 0.890x |
| native | standard | 4096 | encode | 119.688 | base64-turbo-0.6.0 | 104.199 | 0.871x |
| native | standard | 65536 | decode | 3279.103 | base64-turbo-0.6.0 | 2775.138 | 0.846x |
| native | standard | 65536 | encode | 2500.885 | base64-turbo-0.6.0 | 2553.847 | 1.021x |
| native | standard | 1048576 | decode | 105346.500 | base64-turbo-0.6.0 | 69396.870 | 0.659x |
| native | standard | 1048576 | encode | 88905.273 | base64-turbo-0.6.0 | 103458.545 | 1.164x |
| native | standard | 4194304 | decode | 521316.000 | base64-turbo-0.6.0 | 402503.000 | 0.772x |
| native | standard | 4194304 | encode | 436014.750 | base64-turbo-0.6.0 | 441021.000 | 1.011x |
| native | standard-no-pad | 32 | decode | 13.487 | base64-simd-0.8.0 | 12.456 | 0.924x |
| native | standard-no-pad | 32 | encode | 12.731 | base64-turbo-0.6.0 | 12.280 | 0.965x |
| native | standard-no-pad | 128 | decode | 17.390 | base64-simd-0.8.0 | 21.299 | 1.225x |
| native | standard-no-pad | 128 | encode | 15.545 | base64-turbo-0.6.0 | 15.113 | 0.972x |
| native | standard-no-pad | 4096 | decode | 166.688 | base64-turbo-0.6.0 | 167.468 | 1.005x |
| native | standard-no-pad | 4096 | encode | 118.020 | base64-turbo-0.6.0 | 119.308 | 1.011x |
| native | standard-no-pad | 65536 | decode | 3629.396 | base64-turbo-0.6.0 | 2741.037 | 0.755x |
| native | standard-no-pad | 65536 | encode | 2940.066 | base64-turbo-0.6.0 | 2593.535 | 0.882x |
| native | standard-no-pad | 1048576 | decode | 92048.647 | base64-turbo-0.6.0 | 67765.852 | 0.736x |
| native | standard-no-pad | 1048576 | encode | 110630.111 | base64-turbo-0.6.0 | 91845.333 | 0.830x |
| native | standard-no-pad | 4194304 | decode | 400289.000 | base64-turbo-0.6.0 | 371374.000 | 0.928x |
| native | standard-no-pad | 4194304 | encode | 609069.500 | base64-turbo-0.6.0 | 408713.250 | 0.671x |
| native | url-safe | 32 | decode | 11.786 | base64-simd-0.8.0 | 13.177 | 1.118x |
| native | url-safe | 32 | encode | 12.501 | base64-turbo-0.6.0 | 11.169 | 0.893x |
| native | url-safe | 128 | decode | 18.109 | base64-turbo-0.6.0 | 19.517 | 1.078x |
| native | url-safe | 128 | encode | 13.236 | base64-turbo-0.6.0 | 13.861 | 1.047x |
| native | url-safe | 4096 | decode | 196.552 | base64-turbo-0.6.0 | 188.097 | 0.957x |
| native | url-safe | 4096 | encode | 113.505 | base64-turbo-0.6.0 | 111.269 | 0.980x |
| native | url-safe | 65536 | decode | 3479.164 | base64-turbo-0.6.0 | 2836.964 | 0.815x |
| native | url-safe | 65536 | encode | 2702.365 | base64-turbo-0.6.0 | 2713.593 | 1.004x |
| native | url-safe | 1048576 | decode | 103712.955 | base64-turbo-0.6.0 | 67549.923 | 0.651x |
| native | url-safe | 1048576 | encode | 103063.000 | base64-turbo-0.6.0 | 81583.474 | 0.792x |
| native | url-safe | 4194304 | decode | 568964.500 | base64-turbo-0.6.0 | 397038.000 | 0.698x |
| native | url-safe | 4194304 | encode | 714360.000 | base64-turbo-0.6.0 | 402700.800 | 0.564x |
| native | url-safe-no-pad | 32 | decode | 13.742 | base64-simd-0.8.0 | 12.919 | 0.940x |
| native | url-safe-no-pad | 32 | encode | 11.031 | base64-turbo-0.6.0 | 10.003 | 0.907x |
| native | url-safe-no-pad | 128 | decode | 14.972 | base64-turbo-0.6.0 | 22.796 | 1.523x |
| native | url-safe-no-pad | 128 | encode | 14.107 | base64-turbo-0.6.0 | 14.232 | 1.009x |
| native | url-safe-no-pad | 4096 | decode | 186.175 | base64-turbo-0.6.0 | 156.782 | 0.842x |
| native | url-safe-no-pad | 4096 | encode | 118.043 | base64-turbo-0.6.0 | 109.142 | 0.925x |
| native | url-safe-no-pad | 65536 | decode | 3402.333 | base64-turbo-0.6.0 | 2951.304 | 0.867x |
| native | url-safe-no-pad | 65536 | encode | 2810.815 | base64-turbo-0.6.0 | 2684.740 | 0.955x |
| native | url-safe-no-pad | 1048576 | decode | 114010.333 | base64-turbo-0.6.0 | 69437.500 | 0.609x |
| native | url-safe-no-pad | 1048576 | encode | 91933.000 | encodify-1.0.2 | 83769.115 | 0.911x |
| native | url-safe-no-pad | 4194304 | decode | 582493.000 | base64-turbo-0.6.0 | 399768.800 | 0.686x |
| native | url-safe-no-pad | 4194304 | encode | 613897.250 | base64-turbo-0.6.0 | 417492.800 | 0.680x |

## Ablations

Rows use z64 cases observed in both builds, restricted to the manifest's primary modes and sizes. The short-path row instead uses the manifest's short-path sizes. Each row states its observed case count; ratios above 1 favor the second build.

| Comparison | Operation | Cases | Geometric mean speedup | Minimum | Maximum |
|---|---|---:|---:|---:|---:|
| reference → scalar | encode | 24 | 1.561x | 1.193x | 2.597x |
| reference → scalar | decode | 24 | 5.206x | 1.037x | 17.968x |
| scalar → no-avx512 | encode | 24 | 5.397x | 1.244x | 10.323x |
| scalar → no-avx512 | decode | 24 | 5.499x | 1.572x | 11.718x |
| no-avx512 → generic | encode | 24 | 1.342x | 0.813x | 2.852x |
| no-avx512 → generic | decode | 24 | 1.574x | 1.007x | 3.780x |
| scalar → generic | encode | 24 | 7.243x | 1.589x | 24.666x |
| scalar → generic | decode | 24 | 8.653x | 2.023x | 44.297x |
| generic → native | encode | 24 | 1.047x | 0.602x | 1.333x |
| generic → native | decode | 24 | 1.016x | 0.787x | 1.344x |
| native → compiletime-native | encode | 24 | 0.937x | 0.535x | 1.401x |
| native → compiletime-native | decode | 24 | 0.975x | 0.456x | 1.413x |
| no-short-path → generic | encode | 52 | 0.874x | 0.385x | 2.216x |
| no-short-path → generic | decode | 52 | 1.031x | 0.254x | 4.839x |

Raw CSV files retain the recorded samples, including slower results and errors when measured. summary.csv.gz contains every observed median, range and sample count. When paired data exists, paired.csv.gz contains every observed before/after comparison, including errors and regressions present in the input. A complete-grid claim requires successful --complete validation.
