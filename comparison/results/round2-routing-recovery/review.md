# Focused check after the 32-character routing correction

This diagnostic compares old commit `d91c6bf` with `181babf` plus the recorded
worktree patch. The patch sends only a 32-character decode body to AVX2 on a
VBMI-capable machine; larger bodies retain VBMI and encoding is unchanged.
Both implementations run in one binary with identical inputs and output
capacities, 64-byte-aligned output slices and 19 paired samples. Every row is
retained in `generic.csv.gz` and `native.csv.gz`.

Each value below is the geometric mean over the four modes of the median
sample-paired old/current latency ratio. Values above 1 favor the patched code.

| Binary bytes | Generic decode | Native decode |
|---|---:|---:|
| 24 | 0.887x | 1.287x |
| 25 | 0.979x | 1.009x |
| 26 | 0.960x | 1.013x |
| 31 | 1.132x | 1.222x |
| 32 | 1.147x | 1.262x |
| 33 | 1.281x | 1.425x |
| 48 | 1.084x | 0.981x |

The 25- and 26-byte aggregates return near the old implementation's latency,
while the 31–33 byte controls retain their direction of improvement. At 24
bytes the generic result remains mixed: ratios in Standard, StandardNoPad,
UrlSafe and UrlSafeNoPad order are 0.919x, 0.749x, 0.987x and 0.912x. Native
24-byte ratios are 1.064x, 0.978x, 1.642x and 1.605x, with unusually large URL
mode differences. These data do not support a universal short-input win or
the assertion that every regression has disappeared.

The probe includes an extra raw length of 26, changing the subsequent quick
grid's RNG stream. Absolute latencies from earlier quick runs are therefore
not used as a paired before/after experiment. This is a bounded routing check;
the complete fixed matrix on the final immutable source provides the final
performance report.
