# Combined scalar-tail and fixed-chunk probe

This run measures the public API with both the empty scalar-body bypass and the reviewed fixed-chunk SWAR decoder. The exact production and tracked harness changes are in `worktree.patch`; the reference version is unmodified `cda77a6bd866be19831decc420e95a5a5bd79e75`. Both versions share one binary, inputs, flags, output capacities and 64-byte output alignment. Generic and native builds use the unchanged development quick grid, 11 paired samples, a 2 ms target and CPU 2 affinity. Every result and guard check passed; all 9,856 raw samples are retained. Encoding remains an unchanged control.

## Decision evidence

The candidate improves every mode in both builds at each of 15, 16, 17, 23, 24, 25 and 26 raw bytes. The four-mode decode geometric means at 15–17 bytes are 1.172–1.180x generic and 1.160–1.188x native. At 23–26 measured bytes they are 1.144–1.238x generic and 1.193–1.292x native. This is a consistent token-path improvement in this probe, supporting a frozen-source full-workload evaluation.

Three-byte decoding remains mixed at 0.966x generic and 0.994x native, compared with 0.914x / 0.912x in the preceding guard-only probe. These are separate runs, so their difference is not a direct same-binary estimate of the scalar edit alone. The independent scalar study and the complete retained observations provide the supporting context.

There is no bulk-throughput gain: 4 KiB ratios are 0.986x / 1.029x and 1 MiB ratios 0.955x / 0.943x. The latter losses are retained. Across all 112 decode cases per build, geometric means are 1.127x / 1.167x and 101 / 99 medians exceed one. Unchanged encode-control means are 0.995x / 1.010x, with substantial individual scatter. These figures do not establish an unconditional percentage gain or an external-competitor advantage.

## All measured lengths

Each decode cell shows the geometric mean over four modes, then the minimum–maximum of their median sample-paired old/current ratios. Encode cells show control geometric means. Values above one favor the candidate. No invalid-input performance is measured by this focused gate.

| Binary bytes | Generic decode [mode range] | Native decode [mode range] | Generic encode control | Native encode control |
|---|---:|---:|---:|---:|
| 0 | 0.995x [0.927–1.086] | 0.955x [0.931–0.984] | 0.943x | 0.955x |
| 1 | 1.223x [1.179–1.327] | 1.432x [1.159–1.862] | 1.032x | 1.001x |
| 2 | 1.371x [1.335–1.406] | 1.264x [1.220–1.339] | 1.028x | 1.041x |
| 3 | 0.966x [0.883–1.054] | 0.994x [0.946–1.042] | 0.958x | 1.014x |
| 15 | 1.172x [1.110–1.209] | 1.179x [1.079–1.223] | 0.979x | 0.979x |
| 16 | 1.180x [1.044–1.273] | 1.160x [1.078–1.245] | 1.030x | 0.987x |
| 17 | 1.173x [1.116–1.220] | 1.188x [1.109–1.329] | 0.978x | 0.967x |
| 23 | 1.238x [1.166–1.304] | 1.193x [1.113–1.283] | 1.017x | 1.023x |
| 24 | 1.177x [1.145–1.233] | 1.292x [1.147–1.376] | 1.014x | 0.996x |
| 25 | 1.144x [1.096–1.206] | 1.266x [1.128–1.371] | 1.026x | 1.075x |
| 26 | 1.238x [1.186–1.329] | 1.203x [1.113–1.269] | 1.003x | 0.977x |
| 31 | 1.078x [0.999–1.200] | 1.169x [1.136–1.198] | 1.004x | 1.032x |
| 32 | 1.077x [1.000–1.134] | 1.150x [1.048–1.314] | 1.017x | 0.957x |
| 33 | 1.105x [1.080–1.152] | 1.255x [1.160–1.313] | 0.981x | 1.002x |
| 47 | 1.124x [1.040–1.186] | 1.135x [1.109–1.154] | 0.943x | 1.051x |
| 48 | 1.168x [1.107–1.216] | 1.264x [1.239–1.304] | 0.994x | 1.084x |
| 49 | 1.206x [1.124–1.250] | 1.199x [1.168–1.248] | 0.995x | 1.032x |
| 63 | 1.023x [0.887–1.134] | 1.133x [0.972–1.232] | 1.033x | 0.986x |
| 64 | 1.117x [1.003–1.175] | 1.167x [1.078–1.250] | 0.946x | 0.978x |
| 65 | 1.226x [1.105–1.367] | 1.095x [0.952–1.193] | 1.001x | 1.054x |
| 95 | 1.159x [1.066–1.285] | 1.206x [1.148–1.300] | 0.982x | 0.921x |
| 96 | 1.073x [0.999–1.154] | 1.258x [1.194–1.330] | 1.015x | 1.006x |
| 97 | 1.147x [1.100–1.205] | 1.183x [1.124–1.225] | 0.933x | 1.062x |
| 127 | 1.140x [1.043–1.186] | 1.143x [1.027–1.247] | 0.986x | 1.025x |
| 128 | 1.106x [1.013–1.158] | 1.150x [1.129–1.173] | 1.023x | 0.989x |
| 129 | 1.098x [1.024–1.204] | 1.189x [1.134–1.244] | 1.022x | 1.046x |
| 4096 | 0.986x [0.927–1.027] | 1.029x [0.979–1.149] | 0.997x | 0.979x |
| 1048576 | 0.955x [0.881–1.014] | 0.943x [0.838–1.052] | 0.979x | 1.071x |

The 15–26-byte interval contains 15, 16, 17, 23, 24, 25 and 26 in the existing quick grid; 18–22 are not measured. All primary/full/short-path workload sets and baseline versions are unchanged. This gate is not the complete seven-build matrix.

The prior [guard-only probe](../20261110-noop-tail-probe/review.md) and accepted [fixed-chunk scalar study](../20261110-scalar-chunks-study/) remain archived separately, alongside the rejected [direct scalar packing study](../20261110-scalar-direct-study/) and [VBMI bulk study](../20261110-vbmi-bulk-study/). No earlier result or rejected candidate was replaced. `paired.csv.gz` and `summary.csv.gz` preserve every mode and sample range; commands, environment, lockfile, manifest and patch record the setup.
