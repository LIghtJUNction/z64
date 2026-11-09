#![allow(dead_code)]
include!("types.rs");
mod baseline;
mod candidate;

use std::hint::black_box;
use std::time::{Duration, Instant};

type Decoder = fn(&[u8], &mut [u8], bool, usize) -> Result<(), Error>;

#[inline(never)]
fn old(input: &[u8], output: &mut [u8], url: bool, offset: usize) -> Result<(), Error> {
    baseline::decode_body(input, output, url, offset)
}

#[inline(never)]
fn new(input: &[u8], output: &mut [u8], url: bool, offset: usize) -> Result<(), Error> {
    candidate::decode_body(input, output, url, offset)
}

fn text(n: usize, url: bool) -> Vec<u8> {
    let alphabet = if url { b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_" } else { b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/" };
    let mut state = 0x6a09e667f3bcc909u64;
    (0..n).map(|_| { state ^= state << 13; state ^= state >> 7; state ^= state << 17; alphabet[(state & 63) as usize] }).collect()
}

fn check() {
    for url in [false, true] {
        for n in (0..=128).step_by(4) {
            let input = text(n, url);
            for start in 0..32 {
                let mut source = vec![0xa5; start + n]; source[start..].copy_from_slice(&input);
                let written = n / 4 * 3;
                let mut a = vec![0xa5; start + written + 17]; let mut b = a.clone();
                assert_eq!(old(&source[start..], &mut a[start..start + written], url, 19), new(&source[start..], &mut b[start..start + written], url, 19));
                assert_eq!(a, b);
                assert!(b[..start].iter().chain(&b[start + written..]).all(|&v| v == 0xa5));
            }
        }
        for position in 0..64 {
            for byte in 0..=255 {
                let mut input = text(64, url); input[position] = byte;
                let mut a = vec![0xa5; 48]; let mut b = a.clone();
                let expected = old(&input, &mut a, url, 19);
                assert_eq!(expected, new(&input, &mut b, url, 19));
                assert_eq!(a, b, "URL {url}, byte {byte}, position {position}");
                if expected.is_err() { assert!(b[position / 8 * 6..].iter().all(|&v| v == 0xa5)); }
            }
        }
    }
}

fn sample(f: Decoder, input: &[u8], output: &mut [u8], url: bool, count: usize) -> f64 {
    let start = Instant::now();
    while start.elapsed() < Duration::from_millis(1) { let _ = black_box(f(black_box(input), black_box(output), black_box(url), black_box(19))); }
    let start = Instant::now();
    for _ in 0..count { let _ = black_box(f(black_box(input), black_box(output), black_box(url), black_box(19))); }
    start.elapsed().as_nanos() as f64 / count as f64
}

fn main() {
    check();
    if std::env::args().any(|x| x == "--check") { return; }
    println!("case,url,text_bytes,sample,baseline_ns,candidate_ns,speedup");
    for url in [false, true] {
        for n in [4,8,12,16,20,24,28,32,64,4096] {
            let input = text(n, url);
            for kind in ["valid","invalid_head","invalid_middle","invalid_tail"] {
                let mut input = input.clone();
                if kind != "valid" { let pos = match kind { "invalid_head" => 0, "invalid_middle" => n/2, _=> n-1 }; input[pos] = b'!'; }
                let mut output = vec![0u8;n/4*3];let mut expected=output.clone();
                let expected_result=old(&input,&mut expected,url,19);
                assert_eq!(new(&input,&mut output,url,19),expected_result);assert_eq!(output,expected);
                let count=if n<=64 { 500_000 } else if kind=="invalid_head" { 500_000 } else { 3000 };
                for k in 0..7 {
                    let (a,b)=if k%2==0 { let a=sample(old,&input,&mut output,url,count);let b=sample(new,&input,&mut output,url,count);(a,b) } else {let b=sample(new,&input,&mut output,url,count);let a=sample(old,&input,&mut output,url,count);(a,b)};
                    assert_eq!(output,expected);
                    println!("{kind},{url},{n},{k},{a:.3},{b:.3},{:.3}",a/b);
                }
            }
        }
    }
}
