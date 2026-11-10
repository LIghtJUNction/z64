#!/bin/sh
set -eu
cd "$(dirname "$0")"
Z64_STUDY_RUSTC=${Z64_STUDY_RUSTC:-rustc}
Z64_STUDY_CPU=${Z64_STUDY_CPU:-2}

# All four kernels run in one executable; source snapshots are immutable inputs.
"$Z64_STUDY_RUSTC" --edition=2021 -D warnings --test tests.rs -o tests-debug
./tests-debug --test-threads=1
"$Z64_STUDY_RUSTC" --edition=2021 -D warnings -C opt-level=3 -C target-cpu=x86-64 \
    -C codegen-units=1 -C lto=thin probe.rs -o probe-generic
"$Z64_STUDY_RUSTC" --edition=2021 -D warnings -C opt-level=3 -C target-cpu=native \
    -C codegen-units=1 -C lto=thin probe.rs -o probe-native
./probe-generic --verify-only
taskset -c "$Z64_STUDY_CPU" ./probe-generic > generic-reproduction.csv
taskset -c "$Z64_STUDY_CPU" ./probe-native > native-reproduction.csv
gzip -n -9 generic-reproduction.csv native-reproduction.csv

# analyze.py reads the retained original .csv.gz files directly. Rename fresh outputs only
# in a separate copy if recomputing that summary for a reproduction.
python3 analyze.py
