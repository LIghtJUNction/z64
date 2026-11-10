//! Independent references and matched, preallocated benchmark adapters.
use base64::Engine as _;
use base64_simd::AsOut;
pub use z64::Mode;

#[derive(Clone, Copy, Debug, Eq, PartialEq)]
pub struct Rejected;

pub const MODES: [Mode; 4] = [
    Mode::Standard,
    Mode::StandardNoPad,
    Mode::UrlSafe,
    Mode::UrlSafeNoPad,
];
pub const LENGTHS: &[usize] = &[
    0, 1, 2, 3, 15, 16, 17, 23, 24, 25, 31, 32, 33, 47, 48, 49, 63, 64, 65, 95, 96, 97, 127, 128,
    129, 255, 256, 257, 4095, 4096, 4097, 65536, 1048576, 4194304,
];
pub const SEED: u64 = 0x764b_ba92_a5c6_4e13;

pub fn mode_name(mode: Mode) -> &'static str {
    match mode {
        Mode::Standard => "standard",
        Mode::StandardNoPad => "standard-no-pad",
        Mode::UrlSafe => "url-safe",
        Mode::UrlSafeNoPad => "url-safe-no-pad",
    }
}

pub fn padded(mode: Mode) -> bool {
    matches!(mode, Mode::Standard | Mode::UrlSafe)
}

pub fn url(mode: Mode) -> bool {
    matches!(mode, Mode::UrlSafe | Mode::UrlSafeNoPad)
}

/// Independent bit-buffer encoder: no shared tables or helpers from z64.
pub fn reference_encode(input: &[u8], mode: Mode) -> Vec<u8> {
    let alphabet = if url(mode) {
        b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"
    } else {
        b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    };
    let mut output = Vec::new();
    let (mut accumulator, mut bits) = (0u32, 0u32);
    for &byte in input {
        accumulator = (accumulator << 8) | u32::from(byte);
        bits += 8;
        while bits >= 6 {
            bits -= 6;
            output.push(alphabet[((accumulator >> bits) & 63) as usize]);
        }
        accumulator &= (1 << bits) - 1;
    }
    if bits != 0 {
        output.push(alphabet[(accumulator << (6 - bits)) as usize]);
    }
    if padded(mode) {
        while output.len() % 4 != 0 {
            output.push(b'=');
        }
    }
    output
}

/// Independent strict decoder. Errors intentionally have no z64-specific priority.
pub fn reference_decode(input: &[u8], mode: Mode) -> Result<Vec<u8>, Rejected> {
    let padding = input.iter().rev().take_while(|&&c| c == b'=').count();
    let data_length = input.len() - padding;
    if padded(mode) {
        if !input.len().is_multiple_of(4)
            || padding > 2
            || (padding == 0 && !data_length.is_multiple_of(4))
            || (padding == 1 && data_length % 4 != 3)
            || (padding == 2 && data_length % 4 != 2)
        {
            return Err(Rejected);
        }
    } else if padding != 0 || input.len() % 4 == 1 {
        return Err(Rejected);
    }
    let mut output = Vec::new();
    let (mut accumulator, mut bits) = (0u32, 0u32);
    for &byte in &input[..data_length] {
        let value = match byte {
            b'A'..=b'Z' => byte - b'A',
            b'a'..=b'z' => byte - b'a' + 26,
            b'0'..=b'9' => byte - b'0' + 52,
            b'+' if !url(mode) => 62,
            b'/' if !url(mode) => 63,
            b'-' if url(mode) => 62,
            b'_' if url(mode) => 63,
            _ => return Err(Rejected),
        };
        accumulator = (accumulator << 6) | u32::from(value);
        bits += 6;
        if bits >= 8 {
            bits -= 8;
            output.push((accumulator >> bits) as u8);
            accumulator &= (1 << bits) - 1;
        }
    }
    if accumulator != 0 {
        return Err(Rejected);
    }
    Ok(output)
}

pub struct Rng(u64);

impl Rng {
    pub fn new(seed: u64) -> Self {
        Self(seed)
    }

    pub fn next_u64(&mut self) -> u64 {
        let mut x = self.0;
        x ^= x << 13;
        x ^= x >> 7;
        x ^= x << 17;
        self.0 = x;
        x
    }

    pub fn bytes(&mut self, length: usize) -> Vec<u8> {
        (0..length).map(|_| self.next_u64() as u8).collect()
    }
}

/// Result normalization happens equally for every competitor, outside its kernel.
pub trait Codec {
    fn name(&self) -> &'static str;
    fn encode(&self, input: &[u8], output: &mut [u8]) -> Result<usize, Rejected>;
    fn decode(&self, input: &[u8], output: &mut [u8]) -> Result<usize, Rejected>;
}

pub struct Z64(pub Mode);
impl Codec for Z64 {
    fn name(&self) -> &'static str {
        "z64"
    }
    #[inline]
    fn encode(&self, input: &[u8], output: &mut [u8]) -> Result<usize, Rejected> {
        z64::encode(input, output, self.0).map_err(|_| Rejected)
    }
    #[inline]
    fn decode(&self, input: &[u8], output: &mut [u8]) -> Result<usize, Rejected> {
        z64::decode(input, output, self.0).map_err(|_| Rejected)
    }
}

