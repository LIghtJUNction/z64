# Measured comparison

These samples describe the recorded host and build only. They do not establish dedicated-hardware results or a general speed guarantee.
All baselines use strict alphabet, padding and unused-bit rules; the differential gate must pass before measurement.
Latency is the median of repeated samples. Throughput uses original binary bytes; rejected inputs have latency only.

## All predefined primary workloads

The 24 primary cases per operation cover six sizes and all four modes. Each ratio uses the fastest competitor in that same case. A ratio above 1 favors z64.

| Build | Operation | Cases | At least 2x | Geometric mean ratio | Minimum ratio | Maximum ratio |
|---|---|---:|---:|---:|---:|---:|
| generic | encode | 24 | 0 | 0.949x | 0.420x | 1.188x |
| generic | decode | 24 | 0 | 0.857x | 0.505x | 1.098x |
| native | encode | 24 | 1 | 0.895x | 0.282x | 2.213x |
| native | decode | 24 | 0 | 0.921x | 0.520x | 1.608x |

## Paired comparison with the previous z64

The previous version is Git commit d91c6bfbc447061ab4fd2f04feeb65045a6de329. Both versions share one binary, compiler, flags, input bytes and output capacities. Each case uses the median of old/new ratios paired by sample index; ratios above 1 favor the current code. The old version is excluded from external competitor rankings.

| Build | Operation | Primary cases | Current faster | At least 2x | Geometric mean paired ratio | Minimum | Maximum |
|---|---|---:|---:|---:|---:|---:|---:|
| generic | encode | 24 | 24 | 9 | 2.034x | 1.144x | 5.479x |
| generic | decode | 24 | 24 | 9 | 1.644x | 1.115x | 2.969x |
| native | encode | 24 | 23 | 9 | 2.215x | 0.692x | 6.246x |
| native | decode | 24 | 23 | 7 | 1.629x | 0.456x | 6.747x |

## Per-case primary results

