//! Whole-block SIMD kernels. Public validation and all tails stay in `lib.rs`.
//!
//! The AVX2 packing follows the bit grouping described by Muła and Lemire,
//! "Faster Base64 Encoding and Decoding Using AVX2 Instructions" (2018),
//! https://arxiv.org/abs/1704.00605. Loads and stores here are bounded by the
//! supplied slices, including the final vector: no readable/writable tail is
//! assumed. An invalid vector is never stored.

#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
#[path = "simd/avx2.rs"]
pub(crate) mod avx2;
#[cfg(target_arch = "aarch64")]
#[path = "simd/neon.rs"]
pub(crate) mod neon;

#[cfg(all(test, not(miri)))]
#[path = "simd/tests.rs"]
mod tests;
