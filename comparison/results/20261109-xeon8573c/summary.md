# Measured comparison

These samples describe the recorded host and build only. They do not establish dedicated-hardware results or a general speed guarantee.
All baselines use strict alphabet, padding and unused-bit rules; the differential gate must pass before measurement.
Latency is the median of repeated samples. Throughput uses original binary bytes; rejected inputs have latency only.

## All predefined primary workloads

The 24 primary cases per operation cover six sizes and all four modes. Each ratio uses the fastest competitor in that same case. A ratio above 1 favors z64.

| Build | Operation | Cases | At least 2x | Geometric mean ratio | Minimum ratio | Maximum ratio |
|---|---|---:|---:|---:|---:|---:|
| generic | encode | 24 | 0 | 0.481x | 0.195x | 0.896x |
| generic | decode | 24 | 0 | 0.512x | 0.209x | 0.928x |
| native | encode | 24 | 0 | 0.422x | 0.147x | 0.854x |
| native | decode | 24 | 0 | 0.559x | 0.289x | 1.011x |

## Per-case primary results

| Build | Mode | Binary bytes | Operation | z64 ns | Fastest competitor | Competitor ns | Ratio |
|---|---|---:|---|---:|---|---:|---:|
| generic | standard | 32 | decode | 15.546 | base64-simd-0.8.0 | 13.070 | 0.841x |
| generic | standard | 32 | encode | 14.531 | base64-turbo-0.6.0 | 9.948 | 0.685x |
| generic | standard | 128 | decode | 26.330 | base64-turbo-0.6.0 | 16.920 | 0.643x |
| generic | standard | 128 | encode | 29.737 | base64-turbo-0.6.0 | 17.738 | 0.596x |
| generic | standard | 4096 | decode | 534.653 | base64-turbo-0.6.0 | 148.237 | 0.277x |
| generic | standard | 4096 | encode | 661.454 | base64-turbo-0.6.0 | 137.999 | 0.209x |
| generic | standard | 65536 | decode | 6370.692 | base64-turbo-0.6.0 | 1844.205 | 0.289x |
| generic | standard | 65536 | encode | 7324.389 | base64-turbo-0.6.0 | 2375.417 | 0.324x |
| generic | standard | 1048576 | decode | 116670.833 | base64-turbo-0.6.0 | 73419.281 | 0.629x |
| generic | standard | 1048576 | encode | 148719.000 | encodify-1.0.2 | 66026.000 | 0.444x |
| generic | standard | 4194304 | decode | 496167.000 | base64-turbo-0.6.0 | 460324.800 | 0.928x |
| generic | standard | 4194304 | encode | 649226.000 | encodify-1.0.2 | 348298.750 | 0.536x |
| generic | standard-no-pad | 32 | decode | 18.863 | base64-simd-0.8.0 | 8.707 | 0.462x |
| generic | standard-no-pad | 32 | encode | 12.791 | base64-turbo-0.6.0 | 11.403 | 0.891x |
| generic | standard-no-pad | 128 | decode | 22.677 | base64-turbo-0.6.0 | 18.196 | 0.802x |
| generic | standard-no-pad | 128 | encode | 19.632 | base64-turbo-0.6.0 | 13.666 | 0.696x |
| generic | standard-no-pad | 4096 | decode | 429.180 | base64-turbo-0.6.0 | 135.224 | 0.315x |
| generic | standard-no-pad | 4096 | encode | 432.563 | base64-turbo-0.6.0 | 90.745 | 0.210x |
| generic | standard-no-pad | 65536 | decode | 11211.887 | base64-turbo-0.6.0 | 2446.688 | 0.218x |
| generic | standard-no-pad | 65536 | encode | 7034.714 | base64-turbo-0.6.0 | 2599.852 | 0.370x |
| generic | standard-no-pad | 1048576 | decode | 87000.700 | base64-turbo-0.6.0 | 74822.250 | 0.860x |
| generic | standard-no-pad | 1048576 | encode | 113627.875 | encodify-1.0.2 | 83236.533 | 0.733x |
| generic | standard-no-pad | 4194304 | decode | 539704.333 | base64-turbo-0.6.0 | 325904.500 | 0.604x |
| generic | standard-no-pad | 4194304 | encode | 562809.000 | base64-turbo-0.6.0 | 430426.500 | 0.765x |
| generic | url-safe | 32 | decode | 15.553 | base64-simd-0.8.0 | 11.473 | 0.738x |
| generic | url-safe | 32 | encode | 17.370 | base64-turbo-0.6.0 | 10.362 | 0.597x |
| generic | url-safe | 128 | decode | 21.502 | base64-turbo-0.6.0 | 13.773 | 0.641x |
| generic | url-safe | 128 | encode | 24.489 | base64-turbo-0.6.0 | 13.060 | 0.533x |
| generic | url-safe | 4096 | decode | 452.272 | base64-turbo-0.6.0 | 118.745 | 0.263x |
| generic | url-safe | 4096 | encode | 453.132 | base64-turbo-0.6.0 | 88.274 | 0.195x |
| generic | url-safe | 65536 | decode | 5420.353 | base64-turbo-0.6.0 | 3114.805 | 0.575x |
| generic | url-safe | 65536 | encode | 6726.196 | base64-turbo-0.6.0 | 2527.047 | 0.376x |
| generic | url-safe | 1048576 | decode | 106282.882 | base64-turbo-0.6.0 | 73949.688 | 0.696x |
| generic | url-safe | 1048576 | encode | 234326.300 | base64-turbo-0.6.0 | 74953.600 | 0.320x |
| generic | url-safe | 4194304 | decode | 524236.500 | base64-turbo-0.6.0 | 377319.600 | 0.720x |
| generic | url-safe | 4194304 | encode | 503811.000 | base64-turbo-0.6.0 | 344027.667 | 0.683x |
| generic | url-safe-no-pad | 32 | decode | 22.713 | base64-simd-0.8.0 | 12.576 | 0.554x |
| generic | url-safe-no-pad | 32 | encode | 13.328 | base64-turbo-0.6.0 | 11.942 | 0.896x |
| generic | url-safe-no-pad | 128 | decode | 21.659 | encodify-1.0.2 | 18.318 | 0.846x |
| generic | url-safe-no-pad | 128 | encode | 21.105 | base64-turbo-0.6.0 | 13.088 | 0.620x |
| generic | url-safe-no-pad | 4096 | decode | 774.119 | base64-turbo-0.6.0 | 162.052 | 0.209x |
| generic | url-safe-no-pad | 4096 | encode | 546.704 | base64-turbo-0.6.0 | 107.593 | 0.197x |
| generic | url-safe-no-pad | 65536 | decode | 7891.020 | base64-turbo-0.6.0 | 2203.136 | 0.279x |
| generic | url-safe-no-pad | 65536 | encode | 6852.147 | base64-turbo-0.6.0 | 3403.792 | 0.497x |
| generic | url-safe-no-pad | 1048576 | decode | 128389.333 | base64-turbo-0.6.0 | 58776.200 | 0.458x |
| generic | url-safe-no-pad | 1048576 | encode | 140196.000 | encodify-1.0.2 | 79353.920 | 0.566x |
| generic | url-safe-no-pad | 4194304 | decode | 490223.000 | base64-turbo-0.6.0 | 339801.400 | 0.693x |
| generic | url-safe-no-pad | 4194304 | encode | 493573.000 | base64-turbo-0.6.0 | 411389.250 | 0.833x |
| native | standard | 32 | decode | 14.971 | base64-simd-0.8.0 | 10.085 | 0.674x |
| native | standard | 32 | encode | 12.621 | base64-turbo-0.6.0 | 8.855 | 0.702x |
| native | standard | 128 | decode | 25.262 | base64-simd-0.8.0 | 15.430 | 0.611x |
| native | standard | 128 | encode | 19.433 | base64-turbo-0.6.0 | 9.336 | 0.480x |
| native | standard | 4096 | decode | 507.491 | base64-turbo-0.6.0 | 201.906 | 0.398x |
| native | standard | 4096 | encode | 529.826 | base64-turbo-0.6.0 | 104.021 | 0.196x |
| native | standard | 65536 | decode | 7875.032 | base64-turbo-0.6.0 | 2958.362 | 0.376x |
| native | standard | 65536 | encode | 9667.989 | base64-turbo-0.6.0 | 2374.670 | 0.246x |
| native | standard | 1048576 | decode | 134488.333 | base64-turbo-0.6.0 | 84183.619 | 0.626x |
| native | standard | 1048576 | encode | 179458.455 | base64-turbo-0.6.0 | 80392.077 | 0.448x |
| native | standard | 4194304 | decode | 448809.000 | base64-turbo-0.6.0 | 353087.200 | 0.787x |
| native | standard | 4194304 | encode | 553139.000 | base64-turbo-0.6.0 | 401480.600 | 0.726x |
| native | standard-no-pad | 32 | decode | 12.893 | base64-simd-0.8.0 | 11.971 | 0.928x |
| native | standard-no-pad | 32 | encode | 12.247 | base64-turbo-0.6.0 | 10.461 | 0.854x |
| native | standard-no-pad | 128 | decode | 17.979 | base64-turbo-0.6.0 | 18.179 | 1.011x |
| native | standard-no-pad | 128 | encode | 21.747 | base64-turbo-0.6.0 | 11.696 | 0.538x |
| native | standard-no-pad | 4096 | decode | 621.782 | base64-turbo-0.6.0 | 191.497 | 0.308x |
| native | standard-no-pad | 4096 | encode | 748.968 | base64-turbo-0.6.0 | 110.317 | 0.147x |
| native | standard-no-pad | 65536 | decode | 8526.655 | base64-turbo-0.6.0 | 2465.948 | 0.289x |
| native | standard-no-pad | 65536 | encode | 11035.439 | base64-turbo-0.6.0 | 3219.971 | 0.292x |
| native | standard-no-pad | 1048576 | decode | 140066.667 | base64-turbo-0.6.0 | 68013.550 | 0.486x |
| native | standard-no-pad | 1048576 | encode | 147513.250 | base64-turbo-0.6.0 | 78339.450 | 0.531x |
| native | standard-no-pad | 4194304 | decode | 515503.750 | base64-turbo-0.6.0 | 334523.667 | 0.649x |
| native | standard-no-pad | 4194304 | encode | 494395.333 | base64-turbo-0.6.0 | 389961.750 | 0.789x |
| native | url-safe | 32 | decode | 15.257 | base64-simd-0.8.0 | 12.203 | 0.800x |
| native | url-safe | 32 | encode | 13.350 | base64-turbo-0.6.0 | 9.982 | 0.748x |
| native | url-safe | 128 | decode | 23.334 | base64-turbo-0.6.0 | 18.283 | 0.784x |
| native | url-safe | 128 | encode | 24.725 | base64-turbo-0.6.0 | 11.741 | 0.475x |
| native | url-safe | 4096 | decode | 529.819 | base64-turbo-0.6.0 | 177.796 | 0.336x |
| native | url-safe | 4096 | encode | 732.675 | base64-turbo-0.6.0 | 116.732 | 0.159x |
| native | url-safe | 65536 | decode | 11042.058 | base64-turbo-0.6.0 | 3253.295 | 0.295x |
| native | url-safe | 65536 | encode | 10366.982 | base64-turbo-0.6.0 | 2885.652 | 0.278x |
| native | url-safe | 1048576 | decode | 93758.080 | base64-turbo-0.6.0 | 62663.645 | 0.668x |
| native | url-safe | 1048576 | encode | 125042.333 | base64-turbo-0.6.0 | 68022.920 | 0.544x |
| native | url-safe | 4194304 | decode | 498161.000 | base64-turbo-0.6.0 | 382790.750 | 0.768x |
| native | url-safe | 4194304 | encode | 664566.000 | base64-turbo-0.6.0 | 357142.750 | 0.537x |
| native | url-safe-no-pad | 32 | decode | 31.818 | base64-simd-0.8.0 | 21.979 | 0.691x |
| native | url-safe-no-pad | 32 | encode | 13.223 | base64-turbo-0.6.0 | 8.284 | 0.627x |
| native | url-safe-no-pad | 128 | decode | 19.189 | base64-turbo-0.6.0 | 17.498 | 0.912x |
| native | url-safe-no-pad | 128 | encode | 17.463 | base64-turbo-0.6.0 | 8.913 | 0.510x |
| native | url-safe-no-pad | 4096 | decode | 691.546 | base64-turbo-0.6.0 | 219.019 | 0.317x |
| native | url-safe-no-pad | 4096 | encode | 595.579 | base64-turbo-0.6.0 | 114.139 | 0.192x |
| native | url-safe-no-pad | 65536 | decode | 8138.347 | base64-turbo-0.6.0 | 2888.496 | 0.355x |
| native | url-safe-no-pad | 65536 | encode | 10733.556 | base64-turbo-0.6.0 | 2549.102 | 0.237x |
| native | url-safe-no-pad | 1048576 | decode | 93987.545 | base64-turbo-0.6.0 | 61845.640 | 0.658x |
| native | url-safe-no-pad | 1048576 | encode | 140555.286 | base64-turbo-0.6.0 | 75948.286 | 0.540x |
| native | url-safe-no-pad | 4194304 | decode | 568335.500 | base64-turbo-0.6.0 | 418720.750 | 0.737x |
| native | url-safe-no-pad | 4194304 | encode | 599998.667 | base64-turbo-0.6.0 | 383752.400 | 0.640x |

