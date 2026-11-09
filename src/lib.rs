#![no_std]
#![deny(unsafe_op_in_unsafe_fn)]
#![warn(missing_docs)]
//! Strict RFC 4648 Base64 with caller-owned buffers and no dependencies.
//!
//! ```
//! use z64::{decode, encode, Mode};
//! let mut text = [0; 8];
//! let n = encode(b"hello", &mut text, Mode::Standard).unwrap();
//! assert_eq!(&text[..n], b"aGVsbG8=");
//! let mut bytes = [0; 5];
//! let n = decode(&text[..n], &mut bytes, Mode::Standard).unwrap();
//! assert_eq!(&bytes[..n], b"hello");
//! ```
//!
//! Alphabet, padding and zero unused bits are checked strictly. Whitespace is
//! never ignored. Positions are zero-based byte offsets in the original input.
//! See [`decode`] for error precedence and output mutation guarantees.

use core::fmt;

#[cfg(not(feature = "force-scalar"))]
mod dispatch;
#[cfg_attr(feature = "reference", path = "reference.rs")]
mod scalar;
#[cfg(not(feature = "force-scalar"))]
mod simd;

/// The four RFC 4648 alphabet/padding combinations.
#[derive(Clone, Copy, Debug, Eq, PartialEq)]
pub enum Mode {
    /// `A-Z a-z 0-9 + /`, with required `=` padding for incomplete quanta.
    Standard,
    /// `A-Z a-z 0-9 + /`, with all `=` padding forbidden.
    StandardNoPad,
    /// `A-Z a-z 0-9 - _`, with required `=` padding for incomplete quanta.
    UrlSafe,
    /// `A-Z a-z 0-9 - _`, with all `=` padding forbidden.
    UrlSafeNoPad,
}

impl Mode {
    const fn padded(self) -> bool {
        matches!(self, Self::Standard | Self::UrlSafe)
    }

    const fn url(self) -> bool {
        matches!(self, Self::UrlSafe | Self::UrlSafeNoPad)
    }
}

/// A conversion failure. Offsets refer to original input bytes, never characters.
#[derive(Clone, Copy, Debug, Eq, PartialEq)]
pub enum Error {
    /// The encoded length cannot be represented by `usize`.
    LengthOverflow,
    /// The output is too short. No output bytes have been changed.
    OutputTooSmall {
        /// Required capacity determined from input length and terminal padding.
        required: usize,
    },
    /// The input length is impossible for this mode. No output has been changed.
    InvalidLength {
        /// End-of-input offset, equal to the input length.
        index: usize,
    },
    /// A byte is outside the selected alphabet.
    InvalidByte {
        /// Zero-based offset of the first offending byte.
        index: usize,
        /// Original input byte at `index`.
        byte: u8,
    },
    /// An `=` occurs outside the permitted terminal padding.
    InvalidPadding {
        /// Zero-based offset of the first misplaced `=`.
        index: usize,
    },
    /// The last alphabet symbol contains nonzero unused bits.
    NonCanonical {
        /// Zero-based offset of that symbol.
        index: usize,
    },
}

impl fmt::Display for Error {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::LengthOverflow => f.write_str("encoded length overflows usize"),
            Self::OutputTooSmall { required } => write!(f, "output needs {required} bytes"),
            Self::InvalidLength { index } => write!(f, "invalid input length {index}"),
            Self::InvalidByte { index, byte } => {
                write!(f, "invalid byte 0x{byte:02x} at offset {index}")
            }
            Self::InvalidPadding { index } => write!(f, "invalid padding at offset {index}"),
            Self::NonCanonical { index } => write!(f, "nonzero unused bits at offset {index}"),
        }
    }
}

/// Exact encoding length, or `None` if it overflows `usize`.
#[inline]
pub const fn encoded_len(input_len: usize, mode: Mode) -> Option<usize> {
    let tail = match input_len % 3 {
        0 => 0,
        _ if mode.padded() => 4,
        n => n + 1,
    };
    match (input_len / 3).checked_mul(4) {
        Some(n) => n.checked_add(tail),
        None => None,
    }
}

/// Upper bound for decoded bytes, without validating syntax or inspecting padding.
///
/// This is overflow-safe for every `usize` input. The return type matches
/// [`encoded_len`]; this function always returns `Some`. Terminal padding can
/// reduce the exact requirement by one or two bytes.
#[inline]
pub const fn decoded_capacity(input_len: usize) -> Option<usize> {
    Some((input_len / 4) * 3 + ((input_len % 4) * 3) / 4)
}

