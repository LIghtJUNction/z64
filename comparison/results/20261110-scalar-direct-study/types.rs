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