## Ablations

Rows aggregate all primary mode/size cases for z64, except the short-path row, which uses every predefined short-path size (0–33 bytes) and all four modes. Ratios above 1 favor the second build.

| Comparison | Operation | Cases | Geometric mean speedup | Minimum | Maximum |
|---|---|---:|---:|---:|---:|
| reference → scalar | encode | 24 | 1.539x | 1.031x | 5.433x |
| reference → scalar | decode | 24 | 4.732x | 1.181x | 16.804x |
| scalar → generic | encode | 24 | 3.808x | 1.260x | 6.216x |
| scalar → generic | decode | 24 | 5.751x | 1.585x | 23.281x |
| generic → native | encode | 24 | 0.937x | 0.578x | 1.874x |
| generic → native | decode | 24 | 0.969x | 0.491x | 1.463x |
| native → compiletime-native | encode | 24 | 0.969x | 0.640x | 1.406x |
| native → compiletime-native | decode | 24 | 1.056x | 0.296x | 2.508x |
| no-short-path → generic | encode | 52 | 1.106x | 0.290x | 2.511x |
| no-short-path → generic | decode | 52 | 1.132x | 0.421x | 2.561x |

Raw samples include every non-primary boundary length, every baseline and invalid characters at the head, middle and tail. The *.csv.gz files contain losslessly compressed CSV; summary.csv.gz contains all medians, ranges and sample counts.
