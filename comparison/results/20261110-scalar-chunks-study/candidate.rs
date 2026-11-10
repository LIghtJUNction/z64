use crate::{Error, Mode};

const STANDARD: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
const URL: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";

const fn pairs(alphabet: &[u8; 64]) -> [u16; 4096] {
    let mut table = [0; 4096];
    let mut i = 0;
    while i < table.len() {
        table[i] = ((alphabet[i >> 6] as u16) << 8) | alphabet[i & 63] as u16;
        i += 1;
    }
    table
}

const fn inverse(alphabet: &[u8; 64]) -> [u8; 256] {
    let mut table = [0xff; 256];
    let mut i = 0;
    while i < alphabet.len() {
        table[alphabet[i] as usize] = i as u8;
        i += 1;
    }
    table
}

static STANDARD_PAIRS: [u16; 4096] = pairs(STANDARD);
static URL_PAIRS: [u16; 4096] = pairs(URL);
static STANDARD_INVERSE: [u8; 256] = inverse(STANDARD);
static URL_INVERSE: [u8; 256] = inverse(URL);

#[inline]
pub(crate) fn encode(input: &[u8], output: &mut [u8], mode: Mode) {
    let alphabet = if mode.url() { URL } else { STANDARD };
    let table = if mode.url() {
        &URL_PAIRS
    } else {
        &STANDARD_PAIRS
    };
    let mut i = 0;
    let mut o = 0;
    while input.len() - i >= 3 {
        let word =
            (u32::from(input[i]) << 16) | (u32::from(input[i + 1]) << 8) | u32::from(input[i + 2]);
        let high = table[(word >> 12) as usize].to_be_bytes();
        let low = table[(word & 4095) as usize].to_be_bytes();
        output[o..o + 4].copy_from_slice(&[high[0], high[1], low[0], low[1]]);
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

#[cold]
fn invalid(byte: u8, index: usize) -> Error {
    if byte == b'=' {
        Error::InvalidPadding { index }
    } else {
        Error::InvalidByte { index, byte }
    }
}

#[inline]
pub(crate) fn value(byte: u8, url: bool, index: usize) -> Result<u8, Error> {
    let table = if url { &URL_INVERSE } else { &STANDARD_INVERSE };
    let value = table[byte as usize];
    if value == 0xff {
        Err(invalid(byte, index))
    } else {
        Ok(value)
    }
}

#[cold]
fn invalid_block(input: &[u8], table: &[u8; 256], offset: usize) -> Error {
    for (i, &byte) in input.iter().enumerate() {
        if table[byte as usize] == 0xff {
            return invalid(byte, offset + i);
        }
    }
    unreachable!("a set high bit identifies an invalid table entry")
}

#[inline]
pub(crate) fn decode_body(
    input: &[u8],
    output: &mut [u8],
    url: bool,
    offset: usize,
) -> Result<(), Error> {
    let table = if url { &URL_INVERSE } else { &STANDARD_INVERSE };
    let mut remaining = input;
    let mut i = 0;
    let mut o = 0;
    while let Some((chunk, rest)) = remaining.split_first_chunk::<8>() {
        let values = u64::from_be_bytes([
            table[chunk[0] as usize],
            table[chunk[1] as usize],
            table[chunk[2] as usize],
            table[chunk[3] as usize],
            table[chunk[4] as usize],
            table[chunk[5] as usize],
            table[chunk[6] as usize],
            table[chunk[7] as usize],
        ]);
        if values & 0x8080_8080_8080_8080 != 0 {
            return Err(invalid_block(chunk, table, offset + i));
        }
        // SWAR: gather eight six-bit values into four 12-bit pairs, then two
        // 24-bit words, and finally six adjacent bytes. Integer byte order is
        // explicit, so these operations also work on big-endian CPUs.
        let pairs = (values & 0x003f_003f_003f_003f) | ((values & 0x3f00_3f00_3f00_3f00) >> 2);
        let words = (pairs & 0x0000_0fff_0000_0fff) | ((pairs & 0x0fff_0000_0fff_0000) >> 4);
        let packed = (words & 0x00ff_ffff) | ((words & 0x00ff_ffff_0000_0000) >> 8);
        output[o..o + 6].copy_from_slice(&packed.to_be_bytes()[2..]);
        remaining = rest;
        i += 8;
        o += 6;
    }
    if !remaining.is_empty() {
        let a = table[remaining[0] as usize];
        let b = table[remaining[1] as usize];
        let c = table[remaining[2] as usize];
        let d = table[remaining[3] as usize];
        if (a | b | c | d) & 0x80 != 0 {
            return Err(invalid_block(&remaining[..4], table, offset + i));
        }
        output[o..o + 3].copy_from_slice(&[(a << 2) | (b >> 4), (b << 4) | (c >> 2), (c << 6) | d]);
    }
    Ok(())
}
