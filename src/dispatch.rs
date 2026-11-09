//! Hosted x86-64 detection checks CPU features and OS register-state support.
//! Other environments use only compile-target guarantees.

#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
#[inline]
fn backend() -> u8 {
    if !cfg!(feature = "no-avx512")
        && cfg!(all(
            target_feature = "avx512f",
            target_feature = "avx512bw",
            target_feature = "avx512vbmi"
        ))
    {
        return 3;
    }
    if cfg!(target_feature = "avx2")
        && (cfg!(feature = "no-avx512") || cfg!(feature = "no-runtime-detect"))
    {
        return 2;
    }
    #[cfg(all(
        target_arch = "x86_64",
        not(target_env = "sgx"),
        not(any(target_os = "none", target_os = "uefi")),
        not(feature = "no-runtime-detect")
    ))]
    {
        runtime::best()
    }
    #[cfg(not(all(
        target_arch = "x86_64",
        not(target_env = "sgx"),
        not(any(target_os = "none", target_os = "uefi")),
        not(feature = "no-runtime-detect")
    )))]
    {
        if cfg!(target_feature = "avx2") {
            2
        } else {
            1
        }
    }
}

#[cfg(all(
    target_arch = "x86_64",
    not(target_env = "sgx"),
    not(any(target_os = "none", target_os = "uefi")),
    not(feature = "no-runtime-detect")
))]
mod runtime {
    use core::sync::atomic::{AtomicU8, Ordering};
    static AVAILABLE: AtomicU8 = AtomicU8::new(0);
    const AVX_PREREQUISITES: u32 = (1 << 26) | (1 << 27) | (1 << 28);

    #[inline]
    pub(super) fn best() -> u8 {
        let cached = AVAILABLE.load(Ordering::Relaxed);
        if cached != 0 {
            return cached;
        }
        let detected = detect();
        // This caches immutable capabilities, not other shared memory. Racing
        // first calls may detect independently; no memory ordering is required.
        AVAILABLE.store(detected, Ordering::Relaxed);
        detected
    }

    fn detect() -> u8 {
        use core::arch::x86_64::{__cpuid, __cpuid_count, _xgetbv};
        // SAFETY: CPUID is baseline x86-64. XGETBV runs only after establishing
        // XSAVE/OSXSAVE/AVX. XCR0 proves the OS preserves every required register
        // class; AVX-512 additionally needs opmask and both ZMM state components.
        unsafe {
            if __cpuid(0).eax < 7 {
                return 1;
            }
            let processor = __cpuid(1).ecx;
            if processor & AVX_PREREQUISITES != AVX_PREREQUISITES {
                return 1;
            }
            let state = _xgetbv(0);
            let features = __cpuid_count(7, 0);
            classify(processor, features.ebx, features.ecx, state)
        }
    }

    fn classify(processor: u32, extended_ebx: u32, extended_ecx: u32, state: u64) -> u8 {
        if processor & AVX_PREREQUISITES != AVX_PREREQUISITES
            || state & 6 != 6
            || extended_ebx & (1 << 5) == 0
        {
            return 1;
        }
        let wide = (1 << 16) | (1 << 30);
        // Rust's AVX512F target feature also enables FMA and F16C. Their CPUID
        // bits must be checked separately; AVX512F does not imply them in hardware.
        let floating_point = (1 << 12) | (1 << 29);
        if !cfg!(feature = "no-avx512")
            && processor & floating_point == floating_point
            && state & 0xe6 == 0xe6
            && extended_ebx & wide == wide
            && extended_ecx & (1 << 1) != 0
        {
            3
        } else {
            2
        }
    }

    #[cfg(test)]
    mod tests {
        extern crate std;

        const PROCESSOR: u32 = super::AVX_PREREQUISITES | (1 << 12) | (1 << 29);
        const EXTENDED_EBX: u32 = (1 << 5) | (1 << 16) | (1 << 30);
        const EXTENDED_ECX: u32 = 1 << 1;
        const STATE: u64 = 0xe6;

        #[test]
        fn missing_avx_cpu_or_os_state_selects_scalar() {
            for bit in [26, 27, 28] {
                assert_eq!(
                    super::classify(PROCESSOR & !(1 << bit), EXTENDED_EBX, EXTENDED_ECX, STATE),
                    1,
                    "missing CPUID1 ECX bit {bit}"
                );
            }
            assert_eq!(
                super::classify(PROCESSOR, EXTENDED_EBX & !(1 << 5), EXTENDED_ECX, STATE),
                1
            );
            for bit in [1, 2] {
                assert_eq!(
                    super::classify(PROCESSOR, EXTENDED_EBX, EXTENDED_ECX, STATE & !(1 << bit)),
                    1,
                    "missing XCR0 bit {bit}"
                );
            }
        }

        #[test]
        fn every_wide_prerequisite_is_required_without_disabling_avx2() {
            let expected = if cfg!(feature = "no-avx512") { 2 } else { 3 };
            assert_eq!(
                super::classify(PROCESSOR, EXTENDED_EBX, EXTENDED_ECX, STATE),
                expected
            );
            for bit in [12, 29] {
                assert_eq!(
                    super::classify(PROCESSOR & !(1 << bit), EXTENDED_EBX, EXTENDED_ECX, STATE),
                    2,
                    "missing Rust AVX512F prerequisite CPUID1 ECX bit {bit}"
                );
            }
            for bit in [16, 30] {
                assert_eq!(
                    super::classify(PROCESSOR, EXTENDED_EBX & !(1 << bit), EXTENDED_ECX, STATE),
                    2,
                    "missing CPUID7 EBX bit {bit}"
                );
            }
            assert_eq!(super::classify(PROCESSOR, EXTENDED_EBX, 0, STATE), 2);
            for bit in [5, 6, 7] {
                assert_eq!(
                    super::classify(PROCESSOR, EXTENDED_EBX, EXTENDED_ECX, STATE & !(1 << bit)),
                    2,
                    "missing XCR0 bit {bit}"
                );
            }
            assert_eq!(super::classify(super::AVX_PREREQUISITES, 1 << 5, 0, 6), 2);
        }

        #[test]
        fn detection_agrees_with_standard_library() {
            let expected = if !cfg!(feature = "no-avx512")
                && std::is_x86_feature_detected!("avx512f")
                && std::is_x86_feature_detected!("avx512bw")
                && std::is_x86_feature_detected!("avx512vbmi")
            {
                3
            } else if std::is_x86_feature_detected!("avx2") {
                2
            } else {
                1
            };
            assert_eq!(super::detect(), expected);
            assert_eq!(super::best(), expected);
        }
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
    match backend() {
        // SAFETY: backend() establishes CPU/OS support or compile-target guarantees.
        3 => return unsafe { crate::simd::avx512::encode(input, output, url) },
        2 => return unsafe { crate::simd::avx2::encode(input, output, url) },
        _ => {}
    }
    #[cfg(target_arch = "aarch64")]
    if cfg!(target_feature = "neon") {
        // SAFETY: NEON is guaranteed by the compilation target.
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
    match backend() {
        // SAFETY: backend() establishes CPU/OS support or compile-target guarantees.
        3 => return unsafe { crate::simd::avx512::decode(input, output, url) },
        2 => return unsafe { crate::simd::avx2::decode(input, output, url) },
        _ => {}
    }
    #[cfg(target_arch = "aarch64")]
    if cfg!(target_feature = "neon") {
        // SAFETY: NEON is guaranteed by the compilation target.
        return unsafe { crate::simd::neon::decode(input, output, url) };
    }
    let _ = (output, url);
    Ok(0)
}
