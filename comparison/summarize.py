#!/usr/bin/env python3
"""Aggregate raw samples without discarding slower cases or competitors."""
import argparse
import csv
import gzip
import json
import math
import re
import statistics
import tomllib
from collections import defaultdict
from pathlib import Path


def validate_complete(samples, manifest, folder, baseline_name, baseline_commit):
    """Check the declared full run, including missing data on both paired sides."""
    schema = manifest.get("schema")
    if schema not in (1, 2, 3):
        raise ValueError(f"unsupported full-run schema: {schema!r}")
    if schema >= 2 and baseline_name is None:
        raise ValueError("full paired run requires a recorded previous-version baseline")
    builds = {"generic", "native", "scalar", "reference", "compiletime-native", "no-short-path"}
    # Schema 1 predates the AVX512 ablation and same-binary previous-version run.
    if schema >= 2:
        builds.add("no-avx512")
    observed_builds = {key[0] for key in samples}
    if observed_builds != builds:
        raise ValueError(
            f"full-run build mismatch: missing={sorted(builds - observed_builds)}, "
            f"unexpected={sorted(observed_builds - builds)}"
        )

    packages = tomllib.loads((folder / "Cargo.lock").read_text())["package"]
    versions = {}
    for name in ("base64", "base64-simd", "base64-turbo", "encodify"):
        matches = {package["version"] for package in packages if package["name"] == name}
        if len(matches) != 1:
            raise ValueError(f"full-run lockfile needs one version of {name}")
        versions[name] = matches.pop()
    external = {
        f"base64-scalar-{versions['base64']}",
        f"base64-vector-{versions['base64']}",
        *(f"{name}-{versions[name]}" for name in ("base64-simd", "base64-turbo", "encodify")),
    }
    ranked = {"z64", *external}
    if baseline_name is not None:
        recorded_sources = {
            package.get("source", "") for package in packages
            if package["name"] == "z64" and package.get("source", "").startswith("git+")
        }
        if len(recorded_sources) != 1 or not next(iter(recorded_sources)).endswith(f"#{baseline_commit}"):
            raise ValueError("full-run lockfile previous-version commit does not match manifest")
        ranked.add(baseline_name)
    cases = {
        (case, mode, size, operation)
        for mode in manifest["modes"]
        for size in manifest["all_binary_lengths"]
        for operation in manifest["operations"]
        for case in (manifest["decode_cases"] if operation == "decode" and size != 0 else ["valid"])
    }
    expected = {
        (build, *case, implementation)
        for build in builds
        for case in cases
        for implementation in (ranked if build in ("generic", "native") else {"z64"})
    }
    observed = set(samples)
    if observed != expected:
        missing, unexpected = expected - observed, observed - expected
        raise ValueError(
            f"full-run case matrix mismatch: {len(missing)} missing, {len(unexpected)} unexpected; "
            f"first missing={min(missing, default=None)!r}, "
            f"first unexpected={min(unexpected, default=None)!r}"
        )
    count = manifest["default_samples"]
    if not isinstance(count, int) or isinstance(count, bool) or count < 1:
        raise ValueError("full-run default_samples must be a positive integer")
    expected_ids = set(range(count))
    for key, values in samples.items():
        if values.keys() != expected_ids:
            raise ValueError(f"full-run sample IDs for {key}: expected {sorted(expected_ids)}, got {sorted(values)}")


parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("folder", type=Path)
parser.add_argument("--complete", action="store_true", help="require the exact full matrix and default sample IDs before writing outputs")
options = parser.parse_args()
folder = options.folder
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

# Finish every validation before replacing an existing summary artifact.
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
if options.complete:
    validate_complete(samples, manifest, folder, baseline_name, baseline_commit)

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
    "## Recorded scope",
    "",
    (
        f"Complete matrix validation passed against the recorded manifest and Cargo.lock: "
        f"{len(samples)} implementation/case groups and {sum(map(len, groups.values()))} raw samples. "
        f"Every group contains exactly sample IDs 0 through {manifest['default_samples'] - 1}."
        if options.complete else
        "Observed scope only (partial or unverified run). Full-matrix completeness was not requested; "
        "the tables describe available records and do not claim that absent cases or implementations were measured."
    ),
    "",
    "The case count below is the union of observed case identities within each build; it does not by itself imply identical coverage for every implementation.",
    "",
    "| Build | Implementations | Observed cases | Raw samples | Samples per implementation/case |",
    "|---|---:|---:|---:|---|",
]
for build in sorted({key[0] for key in samples}):
    observed = {key: values for key, values in samples.items() if key[0] == build}
    counts = ", ".join(map(str, sorted({len(values) for values in observed.values()})))
    lines.append(
        f"| {build} | {len({key[5] for key in observed})} | {len({key[1:5] for key in observed})} | "
        f"{sum(map(len, observed.values()))} | {counts} |"
    )