pub struct Z64Before(pub z64_before::Mode);
impl Codec for Z64Before {
    fn name(&self) -> &'static str {
        "z64-before-cda77a6"
    }
    #[inline]
    fn encode(&self, input: &[u8], output: &mut [u8]) -> Result<usize, Rejected> {
        z64_before::encode(input, output, self.0).map_err(|_| Rejected)
    }
    #[inline]
    fn decode(&self, input: &[u8], output: &mut [u8]) -> Result<usize, Rejected> {
        z64_before::decode(input, output, self.0).map_err(|_| Rejected)
    }
}

pub struct Base64Scalar(pub base64::engine::general_purpose::GeneralPurpose);
pub struct Base64Vector(pub base64::engine::simd::Simd);
pub struct Base64Simd(pub base64_simd::Base64);
pub struct Base64Turbo(pub base64_turbo::Engine);
pub struct Encodify(pub encodify::base64::Base64);

macro_rules! slice_codec {
    ($type:ident, $name:literal) => {
        impl Codec for $type {
            fn name(&self) -> &'static str {
                $name
            }
            #[inline]
            fn encode(&self, input: &[u8], output: &mut [u8]) -> Result<usize, Rejected> {
                self.0.encode_slice(input, output).map_err(|_| Rejected)
            }
            #[inline]
            fn decode(&self, input: &[u8], output: &mut [u8]) -> Result<usize, Rejected> {
                self.0.decode_slice(input, output).map_err(|_| Rejected)
            }
        }
    };
}
slice_codec!(Base64Scalar, "base64-scalar-0.23.1");
slice_codec!(Base64Vector, "base64-vector-0.23.1");
slice_codec!(Base64Turbo, "base64-turbo-0.6.0");
slice_codec!(Encodify, "encodify-1.0.2");

impl Codec for Base64Simd {
    fn name(&self) -> &'static str {
        "base64-simd-0.8.0"
    }
    #[inline]
    fn encode(&self, input: &[u8], output: &mut [u8]) -> Result<usize, Rejected> {
        Ok(self.0.encode(input, output.as_out()).len())
    }
    #[inline]
    fn decode(&self, input: &[u8], output: &mut [u8]) -> Result<usize, Rejected> {
        self.0
            .decode(input, output.as_out())
            .map(|x| x.len())
            .map_err(|_| Rejected)
    }
}

pub struct Codecs {
    pub z64: Z64,
    pub before: Z64Before,
    pub scalar: Base64Scalar,
    pub vector: Base64Vector,
    pub simd: Base64Simd,
    pub turbo: Base64Turbo,
    pub encodify: Encodify,
}

impl Codecs {
    pub fn new(mode: Mode) -> Self {
        use base64::engine::{general_purpose::GeneralPurposeConfig, DecodePaddingMode};
        let config = GeneralPurposeConfig::new()
            .with_encode_padding(padded(mode))
            .with_decode_allow_trailing_bits(false)
            .with_decode_padding_mode(if padded(mode) {
                DecodePaddingMode::RequireCanonical
            } else {
                DecodePaddingMode::RequireNone
            });
        let alphabet = if url(mode) {
            &base64::alphabet::URL_SAFE
        } else {
            &base64::alphabet::STANDARD
        };
        let vector = if url(mode) {
            base64::engine::simd::Simd::url_safe(config)
        } else {
            base64::engine::simd::Simd::standard(config)
        };
        let (simd, turbo, encodify) = match mode {
            Mode::Standard => (
                base64_simd::STANDARD,
                base64_turbo::STANDARD,
                encodify::base64::STANDARD,
            ),
            Mode::StandardNoPad => (
                base64_simd::STANDARD_NO_PAD,
                base64_turbo::STANDARD_NO_PAD,
                encodify::base64::STANDARD_NO_PAD,
            ),
            Mode::UrlSafe => (
                base64_simd::URL_SAFE,
                base64_turbo::URL_SAFE,
                encodify::base64::URL_SAFE,
            ),
            Mode::UrlSafeNoPad => (
                base64_simd::URL_SAFE_NO_PAD,
                base64_turbo::URL_SAFE_NO_PAD,
                encodify::base64::URL_SAFE_NO_PAD,
            ),
        };
        Self {
            z64: Z64(mode),
            before: Z64Before(match mode {
                Mode::Standard => z64_before::Mode::Standard,
                Mode::StandardNoPad => z64_before::Mode::StandardNoPad,
                Mode::UrlSafe => z64_before::Mode::UrlSafe,
                Mode::UrlSafeNoPad => z64_before::Mode::UrlSafeNoPad,
            }),
            scalar: Base64Scalar(base64::engine::general_purpose::GeneralPurpose::new(
                alphabet, config,
            )),
            vector: Base64Vector(vector),
            simd: Base64Simd(simd),
            turbo: Base64Turbo(turbo),
            encodify: Encodify(encodify),
        }
    }

    pub fn all(&self) -> [&dyn Codec; 7] {
        [
            &self.z64,
            &self.before,
            &self.scalar,
            &self.vector,
            &self.simd,
            &self.turbo,
            &self.encodify,
        ]
    }
}
