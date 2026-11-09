use crate::Error;

const INVALID: u32 = 1 << 31;
const STANDARD: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
const URL: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";

const fn shifted(alphabet: &[u8; 64]) -> [[u32; 256]; 4] {
    let mut table = [[INVALID; 256]; 4];
    let mut value = 0;
    while value < 64 {
        let byte = alphabet[value] as usize;
        table[0][byte] = (value as u32) << 18;
        table[1][byte] = (value as u32) << 12;
        table[2][byte] = (value as u32) << 6;
        table[3][byte] = value as u32;
        value += 1;
    }
    table
}

static STANDARD_SHIFTED: [[u32; 256]; 4] = shifted(STANDARD);
static URL_SHIFTED: [[u32; 256]; 4] = shifted(URL);

#[cold]
fn invalid(input: &[u8], table: &[u32; 256], offset: usize) -> Error {
    for (i, &byte) in input.iter().enumerate() {
        if table[byte as usize] & INVALID != 0 {
            return if byte == b'=' {
                Error::InvalidPadding { index: offset + i }
            } else {
                Error::InvalidByte { index: offset + i, byte }
            };
        }
    }
    unreachable!("invalid high bit must have originated in an input byte")
}

#[inline]
pub(crate) fn decode_body(input: &[u8], output: &mut [u8], url: bool, offset: usize) -> Result<(), Error> {
    let table = if url { &URL_SHIFTED } else { &STANDARD_SHIFTED };
    let mut i = 0;
    let mut o = 0;
    while input.len() - i >= 8 {
        let a = table[0][input[i] as usize] | table[1][input[i + 1] as usize]
            | table[2][input[i + 2] as usize] | table[3][input[i + 3] as usize];
        let b = table[0][input[i + 4] as usize] | table[1][input[i + 5] as usize]
            | table[2][input[i + 6] as usize] | table[3][input[i + 7] as usize];
        if (a | b) & INVALID != 0 {
            return Err(invalid(&input[i..i + 8], &table[0], offset + i));
        }
        let a = a.to_be_bytes();
        let b = b.to_be_bytes();
        output[o..o + 6].copy_from_slice(&[a[1], a[2], a[3], b[1], b[2], b[3]]);
        i += 8;
        o += 6;
    }
    if i != input.len() {
        let word = table[0][input[i] as usize] | table[1][input[i + 1] as usize]
            | table[2][input[i + 2] as usize] | table[3][input[i + 3] as usize];
        if word & INVALID != 0 {
            return Err(invalid(&input[i..i + 4], &table[0], offset + i));
        }
        output[o..o + 3].copy_from_slice(&word.to_be_bytes()[1..]);
    }
    Ok(())
}
