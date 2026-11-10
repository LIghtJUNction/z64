#!/usr/bin/env python3
"""Aggregate raw samples without discarding slower cases or competitors."""
import csv
import gzip
import json
import math
import re
import statistics
import sys
from collections import defaultdict
from pathlib import Path

folder = Path(sys.argv[1])
manifest = json.loads((folder / "workloads.json").read_text())
baseline_commit = manifest.get("paired_baseline_commit")
baseline_name = manifest.get("paired_baseline_implementation")
if baseline_commit is not None:
    if not isinstance(baseline_commit, str) or not re.fullmatch(r"[0-9a-f]{40}", baseline_commit):
        raise ValueError("paired_baseline_commit must be a full lowercase Git SHA")
    # Schema 2 recorded the commit but derived the raw name from its prefix.
    if baseline_name is None:
        baseline_name = f"z64-before-{baseline_commit[:7]}"
if baseline_name is not None:
    if baseline_commit is None or not isinstance(baseline_name, str) or not baseline_name.startswith("z64-before-"):
        raise ValueError("paired baseline name requires a recorded commit and z64-before- prefix")
    if baseline_name != f"z64-before-{baseline_commit[:7]}":
        raise ValueError("paired baseline name does not match its recorded commit")
samples = defaultdict(dict)
for path in sorted([*folder.glob("*.csv"), *folder.glob("*.csv.gz")]):
    if path.name in ("summary.csv", "summary.csv.gz", "paired.csv", "paired.csv.gz"):
        continue
    opener = gzip.open if path.suffix == ".gz" else open
    with opener(path, "rt", newline="") as stream:
        for row in csv.DictReader(stream):
            key = (row["build"], row["case"], row["mode"], int(row["binary_bytes"]), row["operation"], row["implementation"])
            index = int(row["sample"])
            if index in samples[key]:
                raise ValueError(f"duplicate sample: {key}, {index}")
            samples[key][index] = float(row["ns_per_call"])
observed_baselines = {key[5] for key in samples if key[5].startswith("z64-before")}
if observed_baselines and observed_baselines != {baseline_name}:
    raise ValueError(f"raw paired baseline names {sorted(observed_baselines)} do not match manifest {baseline_name!r}")
paired_builds = {key[0] for key in samples if key[5] == "z64"} & {
    key[0] for key in samples if key[5] == baseline_name
}
for build in paired_builds:
    current_cases = {key[:5] for key in samples if key[0] == build and key[5] == "z64"}
    previous_cases = {key[:5] for key in samples if key[0] == build and key[5] == baseline_name}
    if current_cases != previous_cases:
        raise ValueError(f"incomplete before/after cases in {build}")
groups = {key: list(values.values()) for key, values in samples.items()}
medians = {key: statistics.median(values) for key, values in groups.items()}
with gzip.open(folder / "summary.csv.gz", "wt", newline="") as stream:
    writer = csv.writer(stream)
    writer.writerow(["build", "case", "mode", "binary_bytes", "operation", "implementation", "median_ns", "min_ns", "max_ns", "samples"])
    for key, values in sorted(groups.items()):
        writer.writerow([*key, medians[key], min(values), max(values), len(values)])

lines = [
    "# Measured comparison",
    "",
    "These samples describe the recorded host and build only. They do not establish dedicated-hardware results or a general speed guarantee.",
    "All baselines use strict alphabet, padding and unused-bit rules; the differential gate must pass before measurement.",
    "Latency is the median of repeated samples. Throughput uses original binary bytes; rejected inputs have latency only.",
    "",
    "## All predefined primary workloads",
    "",
    "The 24 primary cases per operation cover six sizes and all four modes. Each ratio uses the fastest competitor in that same case. A ratio above 1 favors z64.",
    "",
    "| Build | Operation | Cases | At least 2x | Geometric mean ratio | Minimum ratio | Maximum ratio |",
    "|---|---|---:|---:|---:|---:|---:|",
]
for build in ("generic", "native"):
    for operation in ("encode", "decode"):
        ratios = []
        for mode in manifest["modes"]:
            for size in manifest["primary_binary_lengths"]:
                prefix = (build, "valid", mode, size, operation)
                own = medians.get((*prefix, "z64"))
                alternatives = [value for key, value in medians.items() if key[:5] == prefix and not key[5].startswith("z64")]
                if own is not None and alternatives:
                    ratios.append(min(alternatives) / own)
        if ratios:
            mean = math.exp(statistics.mean(map(math.log, ratios)))
            lines.append(f"| {build} | {operation} | {len(ratios)} | {sum(r >= 2 for r in ratios)} | {mean:.3f}x | {min(ratios):.3f}x | {max(ratios):.3f}x |")