primary_count = len(manifest["modes"]) * len(manifest["primary_binary_lengths"])
lines += [
    "",
    "## All predefined primary workloads" if options.complete else "## Observed primary workloads",
    "",
    f"The manifest defines {primary_count} primary cases per operation. Each reported ratio uses the fastest observed "
    "external competitor in that same case; the table states how many cases were available. A ratio above 1 favors z64.",
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

if paired:
    with gzip.open(folder / "paired.csv.gz", "wt", newline="") as stream:
        writer = csv.writer(stream)
        writer.writerow(["build", "case", "mode", "binary_bytes", "operation", "before_median_ns", "after_median_ns", "paired_samples", "median_paired_ratio", "min_paired_ratio", "max_paired_ratio"])
        for key, values in sorted(paired.items()):
            writer.writerow([*key, medians[(*key, baseline_name)], medians[(*key, "z64")], len(values), statistics.median(values), min(values), max(values)])
    lines += ["", "## Paired comparison with the previous z64", "", f"The previous version is Git commit {baseline_commit}. Both versions share one binary, compiler, flags, input bytes and output capacities. Each case uses the median of old/new ratios paired by sample index; ratios above 1 favor the current code. The old version is excluded from external competitor rankings.", "", "| Build | Operation | Primary cases | Current faster | At least 2x | Geometric mean paired ratio | Minimum | Maximum |", "|---|---|---:|---:|---:|---:|---:|---:|"]
    for build in sorted({key[0] for key in paired}):
        for operation in ("encode", "decode"):
            ratios = [statistics.median(values) for key, values in paired.items() if key[0] == build and key[1] == "valid" and key[2] in manifest["modes"] and key[3] in manifest["primary_binary_lengths"] and key[4] == operation]
            if ratios:
                mean = math.exp(statistics.mean(map(math.log, ratios)))
                lines.append(f"| {build} | {operation} | {len(ratios)} | {sum(r > 1 for r in ratios)} | {sum(r >= 2 for r in ratios)} | {mean:.3f}x | {min(ratios):.3f}x | {max(ratios):.3f}x |")
else:
    for name in ("paired.csv", "paired.csv.gz"):
        (folder / name).unlink(missing_ok=True)

lines += ["", "## Per-case primary results", "", "| Build | Mode | Binary bytes | Operation | z64 ns | Fastest observed competitor | Competitor ns | Ratio |", "|---|---|---:|---|---:|---|---:|---:|"]
for key, own in sorted(medians.items()):
    build, case, mode, size, operation, implementation = key
    if build not in ("generic", "native") or case != "valid" or mode not in manifest["modes"] or size not in manifest["primary_binary_lengths"] or implementation != "z64":
        continue
    competitors = [(value, other[5]) for other, value in medians.items() if other[:5] == key[:5] and not other[5].startswith("z64")]
    if competitors:
        fastest, name = min(competitors)
        lines.append(f"| {build} | {mode} | {size} | {operation} | {own:.3f} | {name} | {fastest:.3f} | {fastest / own:.3f}x |")

lines += ["", "## Ablations", "", "Rows use z64 cases observed in both builds, restricted to the manifest's primary modes and sizes. The short-path row instead uses the manifest's short-path sizes. Each row states its observed case count; ratios above 1 favor the second build.", "", "| Comparison | Operation | Cases | Geometric mean speedup | Minimum | Maximum |", "|---|---|---:|---:|---:|---:|"]
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
lines += ["", "Raw CSV files retain the recorded samples, including slower results and errors when measured. summary.csv.gz contains every observed median, range and sample count. When paired data exists, paired.csv.gz contains every observed before/after comparison, including errors and regressions present in the input. A complete-grid claim requires successful --complete validation.", ""]
(folder / "summary.md").write_text("\n".join(lines))
print(f"{'Complete' if options.complete else 'Observed-scope'} summary: {len(samples)} groups, {sum(map(len, groups.values()))} raw samples")
