#!/usr/bin/env python3
"""Aggregate raw samples without discarding slower cases or competitors."""
import csv
import json
import math
import statistics
import sys
from collections import defaultdict
from pathlib import Path

folder = Path(sys.argv[1])
manifest = json.loads((folder / "workloads.json").read_text())
groups = defaultdict(list)
for path in sorted(folder.glob("*.csv")):
    if path.name == "summary.csv":
        continue
    with path.open() as stream:
        for row in csv.DictReader(stream):
            key = (row["build"], row["case"], row["mode"], int(row["binary_bytes"]), row["operation"], row["implementation"])
            groups[key].append(float(row["ns_per_call"]))
medians = {key: statistics.median(values) for key, values in groups.items()}
with (folder / "summary.csv").open("w") as stream:
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
                alternatives = [value for key, value in medians.items() if key[:5] == prefix and key[5] != "z64"]
                if own is not None and alternatives:
                    ratios.append(min(alternatives) / own)
        if ratios:
            mean = math.exp(statistics.mean(map(math.log, ratios)))
            lines.append(f"| {build} | {operation} | {len(ratios)} | {sum(r >= 2 for r in ratios)} | {mean:.3f}x | {min(ratios):.3f}x | {max(ratios):.3f}x |")

lines += ["", "## Per-case primary results", "", "| Build | Mode | Binary bytes | Operation | z64 ns | Fastest competitor | Competitor ns | Ratio |", "|---|---|---:|---|---:|---|---:|---:|"]
for key, own in sorted(medians.items()):
    build, case, mode, size, operation, implementation = key
    if build not in ("generic", "native") or case != "valid" or size not in manifest["primary_binary_lengths"] or implementation != "z64":
        continue
    competitors = [(value, other[5]) for other, value in medians.items() if other[:5] == key[:5] and other[5] != "z64"]
    if competitors:
        fastest, name = min(competitors)
        lines.append(f"| {build} | {mode} | {size} | {operation} | {own:.3f} | {name} | {fastest:.3f} | {fastest / own:.3f}x |")

lines += ["", "## Ablations", "", "Rows aggregate all primary mode/size cases for z64, except the short-path row, which uses every predefined short-path size (0–33 bytes) and all four modes. Ratios above 1 favor the second build.", "", "| Comparison | Operation | Cases | Geometric mean speedup | Minimum | Maximum |", "|---|---|---:|---:|---:|---:|"]
for before, after in [("reference", "scalar"), ("scalar", "generic"), ("generic", "native"), ("native", "compiletime-native"), ("no-short-path", "generic")]:
    for operation in ("encode", "decode"):
        ratios = []
        for mode in manifest["modes"]:
            for size in manifest["short_path_binary_lengths"] if before == "no-short-path" else manifest["primary_binary_lengths"]:
                suffix = ("valid", mode, size, operation, "z64")
                first = medians.get((before, *suffix))
                second = medians.get((after, *suffix))
                if first is not None and second is not None:
                    ratios.append(first / second)
        if ratios:
            mean = math.exp(statistics.mean(map(math.log, ratios)))
            lines.append(f"| {before} → {after} | {operation} | {len(ratios)} | {mean:.3f}x | {min(ratios):.3f}x | {max(ratios):.3f}x |")
lines += ["", "Raw samples include every non-primary boundary length, every baseline and invalid characters at the head, middle and tail. See summary.csv for all medians, ranges and sample counts.", ""]
(folder / "summary.md").write_text("\n".join(lines))
