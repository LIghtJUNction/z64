#!/usr/bin/env python3
"""Validate release identity and fail closed on registry errors."""

import json
import os
from pathlib import Path
import re
import subprocess
import sys
import time
import tomllib
from urllib.error import HTTPError
from urllib.request import Request, urlopen


ROOT = Path(__file__).resolve().parents[1]
VERSION = re.compile(r"(?:0|[1-9][0-9]*)\.(?:0|[1-9][0-9]*)\.(?:0|[1-9][0-9]*)\Z")


def git(*args):
    return subprocess.check_output(["git", *args], cwd=ROOT, text=True).strip()


def version(value):
    if not VERSION.fullmatch(value):
        raise SystemExit("version must have the form X.Y.Z, without leading zeroes")
    return value


def resolve(tag):
    if not tag.startswith("v"):
        raise SystemExit("tag must have the form vX.Y.Z")
    release_version = version(tag[1:])
    git("show-ref", "--verify", f"refs/tags/{tag}")
    commit = git("rev-parse", "--verify", f"refs/tags/{tag}^{{commit}}")
    if not re.fullmatch(r"[0-9a-f]{40}", commit):
        raise SystemExit("tag did not resolve to a full commit SHA")
    manifest = tomllib.loads(git("show", f"{commit}:Cargo.toml"))
    package = manifest["package"]
    if package["name"] != "z64" or package["version"] != release_version:
        raise SystemExit("tag does not match z64's Cargo.toml version")
    return {"commit": commit, "tag": tag, "version": release_version}


def registry(release_version):
    url = f"https://crates.io/api/v1/crates/z64/{version(release_version)}"
    request = Request(url, headers={"User-Agent": "z64-release/1.0 (github.com/LIghtJUNction/z64)"})
    try:
        with urlopen(request, timeout=30) as response:
            data = json.load(response)
    except HTTPError as error:
        if error.code == 404:
            return None
        raise SystemExit(f"crates.io returned HTTP {error.code}; publication stopped") from error
    published = data.get("version", {})
    if published.get("crate") != "z64" or published.get("num") != release_version:
        raise SystemExit("crates.io returned an unexpected version identity")
    return published


def main():
    command, *args = sys.argv[1:]
    if command == "resolve" and len(args) == 1:
        values = resolve(args[0])
        print(json.dumps(values))
        if output := os.environ.get("GITHUB_OUTPUT"):
            with open(output, "a", encoding="utf-8") as file:
                for key, value in values.items():
                    file.write(f"{key}={value}\n")
    elif command == "check" and len(args) == 2:
        values = resolve(args[0])
        if values["commit"] != args[1] or git("rev-parse", "HEAD") != args[1]:
            raise SystemExit("checkout or tag no longer matches the verified commit")
        if git("status", "--porcelain", "--untracked-files=no"):
            raise SystemExit("release checkout has tracked modifications")
        print(f"Release source: {values['commit']}")
    elif command == "unpublished" and len(args) == 1:
        if registry(args[0]) is not None:
            raise SystemExit("this crates.io version already exists; refusing to overwrite or republish")
        print(f"z64 {args[0]} is not published")
    elif command == "confirm" and len(args) == 1:
        for attempt in range(24):
            if registry(args[0]) is not None:
                print(f"Confirmed: https://crates.io/crates/z64/{args[0]}")
                return
            if attempt != 23:
                time.sleep(5)
        raise SystemExit("crates.io has not confirmed the version; GitHub Release was not created")
    else:
        raise SystemExit("usage: release.py resolve TAG | check TAG SHA | unpublished VERSION | confirm VERSION")


if __name__ == "__main__":
    main()
