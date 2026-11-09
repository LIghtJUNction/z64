#!/usr/bin/env bash
set -euo pipefail

# std belongs only to this test executable. The published crate stays no_std.
probe_dir=$(mktemp -d)
trap 'rm -rf "$probe_dir"' EXIT
cat > "$probe_dir/probe.rs" <<'RUST'
fn main() {
    #[cfg(target_arch = "x86_64")]
    {
        if std::is_x86_feature_detected!("avx2") { println!("avx2"); }
        if std::is_x86_feature_detected!("avx512f")
            && std::is_x86_feature_detected!("avx512bw")
            && std::is_x86_feature_detected!("avx512vbmi") { println!("avx512"); }
    }
    #[cfg(target_arch = "aarch64")]
    if std::arch::is_aarch64_feature_detected!("neon") { println!("neon"); }
}
RUST
rustc --edition=2021 "$probe_dir/probe.rs" -o "$probe_dir/probe"
features=$("$probe_dir/probe")
if [ -z "$features" ]; then
    echo 'SIMD test skipped: CPU/OS support was not detected.'
    exit 0
fi
while read -r feature; do
    controls=no-runtime-detect
    case "$feature" in
        avx512) flags='+avx512f,+avx512bw,+avx512vbmi' ;;
        avx2) flags='+avx2'; controls+=,no-avx512 ;;
        neon) flags='+neon' ;;
        *) exit 1 ;;
    esac
    echo "Testing compile-time $feature dispatch on supported hardware."
    RUSTFLAGS="-C target-feature=$flags" cargo test --locked --release --features "$controls"
done <<< "$features"
