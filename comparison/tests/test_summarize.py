"""Exercise result provenance and pairing without running timed benchmarks."""
import csv
import gzip
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
CURRENT = json.loads((ROOT / "workloads.json").read_text())
LEGACY_COMMIT = "d91c6bfbc447061ab4fd2f04feeb65045a6de329"


class SummaryProvenance(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.folder = Path(self.directory.name)

    def summarize(self, manifest, rows, complete=False):
        (self.folder / "workloads.json").write_text(json.dumps(manifest))
        lock = (ROOT / "Cargo.lock").read_text()
        if manifest.get("paired_baseline_commit"):
            lock = lock.replace(CURRENT["paired_baseline_commit"], manifest["paired_baseline_commit"])
        (self.folder / "Cargo.lock").write_text(lock)
        with (self.folder / "generic.csv").open("w", newline="") as stream:
            writer = csv.writer(stream)
            writer.writerow([
                "build", "case", "mode", "binary_bytes", "operation",
                "implementation", "sample", "ns_per_call",
            ])
            writer.writerows(rows)
        return subprocess.run(
            [sys.executable, str(ROOT / "summarize.py"), str(self.folder), *(["--complete"] if complete else [])],
            capture_output=True, text=True, check=False,
        )

    @staticmethod
    def rows(name):
        return [
            ["generic", "valid", "standard", 32, "encode", implementation, index, ns]
            for implementation, times in [("z64", [2, 4]), (name, [4, 12]), ("competitor", [3, 5])]
            for index, ns in enumerate(times)
        ]

    def test_current_and_legacy_manifests_preserve_sample_pairing(self):
        for explicit_name in [False, True]:
            with self.subTest(explicit_name=explicit_name):
                manifest = dict(CURRENT)
                commit = CURRENT["paired_baseline_commit"] if explicit_name else LEGACY_COMMIT
                name = f"z64-before-{commit[:7]}"
                manifest["paired_baseline_commit"] = commit
                manifest.pop("paired_baseline_implementation")
                if explicit_name:
                    manifest["paired_baseline_implementation"] = name
                else:
                    manifest["schema"] = 2
                result = self.summarize(manifest, self.rows(name))
                self.assertEqual(result.returncode, 0, result.stderr)
                with gzip.open(self.folder / "paired.csv.gz", "rt") as stream:
                    row, = csv.DictReader(stream)
                # Median of per-sample ratios (2, 3), not ratio of medians (8/3).
                self.assertEqual(float(row["median_paired_ratio"]), 2.5)
                self.assertEqual(row["paired_samples"], "2")
                self.assertIn(commit, (self.folder / "summary.md").read_text())

    def test_original_unpaired_manifest_remains_supported(self):
        manifest = dict(CURRENT)
        manifest["schema"] = 1
        manifest.pop("paired_baseline_commit")
        manifest.pop("paired_baseline_implementation")
        rows = [row for row in self.rows("unused") if row[5] != "unused"]
        result = self.summarize(manifest, rows)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertFalse((self.folder / "paired.csv.gz").exists())

    def test_wrong_identity_and_incomplete_pairs_fail(self):
        name = CURRENT["paired_baseline_implementation"]
        original = self.rows(name)
        scenarios = {
            "wrong raw baseline": self.rows(f"z64-before-{LEGACY_COMMIT[:7]}"),
            "missing sample": [row for row in original if not (row[5] == name and row[6] == 1)],
            "missing case": original + [["generic", "valid", "standard", 33, "encode", "z64", 0, 2]],
        }
        for problem, rows in scenarios.items():
            with self.subTest(problem=problem):
                result = self.summarize(CURRENT, rows)
                self.assertNotEqual(result.returncode, 0)
                self.assertIn("ValueError", result.stderr)
        manifest = dict(CURRENT)
        manifest["paired_baseline_commit"] = LEGACY_COMMIT
        result = self.summarize(manifest, original)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("does not match its recorded commit", result.stderr)

    def test_single_implementation_controls_do_not_require_pairs(self):
        name = CURRENT["paired_baseline_implementation"]
        for implementation in ["z64", name]:
            with self.subTest(implementation=implementation):
                rows = [row for row in self.rows(name) if row[5] == implementation]
                result = self.summarize(CURRENT, rows)
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertFalse((self.folder / "paired.csv.gz").exists())

    @staticmethod
    def full_fixture(schema=3):
        # Small independent matrix: four modes, zero/nonzero lengths, both
        # operations, all three nonempty invalid cases, and every real build.
        manifest = dict(CURRENT)
        manifest.update(schema=schema, all_binary_lengths=[0, 4],
                        primary_binary_lengths=[4], short_path_binary_lengths=[0, 4],
                        default_samples=2)
        previous = manifest["paired_baseline_implementation"]
        if schema == 2:
            manifest["paired_baseline_commit"] = LEGACY_COMMIT
            manifest.pop("paired_baseline_implementation")
            previous = "z64-before-d91c6bf"
        elif schema == 1:
            manifest.pop("paired_baseline_commit")
            manifest.pop("paired_baseline_implementation")
            previous = None
        competitors = ["base64-scalar-0.23.1", "base64-vector-0.23.1",
                       "base64-simd-0.8.0", "base64-turbo-0.6.0", "encodify-1.0.2"]
        builds = ["generic", "native", "scalar", "reference", "compiletime-native", "no-short-path"]
        if schema >= 2:
            builds.append("no-avx512")
        rows = []
        for build in builds:
            implementations = ["z64"]
            if build in ("generic", "native"):
                implementations += competitors + ([previous] if previous else [])
            for mode in ["standard", "standard-no-pad", "url-safe", "url-safe-no-pad"]:
                for length in [0, 4]:
                    cases = [("valid", "encode"), ("valid", "decode")]
                    if length:
                        cases += [(kind, "decode") for kind in ["invalid-head", "invalid-middle", "invalid-tail"]]
                    for kind, operation in cases:
                        for implementation in implementations:
                            for index in [0, 1]:
                                # z64 deliberately loses: complete validation
                                # must accept and retain these records too.
                                ns = 8 + index if implementation == "z64" else 4 + index
                                rows.append([build, kind, mode, length, operation, implementation, index, ns])
        return manifest, rows

    def test_complete_current_and_historical_matrices(self):
        for schema in [1, 2, 3]:
            with self.subTest(schema=schema):
                manifest, rows = self.full_fixture(schema)
                result = self.summarize(manifest, rows, complete=True)
                self.assertEqual(result.returncode, 0, result.stderr)
                report = (self.folder / "summary.md").read_text()
                self.assertIn("Complete matrix validation passed", report)
                self.assertIn(f"{len(rows)} raw samples", report)
                with gzip.open(self.folder / "summary.csv.gz", "rt") as stream:
                    summaries = list(csv.DictReader(stream))
                self.assertEqual(sum(int(row["samples"]) for row in summaries), len(rows))
                self.assertEqual({row["samples"] for row in summaries}, {"2"})
                if schema >= 2:
                    with gzip.open(self.folder / "paired.csv.gz", "rt") as stream:
                        self.assertTrue(all(float(row["median_paired_ratio"]) < 1 for row in csv.DictReader(stream)))

    def test_complete_symmetric_omissions_and_wrong_grid_fail_before_output(self):
        manifest, original = self.full_fixture()
        paired_names = {"z64", manifest["paired_baseline_implementation"]}
        chosen = lambda row: row[0] == "generic" and row[1] == "valid" and row[2] == "standard" and row[3] == 4 and row[4] == "decode" and row[5] in paired_names
        shifted_ids = [row[:6] + [row[6] + 1, row[7]] if chosen(row) else row for row in original]
        scenarios = {
            "symmetric missing case": [row for row in original if not chosen(row)],
            "symmetric missing sample": [row for row in original if not (chosen(row) and row[6] == 1)],
            "symmetric wrong sample IDs": shifted_ids,
            "missing competitor": [row for row in original if row[5] != "base64-simd-0.8.0"],
            "missing build": [row for row in original if row[0] != "compiletime-native"],
            "missing mode": [row for row in original if row[2] != "url-safe-no-pad"],
            "missing length": [row for row in original if row[3] != 4],
            "missing operation": [row for row in original if row[4] != "encode"],
            "missing error case": [row for row in original if row[1] != "invalid-tail"],
            "unexpected case": original + [["generic", "invalid-head", "standard", 0, "decode", "competitor", 0, 4]],
        }
        for name in ("summary.csv.gz", "paired.csv.gz", "summary.md"):
            (self.folder / name).write_bytes(b"existing output remains unchanged")
        for problem, rows in scenarios.items():
            with self.subTest(problem=problem):
                result = self.summarize(manifest, rows, complete=True)
                self.assertNotEqual(result.returncode, 0)
                self.assertIn("full-run", result.stderr)
                for name in ("summary.csv.gz", "paired.csv.gz", "summary.md"):
                    self.assertEqual((self.folder / name).read_bytes(), b"existing output remains unchanged")

    def test_partial_probe_reports_observed_counts_and_clears_stale_pairs(self):
        name = CURRENT["paired_baseline_implementation"]
        result = self.summarize(CURRENT, self.rows(name))
        self.assertEqual(result.returncode, 0, result.stderr)
        report = (self.folder / "summary.md").read_text()
        self.assertIn("Observed scope only (partial or unverified run)", report)
        self.assertIn("| generic | 3 | 1 | 6 | 2 |", report)
        self.assertIn("## Observed primary workloads", report)
        self.assertNotIn("## All predefined primary workloads", report)
        self.assertNotIn("Raw samples include every", report)

        manifest = dict(CURRENT)
        manifest["schema"] = 1
        manifest.pop("paired_baseline_commit")
        manifest.pop("paired_baseline_implementation")
        rows = [row for row in self.rows(name) if row[5] != name]
        result = self.summarize(manifest, rows)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertFalse((self.folder / "paired.csv.gz").exists())


if __name__ == "__main__":
    unittest.main()
