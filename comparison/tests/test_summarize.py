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

    def summarize(self, manifest, rows):
        (self.folder / "workloads.json").write_text(json.dumps(manifest))
        with (self.folder / "generic.csv").open("w", newline="") as stream:
            writer = csv.writer(stream)
            writer.writerow([
                "build", "case", "mode", "binary_bytes", "operation",
                "implementation", "sample", "ns_per_call",
            ])
            writer.writerows(rows)
        return subprocess.run(
            [sys.executable, str(ROOT / "summarize.py"), str(self.folder)],
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


if __name__ == "__main__":
    unittest.main()
