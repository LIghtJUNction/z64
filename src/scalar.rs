use crate::{Error, Mode};

const STANDARD: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
const URL: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";

#[inline]
pub(crate) fn encode(input: &[u8], output: &mut [u8], mode: Mode) {
    let alphabet = if mode.url() { URL } else { STANDARD };
    let mut i = 0;
    let mut o = 0;
    while input.len() - i >= 3 {
        let x = input[i];
        let y = input[i + 1];
        let z = input[i + 2];
        output[o] = alphabet[(x >> 2) as usize];
        output[o + 1] = alphabet[(((x & 3) << 4) | (y >> 4)) as usize];
        output[o + 2] = alphabet[(((y & 15) << 2) | (z >> 6)) as usize];
        output[o + 3] = alphabet[(z & 63) as usize];
        i += 3;
        o += 4;
    }
    let remaining = input.len() - i;
    if remaining != 0 {
        let x = input[i];
        output[o] = alphabet[(x >> 2) as usize];
        if remaining == 1 {
            output[o + 1] = alphabet[((x & 3) << 4) as usize];
            if mode.padded() {
                output[o + 2] = b'=';
                output[o + 3] = b'=';
            }
        } else {
            let y = input[i + 1];
            output[o + 1] = alphabet[(((x & 3) << 4) | (y >> 4)) as usize];
            output[o + 2] = alphabet[((y & 15) << 2) as usize];
            if mode.padded() {
                output[o + 3] = b'=';
            }
        }
    }
}

#[inline]
pub(crate) fn value(byte: u8, url: bool, index: usize) -> Result<u8, Error> {
    match byte {
        b'A'..=b'Z' => Ok(byte - b'A'),
        b'a'..=b'z' => Ok(byte - b'a' + 26),
        b'0'..=b'9' => Ok(byte - b'0' + 52),
        b'+' if !url => Ok(62),
        b'/' if !url => Ok(63),
        b'-' if url => Ok(62),
        b'_' if url => Ok(63),
        b'=' => Err(Error::InvalidPadding { index }),
        _ => Err(Error::InvalidByte { index, byte }),
    }
}

#[inline]
pub(crate) fn decode_body(
    input: &[u8],
    output: &mut [u8],
    url: bool,
    offset: usize,
) -> Result<(), Error> {
    let mut i = 0;
    let mut o = 0;
    while i < input.len() {
        let a = value(input[i], url, offset + i)?;
        let b = value(input[i + 1], url, offset + i + 1)?;
        let c = value(input[i + 2], url, offset + i + 2)?;
        let d = value(input[i + 3], url, offset + i + 3)?;
        output[o] = (a << 2) | (b >> 4);
        output[o + 1] = (b << 4) | (c >> 2);
        output[o + 2] = (c << 6) | d;
        i += 4;
        o += 3;
    }
    Ok(())
}
