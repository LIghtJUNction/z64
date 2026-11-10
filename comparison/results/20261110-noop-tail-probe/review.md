# Focused no-op scalar-tail bypass probe

This run compares unmodified `cda77a6bd866be19831decc420e95a5a5bd79e75` with that commit plus the recorded `src/lib.rs` change in `worktree.patch`: call `scalar::decode_body` only when a body suffix remains after SIMD. Encoding is unchanged. Both versions run in one binary, with identical inputs, compilation settings, capacities and 64-byte-aligned output slices. Generic and native builds each use 11 samples, a 2 ms target and CPU 2 affinity. All 9,856 raw samples are retained; every result and output guard check passed.

## Observation

The clearest repeated benefit is decoding 25- and 26-byte inputs: every mode improves in both builds, with four-mode geometric means of 1.210x / 1.260x at 25 bytes and 1.224x / 1.210x at 26 bytes (generic / native). Decoding three bytes consistently regresses: 0.914x / 0.912x, with every mode slower in both builds. The 4 KiB aggregate is near parity at 1.030x / 1.001x; the 1 MiB results disagree in direction at 0.981x / 1.089x. This probe therefore supports a token-path benefit with a small-input tradeoff, not a bulk-throughput claim.

Across all 112 decode cases per build, geometric means are 1.097x generic and 1.101x native; 92 and 90 case medians respectively exceed one. The unchanged encode controls aggregate to 0.998x / 1.009x. Their individual mode/length observations still vary by more than 20%, and native 15-byte decoding spans 0.460x–2.044x across modes. This shared-host dispersion prevents treating every small difference as a causal benefit of the edit. No rows are removed or repeated to improve the conclusion.

## All measured lengths

Each decode cell is the geometric mean across four modes, followed by the minimum–maximum of their median sample-paired old/current ratios. Each encode-control cell is the four-mode geometric mean. Values above one favor the candidate. These are valid-input measurements only.

| Binary bytes | Generic decode [mode range] | Native decode [mode range] | Generic encode control | Native encode control |
|---|---:|---:|---:|---:|
| 0 | 0.943x [0.877–1.007] | 1.026x [0.970–1.088] | 0.855x | 0.961x |
| 1 | 1.106x [1.073–1.158] | 1.335x [1.259–1.421] | 0.991x | 1.003x |
| 2 | 1.136x [1.118–1.148] | 1.141x [0.981–1.294] | 0.974x | 0.986x |
| 3 | 0.914x [0.857–0.948] | 0.912x [0.875–0.973] | 1.023x | 0.963x |
| 15 | 0.998x [0.953–1.046] | 1.091x [0.460–2.044] | 0.981x | 1.016x |
| 16 | 0.967x [0.831–1.051] | 0.997x [0.943–1.051] | 0.986x | 0.956x |
| 17 | 0.987x [0.935–1.020] | 1.004x [0.780–1.275] | 0.984x | 0.959x |
| 23 | 1.017x [1.001–1.038] | 1.005x [0.906–1.082] | 1.037x | 0.992x |
| 24 | 1.098x [1.053–1.132] | 1.145x [1.059–1.226] | 1.079x | 1.059x |
| 25 | 1.210x [1.113–1.357] | 1.260x [1.196–1.389] | 0.982x | 1.010x |
| 26 | 1.224x [1.121–1.312] | 1.210x [1.120–1.374] | 1.064x | 0.987x |
| 31 | 1.116x [1.075–1.196] | 1.191x [1.110–1.295] | 1.004x | 0.959x |
| 32 | 1.082x [0.945–1.166] | 1.066x [1.017–1.120] | 1.050x | 0.930x |
| 33 | 1.168x [1.125–1.254] | 1.025x [0.850–1.101] | 0.980x | 1.013x |
| 47 | 1.071x [1.002–1.141] | 1.051x [0.953–1.178] | 1.001x | 0.972x |
| 48 | 1.253x [1.155–1.367] | 0.944x [0.599–1.199] | 1.020x | 1.162x |
| 49 | 1.156x [1.124–1.177] | 1.223x [1.114–1.377] | 0.978x | 1.069x |
| 63 | 1.201x [1.143–1.264] | 1.086x [1.008–1.151] | 1.028x | 1.073x |
| 64 | 1.124x [1.074–1.149] | 1.161x [1.007–1.360] | 0.973x | 0.940x |
| 65 | 1.153x [1.040–1.390] | 1.192x [1.166–1.219] | 1.013x | 0.951x |
| 95 | 1.212x [1.171–1.299] | 1.047x [0.985–1.072] | 1.001x | 0.998x |
| 96 | 1.157x [1.023–1.338] | 1.186x [1.139–1.315] | 0.996x | 1.234x |
| 97 | 1.175x [1.106–1.236] | 1.180x [1.146–1.220] | 0.988x | 1.091x |
| 127 | 1.126x [1.060–1.219] | 1.154x [0.967–1.284] | 0.999x | 1.024x |
| 128 | 1.160x [1.098–1.232] | 1.075x [1.054–1.114] | 1.000x | 1.031x |
| 129 | 1.060x [0.946–1.179] | 1.162x [1.123–1.207] | 0.987x | 1.088x |
| 4096 | 1.030x [0.981–1.096] | 1.001x [0.937–1.063] | 1.045x | 0.923x |
| 1048576 | 0.981x [0.859–1.084] | 1.089x [1.024–1.271] | 0.953x | 0.968x |

The existing development quick grid was kept unchanged. Within the requested 15–26-byte interval, it measures 15, 16, 17, 23, 24, 25 and 26; it does not measure 18–22. No fixed primary/full workload set changed. This partial probe is not the full seven-build matrix or an external-competitor ranking.

`paired.csv.gz` retains every mode, median latency, sample count and paired range. `summary.csv.gz` retains both implementations. `commands.txt`, `environment.txt`, `worktree.patch`, the lockfile and manifest identify the exact setup. No timed run or raw sample was changed during analysis.
