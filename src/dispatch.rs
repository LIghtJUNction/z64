//! Feature detection without `std`. Only x86-64 has runtime detection here.
//! Other architectures use features guaranteed by the compile target.

#[cfg(all(
    target_arch = "x86_64",
    not(target_env = "sgx"),
    not(feature = "no-runtime-detect")
))]
use core::sync::atomic::{AtomicU8, Ordering};

#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
#[inline]
fn avx2() -> bool {
    if cfg!(target_feature = "avx2") {
        return true;
    }
    #[cfg(all(
        target_arch = "x86_64",
        not(target_env = "sgx"),
        not(feature = "no-runtime-detect")
    ))]
    {
        static AVAILABLE: AtomicU8 = AtomicU8::new(0);
        match AVAILABLE.load(Ordering::Relaxed) {
            1 => return false,
            2 => return true,
            _ => {}
        }
        let yes = detect_avx2();
        // The cached value describes immutable CPU/OS capabilities, not shared
        // memory. Concurrent first calls may detect independently; no ordering
        // or synchronization of other data is required.
        AVAILABLE.store(if yes { 2 } else { 1 }, Ordering::Relaxed);
        yes
    }
    #[cfg(not(all(
        target_arch = "x86_64",
        not(target_env = "sgx"),
        not(feature = "no-runtime-detect")
    )))]
    false
}

#[cfg(all(
    target_arch = "x86_64",
    not(target_env = "sgx"),
    not(feature = "no-runtime-detect")
))]
fn detect_avx2() -> bool {
    use core::arch::x86_64::{__cpuid, __cpuid_count, _xgetbv};
    // SAFETY: CPUID is part of the x86-64 baseline. First establish AVX hardware,
    // XSAVE and OSXSAVE support; only then execute XGETBV. Bits1/2 in XCR0 prove
    // that the OS preserves both XMM and YMM state. Leaf7 additionally proves AVX2.
    unsafe {
        if __cpuid(0).eax < 7 {
            return false;
        }
        let features = __cpuid(1).ecx;
        let needed = (1 << 26) | (1 << 27) | (1 << 28);
        features & needed == needed
            && _xgetbv(0) & 6 == 6
            && __cpuid_count(7, 0).ebx & (1 << 5) != 0
    }
}

#[inline]
pub(crate) fn encode(input: &[u8], output: &mut [u8], url: bool) -> usize {
    let minimum = if cfg!(target_arch = "aarch64") {
        48
    } else {
        24
    };
    if !cfg!(feature = "no-short-path") && input.len() < minimum {
        return 0;
    }
    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    if avx2() {
        // SAFETY: avx2() checks CPU and OS support or a compile-target guarantee.
        return unsafe { crate::simd::avx2::encode(input, output, url) };
    }
    #[cfg(target_arch = "aarch64")]
    if cfg!(target_feature = "neon") {
        // SAFETY: NEON is guaranteed by the compilation target. Kernels bound
        // every memory access by the provided slices.
        return unsafe { crate::simd::neon::encode(input, output, url) };
    }
    let _ = (output, url);
    0
}

#[inline]
pub(crate) fn decode(input: &[u8], output: &mut [u8], url: bool) -> Result<usize, usize> {
    let minimum = if cfg!(target_arch = "aarch64") {
        64
    } else {
        32
    };
    if !cfg!(feature = "no-short-path") && input.len() < minimum {
        return Ok(0);
    }
    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    if avx2() {
        // SAFETY: avx2() checks CPU and OS support or a compile-target guarantee.
        return unsafe { crate::simd::avx2::decode(input, output, url) };
    }
    #[cfg(target_arch = "aarch64")]
    if cfg!(target_feature = "neon") {
        // SAFETY: NEON is guaranteed by the compilation target.
        return unsafe { crate::simd::neon::decode(input, output, url) };
    }
    let _ = (output, url);
    Ok(0)
}

#[cfg(all(
    test,
    target_arch = "x86_64",
    not(target_env = "sgx"),
    not(feature = "no-runtime-detect")
))]
mod tests {
    extern crate std;

    #[test]
    fn detection_agrees_with_standard_library() {
        assert_eq!(super::detect_avx2(), std::is_x86_feature_detected!("avx2"));
        assert_eq!(super::avx2(), std::is_x86_feature_detected!("avx2"));
    }
}
