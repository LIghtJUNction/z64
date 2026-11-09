#!/usr/bin/env bash
set -euo pipefail

# std belongs only to this test executable. The published crate stays no_std.
probe_dir=$(mktemp -d)
trap 'rm -rf "$probe_dir"' EXIT
cat > "$probe_dir/probe.rs" <<'RUST'
fn main() {
    #[cfg(target_arch = "x86_64")]
    if std::is_x86_feature_detected!("avx2") {
        println!("avx2");
        return;
    }
    #[cfg(target_arch = "aarch64")]
    if std::arch::is_aarch64_feature_detected!("neon") {
        println!("neon");
        return;
    }
    println!("none");
}
RUST
rustc --edition=2021 "$probe_dir/probe.rs" -o "$probe_dir/probe"
feature=$("$probe_dir/probe")
if [ "$feature" = none ]; then
    echo 'SIMD test skipped: CPU/OS support was not detected.'
    exit 0
fi
echo "Testing compile-time $feature dispatch on supported hardware."
RUSTFLAGS="-C target-feature=+$feature" cargo test --locked --release --features no-runtime-detect
