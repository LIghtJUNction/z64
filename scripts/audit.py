#!/usr/bin/env python3
"""Enforce the published crate's dependency and package boundaries."""

import json
from pathlib import Path
import re
import subprocess
import tomllib


ROOT = Path(__file__).resolve().parents[1]


def run(*args):
    return subprocess.check_output(args, cwd=ROOT, text=True)


def require(condition, message):
    if not condition:
        raise SystemExit(message)


manifest = tomllib.loads((ROOT / "Cargo.toml").read_text())
require(manifest["package"]["name"] == "z64", "unexpected package name")
require(manifest["package"]["rust-version"] in ("1.70", "1.70.0"), "MSRV must match CI")
require(not (ROOT / "build.rs").exists(), "build.rs is forbidden")
require(manifest["package"].get("build", False) is False, "custom build scripts are forbidden")

for scope in [manifest, *manifest.get("target", {}).values()]:
    for kind in ("dependencies", "build-dependencies", "dev-dependencies"):
        require(not scope.get(kind), f"nonempty {kind} table is forbidden")

metadata = json.loads(run("cargo", "metadata", "--locked", "--format-version=1", "--all-features"))
require(len(metadata["packages"]) == 1, "published workspace has other packages")
require(not metadata["packages"][0]["dependencies"], "crate has dependencies")
require(len(metadata["workspace_members"]) == 1, "comparison must be an independent workspace")
require(
    all("custom-build" not in target["kind"] for target in metadata["packages"][0]["targets"]),
    "Cargo found a custom build script",
)

source = (ROOT / "src/lib.rs").read_text()
require(re.search(r"^#!\[no_std\]$", source, re.MULTILINE), "unconditional #![no_std] is required")
for path in (ROOT / "src").rglob("*.rs"):
    require(not re.search(r"\bextern\s+crate\s+alloc\b|\balloc::", path.read_text()), f"alloc in {path}")

run("git", "ls-files", "--error-unmatch", "Cargo.lock")
packaged = run("cargo", "package", "--list", "--locked").splitlines()
for name in packaged:
    require(not name.startswith(("comparison/", ".github/", "scripts/")), f"excluded file is packaged: {name}")
    require(Path(name).name != "build.rs", "build.rs is packaged")
require("Cargo.lock" in packaged, "package is missing Cargo.lock")
require("src/lib.rs" in packaged, "package is missing its library")
print(f"z64: zero dependencies; no_std; {len(packaged)} package files; comparison excluded")