# Old and current z64 are measured in one binary. Match sample indices before
# aggregating, so temporary host drift affects each pair as closely as possible.
paired = {}
for key, values in samples.items():
    if key[5] != "z64":
        continue
    old = samples.get((*key[:5], baseline_name))
    if old is None:
        continue
    if values.keys() != old.keys():
        raise ValueError(f"incomplete before/after pairing: {key}")
    paired[key[:5]] = [old[index] / values[index] for index in sorted(values)]
if paired:
    with gzip.open(folder / "paired.csv.gz", "wt", newline="") as stream:
        writer = csv.writer(stream)
        writer.writerow(["build", "case", "mode", "binary_bytes", "operation", "before_median_ns", "after_median_ns", "paired_samples", "median_paired_ratio", "min_paired_ratio", "max_paired_ratio"])
        for key, values in sorted(paired.items()):
            writer.writerow([*key, medians[(*key, baseline_name)], medians[(*key, "z64")], len(values), statistics.median(values), min(values), max(values)])
    lines += ["", "## Paired comparison with the previous z64", "", f"The previous version is Git commit {baseline_commit}. Both versions share one binary, compiler, flags, input bytes and output capacities. Each case uses the median of old/new ratios paired by sample index; ratios above 1 favor the current code. The old version is excluded from external competitor rankings.", "", "| Build | Operation | Primary cases | Current faster | At least 2x | Geometric mean paired ratio | Minimum | Maximum |", "|---|---|---:|---:|---:|---:|---:|---:|"]
    for build in sorted({key[0] for key in paired}):
        for operation in ("encode", "decode"):
            ratios = [statistics.median(values) for key, values in paired.items() if key[0] == build and key[1] == "valid" and key[3] in manifest["primary_binary_lengths"] and key[4] == operation]
            if ratios:
                mean = math.exp(statistics.mean(map(math.log, ratios)))
                lines.append(f"| {build} | {operation} | {len(ratios)} | {sum(r > 1 for r in ratios)} | {sum(r >= 2 for r in ratios)} | {mean:.3f}x | {min(ratios):.3f}x | {max(ratios):.3f}x |")

lines += ["", "## Per-case primary results", "", "| Build | Mode | Binary bytes | Operation | z64 ns | Fastest competitor | Competitor ns | Ratio |", "|---|---|---:|---|---:|---|---:|---:|"]
for key, own in sorted(medians.items()):
    build, case, mode, size, operation, implementation = key
    if build not in ("generic", "native") or case != "valid" or size not in manifest["primary_binary_lengths"] or implementation != "z64":
        continue
    competitors = [(value, other[5]) for other, value in medians.items() if other[:5] == key[:5] and not other[5].startswith("z64")]
    if competitors:
        fastest, name = min(competitors)
        lines.append(f"| {build} | {mode} | {size} | {operation} | {own:.3f} | {name} | {fastest:.3f} | {fastest / own:.3f}x |")

lines += ["", "## Ablations", "", "Rows aggregate all primary mode/size cases for z64, except the short-path row, which uses every predefined short-path size (0–33 bytes) and all four modes. Ratios above 1 favor the second build.", "", "| Comparison | Operation | Cases | Geometric mean speedup | Minimum | Maximum |", "|---|---|---:|---:|---:|---:|"]
for before, after in [("reference", "scalar"), ("scalar", "no-avx512"), ("no-avx512", "generic"), ("scalar", "generic"), ("generic", "native"), ("native", "compiletime-native"), ("no-short-path", "generic")]:
    for operation in ("encode", "decode"):
        ratios = []
        for mode in manifest["modes"]:
            for size in manifest.get("short_path_binary_lengths", [n for n in manifest["all_binary_lengths"] if n <= 33]) if before == "no-short-path" else manifest["primary_binary_lengths"]:
                suffix = ("valid", mode, size, operation, "z64")
                first = medians.get((before, *suffix))
                second = medians.get((after, *suffix))
                if first is not None and second is not None:
                    ratios.append(first / second)
        if ratios:
            mean = math.exp(statistics.mean(map(math.log, ratios)))
            lines.append(f"| {before} → {after} | {operation} | {len(ratios)} | {mean:.3f}x | {min(ratios):.3f}x | {max(ratios):.3f}x |")
lines += ["", "Raw samples include every non-primary boundary length, every baseline and invalid characters at the head, middle and tail. The *.csv.gz files contain losslessly compressed CSV; summary.csv.gz contains all medians, ranges and sample counts; paired.csv.gz contains every available before/after comparison, including errors and regressions.", ""]
(folder / "summary.md").write_text("\n".join(lines))
