# Measured comparison

These samples describe the recorded host and build only. They do not establish dedicated-hardware results or a general speed guarantee.
All baselines use strict alphabet, padding and unused-bit rules; the differential gate must pass before measurement.
Latency is the median of repeated samples. Throughput uses original binary bytes; rejected inputs have latency only.

## All predefined primary workloads

The 24 primary cases per operation cover six sizes and all four modes. Each ratio uses the fastest competitor in that same case. A ratio above 1 favors z64.

| Build | Operation | Cases | At least 2x | Geometric mean ratio | Minimum ratio | Maximum ratio |
|---|---|---:|---:|---:|---:|---:|
| generic | encode | 24 | 0 | 0.931x | 0.588x | 1.140x |
| generic | decode | 24 | 0 | 0.878x | 0.610x | 1.174x |
| native | encode | 24 | 0 | 0.923x | 0.721x | 1.185x |
| native | decode | 24 | 0 | 0.900x | 0.446x | 1.376x |

## Paired comparison with the previous z64

The previous version is Git commit d91c6bfbc447061ab4fd2f04feeb65045a6de329. Both versions share one binary, compiler, flags, input bytes and output capacities. Each case uses the median of old/new ratios paired by sample index; ratios above 1 favor the current code. The old version is excluded from external competitor rankings.

| Build | Operation | Primary cases | Current faster | At least 2x | Geometric mean paired ratio | Minimum | Maximum |
|---|---|---:|---:|---:|---:|---:|---:|
| generic | encode | 24 | 24 | 8 | 1.962x | 1.063x | 5.565x |
| generic | decode | 24 | 24 | 7 | 1.647x | 1.136x | 2.896x |
| native | encode | 24 | 24 | 9 | 2.161x | 1.187x | 5.657x |
| native | decode | 24 | 24 | 6 | 1.511x | 1.099x | 2.550x |

## Per-case primary results

