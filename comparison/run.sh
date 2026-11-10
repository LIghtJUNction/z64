#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
out="${1:-results/$(date -u +%Y%m%dT%H%M%SZ)}"
mkdir -p "$(dirname "$out")"
mkdir "$out"
out="$(cd "$out" && pwd)"
{
  date -u +%Y-%m-%dT%H:%M:%SZ
  rustc -Vv
  cargo -V
  uname -a
  git -C .. rev-parse HEAD
  git -C .. status --short
  cat /proc/cpuinfo 2>/dev/null || true
  cat /proc/self/status 2>/dev/null || true
  cat /sys/fs/cgroup/cpu.max 2>/dev/null || true
  cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || true
  printf 'Z64_BENCH_CPU=%s\n' "${Z64_BENCH_CPU:-unbound}"
  printf 'Hardware exclusivity is not asserted by this script.\n'
} > "$out/environment.txt"
if [[ -r /sys/fs/cgroup/cpu.stat ]]; then
  cat /sys/fs/cgroup/cpu.stat > "$out/cpu-stat-before.txt"
else
  printf 'unavailable: /sys/fs/cgroup/cpu.stat\n' > "$out/cpu-stat-before.txt"
fi
cp Cargo.lock workloads.json baseline-versions.json "$out/"
cargo tree --locked > "$out/dependencies.txt"
python3 tests/test_summarize.py > "$out/summary-check.log" 2>&1
cargo test --locked > "$out/differential.log" 2>&1
pin=()
if [[ -n "${Z64_BENCH_CPU:-}" ]]; then pin=(taskset -c "$Z64_BENCH_CPU"); fi
for build in generic native no-avx512 scalar reference compiletime-native no-short-path; do
  flags=""
  feature=()
  extra=()
  case "$build" in
    native) flags="-C target-cpu=native" ;;
    no-avx512) feature=(--features no-avx512); extra=(--only-z64) ;;
    scalar) feature=(--features force-scalar); extra=(--only-z64) ;;
    reference) feature=(--features reference); extra=(--only-z64) ;;
    compiletime-native) flags="-C target-cpu=native"; feature=(--features no-runtime-detect); extra=(--only-z64) ;;
    no-short-path) feature=(--features no-short-path); extra=(--only-z64) ;;
  esac
  printf 'RUSTFLAGS=%q cargo run --release --locked' "$flags" >> "$out/commands.txt"
  printf ' %q' "${feature[@]}" -- --build "$build" "${extra[@]}" >> "$out/commands.txt"
  printf '\n' >> "$out/commands.txt"
  RUSTFLAGS="$flags" cargo build --release --locked "${feature[@]}"
  "${pin[@]}" ./target/release/z64-comparison --build "$build" "${extra[@]}" > "$out/$build.csv"
done
if [[ -r /sys/fs/cgroup/cpu.stat ]]; then
  cat /sys/fs/cgroup/cpu.stat > "$out/cpu-stat-after.txt"
else
  printf 'unavailable: /sys/fs/cgroup/cpu.stat\n' > "$out/cpu-stat-after.txt"
fi
for csv in "$out"/*.csv; do gzip -n "$csv"; done
python3 summarize.py "$out"
printf 'Benchmark artifacts: %s\n' "$out"
