#!/usr/bin/env python3
"""Summarize every retained workload without filtering losers or error cases."""
import collections
import csv
import gzip
import io
import math
from pathlib import Path
import statistics

ROOT = Path(__file__).resolve().parent


def write_csv(name, rows):
    out = io.StringIO(newline="")
    writer = csv.DictWriter(out, fieldnames=list(rows[0]))
    writer.writeheader()
    writer.writerows(rows)
    with (ROOT / f"{name}.gz").open("wb") as destination:
        with gzip.GzipFile(filename="", mode="wb", fileobj=destination, mtime=0) as packed:
            packed.write(out.getvalue().encode("utf-8"))


def geometric_mean(values):
    return math.exp(statistics.mean(math.log(value) for value in values))


details = []
for build in ("generic", "native"):
    groups = collections.defaultdict(lambda: collections.defaultdict(dict))
    with gzip.open(ROOT / f"{build}.csv.gz", "rt", encoding="utf-8", newline="") as source:
        raw = list(csv.DictReader(source))
    assert len(raw) == 14520, (build, len(raw))
    for row in raw:
        key = (
            row["operation"],
            row["case"],
            int(row["binary_bytes"]),
            int(row["input_offset"]),
            int(row["output_offset"]),
            row["url"],
        )
        sample = int(row["sample"])
        assert sample not in groups[key][row["variant"]]
        groups[key][row["variant"]][sample] = float(row["ns_per_call"])
    for key, variants in sorted(groups.items()):
        assert set(variants) == {"baseline", "encode3", "decode3", "combined"}
        assert all(set(values) == set(range(11)) for values in variants.values())
        baseline = statistics.median(variants["baseline"].values())
        for variant, samples in sorted(variants.items()):
            median = statistics.median(samples.values())
            details.append(
                dict(
                    build=build,
                    operation=key[0],
                    case=key[1],
                    binary_bytes=key[2],
                    input_offset=key[3],
                    output_offset=key[4],
                    url=key[5],
                    variant=variant,
                    median_ns=median,
                    baseline_ns=baseline,
                    speedup=baseline / median,
                    paired_median_speedup=statistics.median(
                        variants["baseline"][sample] / samples[sample]
                        for sample in range(11)
                    ),
                    raw_gb_per_second=key[2] / median if key[1] == "valid" else "",
                )
            )
write_csv("summary.csv", details)

grouped = collections.defaultdict(list)
for row in details:
    grouped[
        (row["build"], row["operation"], row["case"], row["binary_bytes"], row["variant"])
    ].append(row)
aggregates = []
for key, rows in sorted(grouped.items()):
    assert len(rows) == 6  # Both alphabets, all three alignment pairs.
    aggregates.append(
        dict(
            build=key[0],
            operation=key[1],
            case=key[2],
            binary_bytes=key[3],
            variant=key[4],
            workloads=len(rows),
            geometric_mean_speedup=geometric_mean([row["speedup"] for row in rows]),
            minimum_speedup=min(row["speedup"] for row in rows),
            maximum_speedup=max(row["speedup"] for row in rows),
            paired_geometric_mean_speedup=geometric_mean(
                [row["paired_median_speedup"] for row in rows]
            ),
            median_baseline_ns=statistics.median(row["baseline_ns"] for row in rows),
            median_candidate_ns=statistics.median(row["median_ns"] for row in rows),
        )
    )
write_csv("aggregate.csv", aggregates)
print(f"Wrote {len(details)} complete workload summaries and {len(aggregates)} aggregates.")