| Build | Mode | Binary bytes | Operation | z64 ns | Fastest competitor | Competitor ns | Ratio |
|---|---|---:|---|---:|---|---:|---:|
| generic | standard | 32 | decode | 14.446 | base64-simd-0.8.0 | 11.126 | 0.770x |
| generic | standard | 32 | encode | 12.047 | base64-turbo-0.6.0 | 12.115 | 1.006x |
| generic | standard | 128 | decode | 17.600 | base64-turbo-0.6.0 | 19.118 | 1.086x |
| generic | standard | 128 | encode | 13.948 | base64-turbo-0.6.0 | 13.277 | 0.952x |
| generic | standard | 4096 | decode | 123.712 | base64-turbo-0.6.0 | 115.610 | 0.935x |
| generic | standard | 4096 | encode | 102.771 | base64-turbo-0.6.0 | 86.361 | 0.840x |
| generic | standard | 65536 | decode | 2745.314 | base64-turbo-0.6.0 | 2188.673 | 0.797x |
| generic | standard | 65536 | encode | 2099.921 | base64-turbo-0.6.0 | 2306.581 | 1.098x |
| generic | standard | 1048576 | decode | 73626.000 | base64-turbo-0.6.0 | 68353.042 | 0.928x |
| generic | standard | 1048576 | encode | 64392.900 | base64-turbo-0.6.0 | 68807.182 | 1.069x |
| generic | standard | 4194304 | decode | 415507.600 | encodify-1.0.2 | 402528.000 | 0.969x |
| generic | standard | 4194304 | encode | 444146.000 | base64-turbo-0.6.0 | 341266.000 | 0.768x |
| generic | standard-no-pad | 32 | decode | 14.973 | base64-simd-0.8.0 | 9.798 | 0.654x |
| generic | standard-no-pad | 32 | encode | 11.737 | base64-turbo-0.6.0 | 12.582 | 1.072x |
| generic | standard-no-pad | 128 | decode | 17.821 | base64-turbo-0.6.0 | 17.401 | 0.976x |
| generic | standard-no-pad | 128 | encode | 14.772 | base64-turbo-0.6.0 | 12.394 | 0.839x |
| generic | standard-no-pad | 4096 | decode | 127.620 | base64-turbo-0.6.0 | 133.274 | 1.044x |
| generic | standard-no-pad | 4096 | encode | 82.834 | base64-turbo-0.6.0 | 87.376 | 1.055x |
| generic | standard-no-pad | 65536 | decode | 2810.678 | base64-turbo-0.6.0 | 2146.165 | 0.764x |
| generic | standard-no-pad | 65536 | encode | 2182.812 | base64-turbo-0.6.0 | 2489.204 | 1.140x |
| generic | standard-no-pad | 1048576 | decode | 87749.227 | base64-turbo-0.6.0 | 77145.963 | 0.879x |
| generic | standard-no-pad | 1048576 | encode | 76254.154 | base64-turbo-0.6.0 | 81786.800 | 1.073x |
| generic | standard-no-pad | 4194304 | decode | 383178.667 | base64-turbo-0.6.0 | 355854.250 | 0.929x |
| generic | standard-no-pad | 4194304 | encode | 377997.333 | base64-turbo-0.6.0 | 329763.750 | 0.872x |
| generic | url-safe | 32 | decode | 14.556 | base64-simd-0.8.0 | 13.110 | 0.901x |
| generic | url-safe | 32 | encode | 13.044 | base64-turbo-0.6.0 | 10.030 | 0.769x |
| generic | url-safe | 128 | decode | 17.348 | base64-turbo-0.6.0 | 16.700 | 0.963x |
| generic | url-safe | 128 | encode | 12.729 | base64-turbo-0.6.0 | 11.723 | 0.921x |
| generic | url-safe | 4096 | decode | 129.377 | base64-turbo-0.6.0 | 118.650 | 0.917x |
| generic | url-safe | 4096 | encode | 94.878 | base64-turbo-0.6.0 | 82.800 | 0.873x |
| generic | url-safe | 65536 | decode | 2258.241 | base64-turbo-0.6.0 | 2034.898 | 0.901x |
| generic | url-safe | 65536 | encode | 2397.143 | base64-turbo-0.6.0 | 2346.467 | 0.979x |
| generic | url-safe | 1048576 | decode | 78841.080 | base64-turbo-0.6.0 | 68528.852 | 0.869x |
| generic | url-safe | 1048576 | encode | 80664.522 | encodify-1.0.2 | 76857.125 | 0.953x |
| generic | url-safe | 4194304 | decode | 389382.600 | base64-turbo-0.6.0 | 373372.800 | 0.959x |
| generic | url-safe | 4194304 | encode | 435019.500 | base64-turbo-0.6.0 | 366826.750 | 0.843x |
| generic | url-safe-no-pad | 32 | decode | 13.676 | base64-simd-0.8.0 | 10.752 | 0.786x |
| generic | url-safe-no-pad | 32 | encode | 12.576 | base64-turbo-0.6.0 | 10.581 | 0.841x |
| generic | url-safe-no-pad | 128 | decode | 15.483 | base64-turbo-0.6.0 | 18.170 | 1.174x |
| generic | url-safe-no-pad | 128 | encode | 13.503 | base64-turbo-0.6.0 | 13.663 | 1.012x |
| generic | url-safe-no-pad | 4096 | decode | 138.505 | base64-turbo-0.6.0 | 117.825 | 0.851x |
| generic | url-safe-no-pad | 4096 | encode | 88.686 | base64-turbo-0.6.0 | 94.956 | 1.071x |
| generic | url-safe-no-pad | 65536 | decode | 2605.355 | base64-turbo-0.6.0 | 2212.709 | 0.849x |
| generic | url-safe-no-pad | 65536 | encode | 2336.517 | base64-turbo-0.6.0 | 2407.023 | 1.030x |
| generic | url-safe-no-pad | 1048576 | decode | 115188.857 | base64-turbo-0.6.0 | 70231.320 | 0.610x |
| generic | url-safe-no-pad | 1048576 | encode | 184833.444 | base64-turbo-0.6.0 | 108745.862 | 0.588x |
| generic | url-safe-no-pad | 4194304 | decode | 446381.000 | base64-turbo-0.6.0 | 347605.250 | 0.779x |
| generic | url-safe-no-pad | 4194304 | encode | 446500.750 | base64-turbo-0.6.0 | 410476.600 | 0.919x |
| native | standard | 32 | decode | 13.616 | base64-simd-0.8.0 | 11.613 | 0.853x |
| native | standard | 32 | encode | 9.247 | base64-turbo-0.6.0 | 9.068 | 0.981x |
| native | standard | 128 | decode | 17.097 | encodify-1.0.2 | 18.502 | 1.082x |
| native | standard | 128 | encode | 12.631 | base64-turbo-0.6.0 | 10.677 | 0.845x |
| native | standard | 4096 | decode | 135.912 | base64-turbo-0.6.0 | 123.178 | 0.906x |
| native | standard | 4096 | encode | 82.744 | base64-turbo-0.6.0 | 85.704 | 1.036x |
| native | standard | 65536 | decode | 2689.136 | base64-turbo-0.6.0 | 2113.967 | 0.786x |
| native | standard | 65536 | encode | 2343.488 | base64-turbo-0.6.0 | 2305.455 | 0.984x |
| native | standard | 1048576 | decode | 90677.917 | base64-turbo-0.6.0 | 60747.654 | 0.670x |
| native | standard | 1048576 | encode | 75257.579 | encodify-1.0.2 | 75473.667 | 1.003x |
| native | standard | 4194304 | decode | 390431.000 | base64-turbo-0.6.0 | 378089.500 | 0.968x |
| native | standard | 4194304 | encode | 476848.000 | base64-turbo-0.6.0 | 343787.200 | 0.721x |
| native | standard-no-pad | 32 | decode | 12.261 | base64-simd-0.8.0 | 10.222 | 0.834x |
| native | standard-no-pad | 32 | encode | 10.094 | base64-turbo-0.6.0 | 9.016 | 0.893x |
| native | standard-no-pad | 128 | decode | 14.022 | base64-simd-0.8.0 | 17.275 | 1.232x |
| native | standard-no-pad | 128 | encode | 10.855 | base64-turbo-0.6.0 | 10.078 | 0.928x |
| native | standard-no-pad | 4096 | decode | 164.611 | base64-turbo-0.6.0 | 172.462 | 1.048x |
| native | standard-no-pad | 4096 | encode | 126.370 | base64-turbo-0.6.0 | 91.882 | 0.727x |
| native | standard-no-pad | 65536 | decode | 3076.000 | base64-turbo-0.6.0 | 2554.097 | 0.830x |
| native | standard-no-pad | 65536 | encode | 2338.070 | base64-turbo-0.6.0 | 2434.428 | 1.041x |
| native | standard-no-pad | 1048576 | decode | 76463.424 | base64-turbo-0.6.0 | 56829.000 | 0.743x |
| native | standard-no-pad | 1048576 | encode | 81504.520 | encodify-1.0.2 | 71227.697 | 0.874x |
| native | standard-no-pad | 4194304 | decode | 878323.800 | base64-turbo-0.6.0 | 391474.500 | 0.446x |
| native | standard-no-pad | 4194304 | encode | 434098.200 | base64-turbo-0.6.0 | 352662.400 | 0.812x |
| native | url-safe | 32 | decode | 12.076 | base64-simd-0.8.0 | 11.854 | 0.982x |
| native | url-safe | 32 | encode | 8.329 | base64-turbo-0.6.0 | 8.868 | 1.065x |
| native | url-safe | 128 | decode | 13.892 | base64-turbo-0.6.0 | 19.111 | 1.376x |
| native | url-safe | 128 | encode | 11.519 | base64-turbo-0.6.0 | 11.296 | 0.981x |
| native | url-safe | 4096 | decode | 154.772 | base64-turbo-0.6.0 | 176.532 | 1.141x |
| native | url-safe | 4096 | encode | 88.026 | base64-turbo-0.6.0 | 91.829 | 1.043x |
| native | url-safe | 65536 | decode | 2627.252 | base64-turbo-0.6.0 | 2317.940 | 0.882x |
| native | url-safe | 65536 | encode | 2580.985 | base64-turbo-0.6.0 | 2269.389 | 0.879x |
| native | url-safe | 1048576 | decode | 95176.043 | base64-turbo-0.6.0 | 81637.538 | 0.858x |
| native | url-safe | 1048576 | encode | 91011.812 | encodify-1.0.2 | 81439.000 | 0.895x |
| native | url-safe | 4194304 | decode | 409814.000 | base64-turbo-0.6.0 | 414197.500 | 1.011x |
| native | url-safe | 4194304 | encode | 551464.000 | base64-turbo-0.6.0 | 410700.000 | 0.745x |
| native | url-safe-no-pad | 32 | decode | 12.489 | base64-simd-0.8.0 | 11.148 | 0.893x |
| native | url-safe-no-pad | 32 | encode | 9.442 | base64-turbo-0.6.0 | 9.245 | 0.979x |
| native | url-safe-no-pad | 128 | decode | 13.509 | encodify-1.0.2 | 18.092 | 1.339x |
| native | url-safe-no-pad | 128 | encode | 11.955 | base64-turbo-0.6.0 | 10.321 | 0.863x |
| native | url-safe-no-pad | 4096 | decode | 142.677 | base64-turbo-0.6.0 | 127.415 | 0.893x |
| native | url-safe-no-pad | 4096 | encode | 97.472 | base64-turbo-0.6.0 | 84.790 | 0.870x |
| native | url-safe-no-pad | 65536 | decode | 2601.389 | base64-turbo-0.6.0 | 2182.936 | 0.839x |
| native | url-safe-no-pad | 65536 | encode | 2117.178 | base64-turbo-0.6.0 | 2509.493 | 1.185x |
| native | url-safe-no-pad | 1048576 | decode | 75715.286 | base64-turbo-0.6.0 | 62156.148 | 0.821x |
| native | url-safe-no-pad | 1048576 | encode | 77751.636 | encodify-1.0.2 | 80193.952 | 1.031x |
| native | url-safe-no-pad | 4194304 | decode | 597642.750 | base64-turbo-0.6.0 | 439899.500 | 0.736x |
| native | url-safe-no-pad | 4194304 | encode | 429381.500 | base64-turbo-0.6.0 | 402493.200 | 0.937x |