| Build | Mode | Binary bytes | Operation | z64 ns | Fastest competitor | Competitor ns | Ratio |
|---|---|---:|---|---:|---|---:|---:|
| generic | standard | 32 | decode | 15.239 | base64-simd-0.8.0 | 12.401 | 0.814x |
| generic | standard | 32 | encode | 11.880 | base64-turbo-0.6.0 | 10.233 | 0.861x |
| generic | standard | 128 | decode | 24.700 | encodify-1.0.2 | 22.002 | 0.891x |
| generic | standard | 128 | encode | 23.399 | base64-turbo-0.6.0 | 19.313 | 0.825x |
| generic | standard | 4096 | decode | 143.480 | base64-turbo-0.6.0 | 126.817 | 0.884x |
| generic | standard | 4096 | encode | 93.905 | base64-turbo-0.6.0 | 94.473 | 1.006x |
| generic | standard | 65536 | decode | 2492.319 | base64-turbo-0.6.0 | 2076.121 | 0.833x |
| generic | standard | 65536 | encode | 2262.500 | base64-turbo-0.6.0 | 2183.048 | 0.965x |
| generic | standard | 1048576 | decode | 79894.440 | base64-turbo-0.6.0 | 80606.200 | 1.009x |
| generic | standard | 1048576 | encode | 82965.222 | base64-turbo-0.6.0 | 74778.200 | 0.901x |
| generic | standard | 4194304 | decode | 371166.750 | base64-turbo-0.6.0 | 344060.500 | 0.927x |
| generic | standard | 4194304 | encode | 489153.750 | base64-turbo-0.6.0 | 376848.250 | 0.770x |
| generic | standard-no-pad | 32 | decode | 15.605 | base64-simd-0.8.0 | 11.408 | 0.731x |
| generic | standard-no-pad | 32 | encode | 12.489 | base64-turbo-0.6.0 | 13.710 | 1.098x |
| generic | standard-no-pad | 128 | decode | 32.424 | encodify-1.0.2 | 24.220 | 0.747x |
| generic | standard-no-pad | 128 | encode | 20.767 | base64-turbo-0.6.0 | 22.718 | 1.094x |
| generic | standard-no-pad | 4096 | decode | 145.022 | base64-turbo-0.6.0 | 115.876 | 0.799x |
| generic | standard-no-pad | 4096 | encode | 85.317 | base64-turbo-0.6.0 | 89.634 | 1.051x |
| generic | standard-no-pad | 65536 | decode | 2610.725 | base64-turbo-0.6.0 | 2581.249 | 0.989x |
| generic | standard-no-pad | 65536 | encode | 2205.721 | base64-turbo-0.6.0 | 2201.316 | 0.998x |
| generic | standard-no-pad | 1048576 | decode | 69871.056 | base64-turbo-0.6.0 | 64687.692 | 0.926x |
| generic | standard-no-pad | 1048576 | encode | 77609.138 | base64-turbo-0.6.0 | 73817.036 | 0.951x |
| generic | standard-no-pad | 4194304 | decode | 392194.800 | base64-turbo-0.6.0 | 430767.600 | 1.098x |
| generic | standard-no-pad | 4194304 | encode | 408030.000 | base64-turbo-0.6.0 | 400031.000 | 0.980x |
| generic | url-safe | 32 | decode | 14.739 | base64-simd-0.8.0 | 11.690 | 0.793x |
| generic | url-safe | 32 | encode | 11.256 | base64-turbo-0.6.0 | 10.646 | 0.946x |
| generic | url-safe | 128 | decode | 31.518 | base64-turbo-0.6.0 | 15.928 | 0.505x |
| generic | url-safe | 128 | encode | 12.220 | base64-turbo-0.6.0 | 12.287 | 1.005x |
| generic | url-safe | 4096 | decode | 135.800 | base64-turbo-0.6.0 | 126.657 | 0.933x |
| generic | url-safe | 4096 | encode | 87.713 | base64-turbo-0.6.0 | 89.147 | 1.016x |
| generic | url-safe | 65536 | decode | 2369.780 | base64-turbo-0.6.0 | 2156.808 | 0.910x |
| generic | url-safe | 65536 | encode | 2256.690 | base64-turbo-0.6.0 | 2353.022 | 1.043x |
| generic | url-safe | 1048576 | decode | 76356.077 | base64-turbo-0.6.0 | 59984.107 | 0.786x |
| generic | url-safe | 1048576 | encode | 75714.846 | encodify-1.0.2 | 74979.040 | 0.990x |
| generic | url-safe | 4194304 | decode | 395634.500 | base64-turbo-0.6.0 | 348125.500 | 0.880x |
| generic | url-safe | 4194304 | encode | 405727.500 | base64-turbo-0.6.0 | 368711.200 | 0.909x |
| generic | url-safe-no-pad | 32 | decode | 13.647 | base64-simd-0.8.0 | 11.935 | 0.875x |
| generic | url-safe-no-pad | 32 | encode | 11.148 | base64-turbo-0.6.0 | 13.248 | 1.188x |
| generic | url-safe-no-pad | 128 | decode | 22.074 | base64-simd-0.8.0 | 20.126 | 0.912x |
| generic | url-safe-no-pad | 128 | encode | 29.131 | base64-turbo-0.6.0 | 12.243 | 0.420x |
| generic | url-safe-no-pad | 4096 | decode | 143.053 | base64-turbo-0.6.0 | 126.047 | 0.881x |
| generic | url-safe-no-pad | 4096 | encode | 86.382 | base64-turbo-0.6.0 | 91.563 | 1.060x |
| generic | url-safe-no-pad | 65536 | decode | 2602.236 | base64-turbo-0.6.0 | 2258.143 | 0.868x |
| generic | url-safe-no-pad | 65536 | encode | 2161.818 | base64-turbo-0.6.0 | 2527.192 | 1.169x |
| generic | url-safe-no-pad | 1048576 | decode | 81076.158 | base64-turbo-0.6.0 | 70091.962 | 0.865x |
| generic | url-safe-no-pad | 1048576 | encode | 70475.050 | base64-turbo-0.6.0 | 74938.600 | 1.063x |
| generic | url-safe-no-pad | 4194304 | decode | 395156.500 | base64-turbo-0.6.0 | 354843.800 | 0.898x |
| generic | url-safe-no-pad | 4194304 | encode | 411011.750 | base64-turbo-0.6.0 | 352398.000 | 0.857x |
| native | standard | 32 | decode | 14.123 | base64-simd-0.8.0 | 13.010 | 0.921x |
| native | standard | 32 | encode | 8.739 | base64-turbo-0.6.0 | 9.420 | 1.078x |
| native | standard | 128 | decode | 14.224 | base64-turbo-0.6.0 | 15.620 | 1.098x |
| native | standard | 128 | encode | 12.219 | base64-turbo-0.6.0 | 10.647 | 0.871x |
| native | standard | 4096 | decode | 144.444 | base64-turbo-0.6.0 | 114.392 | 0.792x |
| native | standard | 4096 | encode | 94.927 | base64-turbo-0.6.0 | 92.531 | 0.975x |
| native | standard | 65536 | decode | 2392.958 | base64-turbo-0.6.0 | 1966.185 | 0.822x |
| native | standard | 65536 | encode | 2290.866 | base64-turbo-0.6.0 | 2152.430 | 0.940x |
| native | standard | 1048576 | decode | 72126.423 | base64-turbo-0.6.0 | 60702.286 | 0.842x |
| native | standard | 1048576 | encode | 73473.720 | base64-turbo-0.6.0 | 68294.231 | 0.930x |
| native | standard | 4194304 | decode | 1000092.000 | base64-turbo-0.6.0 | 550698.000 | 0.551x |
| native | standard | 4194304 | encode | 2050068.000 | encodify-1.0.2 | 578818.000 | 0.282x |
| native | standard-no-pad | 32 | decode | 13.603 | base64-simd-0.8.0 | 12.253 | 0.901x |
| native | standard-no-pad | 32 | encode | 8.639 | base64-turbo-0.6.0 | 9.580 | 1.109x |
| native | standard-no-pad | 128 | decode | 12.859 | base64-turbo-0.6.0 | 16.653 | 1.295x |
| native | standard-no-pad | 128 | encode | 12.199 | base64-turbo-0.6.0 | 12.933 | 1.060x |
| native | standard-no-pad | 4096 | decode | 139.960 | base64-turbo-0.6.0 | 133.186 | 0.952x |
| native | standard-no-pad | 4096 | encode | 89.334 | base64-turbo-0.6.0 | 90.217 | 1.010x |
| native | standard-no-pad | 65536 | decode | 2774.033 | base64-turbo-0.6.0 | 2437.401 | 0.879x |
| native | standard-no-pad | 65536 | encode | 2615.135 | base64-turbo-0.6.0 | 2308.701 | 0.883x |
| native | standard-no-pad | 1048576 | decode | 80354.848 | base64-turbo-0.6.0 | 57010.333 | 0.709x |
| native | standard-no-pad | 1048576 | encode | 76294.071 | base64-turbo-0.6.0 | 73203.087 | 0.959x |
| native | standard-no-pad | 4194304 | decode | 458040.000 | encodify-1.0.2 | 736327.000 | 1.608x |
| native | standard-no-pad | 4194304 | encode | 351083.000 | base64-turbo-0.6.0 | 777022.000 | 2.213x |
| native | url-safe | 32 | decode | 12.451 | base64-simd-0.8.0 | 10.177 | 0.817x |
| native | url-safe | 32 | encode | 9.208 | base64-turbo-0.6.0 | 8.678 | 0.942x |
| native | url-safe | 128 | decode | 15.580 | base64-turbo-0.6.0 | 16.192 | 1.039x |
| native | url-safe | 128 | encode | 11.281 | base64-turbo-0.6.0 | 11.139 | 0.987x |
| native | url-safe | 4096 | decode | 135.338 | base64-turbo-0.6.0 | 133.257 | 0.985x |
| native | url-safe | 4096 | encode | 95.810 | base64-turbo-0.6.0 | 84.065 | 0.877x |
| native | url-safe | 65536 | decode | 2483.542 | base64-turbo-0.6.0 | 2046.352 | 0.824x |
| native | url-safe | 65536 | encode | 2629.191 | base64-turbo-0.6.0 | 2391.567 | 0.910x |
| native | url-safe | 1048576 | decode | 74349.500 | base64-turbo-0.6.0 | 63911.703 | 0.860x |
| native | url-safe | 1048576 | encode | 71942.067 | base64-turbo-0.6.0 | 65066.000 | 0.904x |
| native | url-safe | 4194304 | decode | 545854.500 | encodify-1.0.2 | 513193.000 | 0.940x |
| native | url-safe | 4194304 | encode | 426610.000 | base64-vector-0.23.1 | 458885.000 | 1.076x |
| native | url-safe-no-pad | 32 | decode | 11.362 | base64-simd-0.8.0 | 10.663 | 0.938x |
| native | url-safe-no-pad | 32 | encode | 9.119 | base64-turbo-0.6.0 | 9.070 | 0.995x |
| native | url-safe-no-pad | 128 | decode | 14.705 | encodify-1.0.2 | 19.392 | 1.319x |
| native | url-safe-no-pad | 128 | encode | 11.304 | base64-turbo-0.6.0 | 10.733 | 0.950x |
| native | url-safe-no-pad | 4096 | decode | 134.106 | base64-turbo-0.6.0 | 129.673 | 0.967x |
| native | url-safe-no-pad | 4096 | encode | 85.240 | base64-turbo-0.6.0 | 87.907 | 1.031x |
| native | url-safe-no-pad | 65536 | decode | 6547.826 | encodify-1.0.2 | 3405.167 | 0.520x |
| native | url-safe-no-pad | 65536 | encode | 8832.037 | base64-turbo-0.6.0 | 3010.679 | 0.341x |
| native | url-safe-no-pad | 1048576 | decode | 67091.500 | encodify-1.0.2 | 75157.600 | 1.120x |
| native | url-safe-no-pad | 1048576 | encode | 88110.333 | encodify-1.0.2 | 63561.000 | 0.721x |
| native | url-safe-no-pad | 4194304 | decode | 360875.250 | base64-turbo-0.6.0 | 380917.833 | 1.056x |
| native | url-safe-no-pad | 4194304 | encode | 442588.000 | base64-turbo-0.6.0 | 352948.500 | 0.797x |