/// Encode into `output`, returning the number of bytes written.
///
/// On any error output is unchanged. On success only `output[..written]` changes.
/// No extra capacity or alignment is required.
#[inline]
pub fn encode(input: &[u8], output: &mut [u8], mode: Mode) -> Result<usize, Error> {
    if input.is_empty() {
        return Ok(0);
    }
    let required = encoded_len(input.len(), mode).ok_or(Error::LengthOverflow)?;
    if output.len() < required {
        return Err(Error::OutputTooSmall { required });
    }
    let output = &mut output[..required];
    #[cfg(not(feature = "force-scalar"))]
    let consumed = dispatch::encode(input, output, mode.url());
    #[cfg(feature = "force-scalar")]
    let consumed = 0;
    scalar::encode(&input[consumed..], &mut output[(consumed / 3) * 4..], mode);
    Ok(required)
}

/// Decode canonical Base64 into `output`, returning the actual decoded length.
///
/// Errors have this precedence, identical across all backends:
///
/// 1. Impossible length (padded: length not divisible by four; unpadded: remainder
///    one). `index` equals `input.len()`; no output is modified.
/// 2. Insufficient capacity, calculated from length and at most two terminal `=`
///    bytes in padded modes. No output is modified, even for invalid content.
/// 3. The first illegal alphabet byte or misplaced `=`, scanning left to right.
/// 4. Nonzero unused bits in the last alphabet symbol.
///
/// For content errors, only a prefix of complete, validated three-byte quanta
/// before the offending quantum may have changed. Its maximum length is
/// `(index / 4) * 3`. That prefix is unspecified on error; all bytes after it
/// remain unchanged. On success only `output[..written]` changes.
///
/// A full four-symbol quantum needs no `=` in any mode. Padded and unpadded modes
/// differ on incomplete final quanta; standard and URL alphabets share symbols
/// 0 through 61. No mode guesses or accepts the other alphabet's symbols 62/63.
#[inline]
pub fn decode(input: &[u8], output: &mut [u8], mode: Mode) -> Result<usize, Error> {
    let n = input.len();
    if n == 0 {
        return Ok(0);
    }
    if (mode.padded() && !n.is_multiple_of(4)) || (!mode.padded() && n % 4 == 1) {
        return Err(Error::InvalidLength { index: n });
    }
    let mut data_len = n;
    if mode.padded() && n != 0 && input[n - 1] == b'=' {
        data_len -= 1;
        if input[n - 2] == b'=' {
            data_len -= 1;
        }
    }
    let body_len = data_len / 4 * 4;
    let tail_len = data_len % 4;
    let required = (data_len / 4) * 3 + (tail_len * 3) / 4;
    if output.len() < required {
        return Err(Error::OutputTooSmall { required });
    }
    let output = &mut output[..required];
    #[cfg(not(feature = "force-scalar"))]
    let consumed = dispatch::decode(&input[..body_len], output, mode.url()).map_err(|index| {
        if input[index] == b'=' {
            Error::InvalidPadding { index }
        } else {
            Error::InvalidByte {
                index,
                byte: input[index],
            }
        }
    })?;
    #[cfg(feature = "force-scalar")]
    let consumed = 0;
    scalar::decode_body(
        &input[consumed..body_len],
        &mut output[(consumed / 4) * 3..],
        mode.url(),
        consumed,
    )?;
    if tail_len != 0 {
        let a = scalar::value(input[body_len], mode.url(), body_len)?;
        let b = scalar::value(input[body_len + 1], mode.url(), body_len + 1)?;
        let out = body_len / 4 * 3;
        if tail_len == 2 {
            if b & 15 != 0 {
                return Err(Error::NonCanonical {
                    index: body_len + 1,
                });
            }
            output[out] = (a << 2) | (b >> 4);
        } else {
            let c = scalar::value(input[body_len + 2], mode.url(), body_len + 2)?;
            if c & 3 != 0 {
                return Err(Error::NonCanonical {
                    index: body_len + 2,
                });
            }
            output[out] = (a << 2) | (b >> 4);
            output[out + 1] = (b << 4) | (c >> 2);
        }
    }
    Ok(required)
}