## Ablations

Rows aggregate all primary mode/size cases for z64, except the short-path row, which uses every predefined short-path size (0–33 bytes) and all four modes. Ratios above 1 favor the second build.

| Comparison | Operation | Cases | Geometric mean speedup | Minimum | Maximum |
|---|---|---:|---:|---:|---:|
| reference → scalar | encode | 24 | 1.501x | 0.872x | 3.886x |
| reference → scalar | decode | 24 | 4.476x | 1.489x | 12.448x |
| scalar → no-avx512 | encode | 24 | 5.470x | 1.477x | 17.137x |
| scalar → no-avx512 | decode | 24 | 5.861x | 1.708x | 15.480x |
| no-avx512 → generic | encode | 24 | 1.429x | 0.620x | 3.606x |
| no-avx512 → generic | decode | 24 | 1.671x | 1.034x | 3.506x |
| scalar → generic | encode | 24 | 7.817x | 1.486x | 50.945x |
| scalar → generic | decode | 24 | 9.793x | 1.928x | 40.919x |
| generic → native | encode | 24 | 1.065x | 0.655x | 2.377x |
| generic → native | decode | 24 | 0.977x | 0.436x | 1.521x |
| native → compiletime-native | encode | 24 | 0.975x | 0.712x | 1.497x |
| native → compiletime-native | decode | 24 | 1.077x | 0.693x | 2.126x |
| no-short-path → generic | encode | 52 | 1.033x | 0.598x | 2.481x |
| no-short-path → generic | decode | 52 | 1.015x | 0.551x | 7.757x |

Raw samples include every non-primary boundary length, every baseline and invalid characters at the head, middle and tail. The *.csv.gz files contain losslessly compressed CSV; summary.csv.gz contains all medians, ranges and sample counts; paired.csv.gz contains every available before/after comparison, including errors and regressions.