## Ablations

Rows aggregate all primary mode/size cases for z64, except the short-path row, which uses every predefined short-path size (0–33 bytes) and all four modes. Ratios above 1 favor the second build.

| Comparison | Operation | Cases | Geometric mean speedup | Minimum | Maximum |
|---|---|---:|---:|---:|---:|
| reference → scalar | encode | 24 | 2.095x | 1.018x | 4.229x |
| reference → scalar | decode | 24 | 6.944x | 1.511x | 38.353x |
| scalar → no-avx512 | encode | 24 | 5.103x | 1.295x | 11.374x |
| scalar → no-avx512 | decode | 24 | 5.050x | 1.293x | 10.591x |
| no-avx512 → generic | encode | 24 | 1.456x | 0.564x | 6.911x |
| no-avx512 → generic | decode | 24 | 1.673x | 0.662x | 6.655x |
| scalar → generic | encode | 24 | 7.431x | 1.531x | 29.096x |
| scalar → generic | decode | 24 | 8.449x | 1.864x | 23.984x |
| generic → native | encode | 24 | 0.999x | 0.239x | 2.577x |
| generic → native | decode | 24 | 1.045x | 0.371x | 2.522x |
| native → compiletime-native | encode | 24 | 1.038x | 0.514x | 5.375x |
| native → compiletime-native | decode | 24 | 1.025x | 0.596x | 2.714x |
| no-short-path → generic | encode | 52 | 1.194x | 0.545x | 3.945x |
| no-short-path → generic | decode | 52 | 1.168x | 0.527x | 13.317x |

Raw samples include every non-primary boundary length, every baseline and invalid characters at the head, middle and tail. The *.csv.gz files contain losslessly compressed CSV; summary.csv.gz contains all medians, ranges and sample counts; paired.csv.gz contains every available before/after comparison, including errors and regressions.
