#[path = "variant1.rs"]
mod baseline;
#[path = "variant3.rs"]
mod candidate;

use std::hint::black_box;
use std::time::{Duration, Instant};

type Encoder = unsafe fn(&[u8], &mut [u8], bool) -> usize;
type Decoder = unsafe fn(&[u8], &mut [u8], bool) -> Result<usize, usize>;

fn encode_reference(raw: &[u8], url: bool) -> Vec<u8> {
    let alphabet = if url { b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_" } else { b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/" };
    raw.chunks_exact(3).flat_map(|x| {
        let v = u32::from(x[0]) << 16 | u32::from(x[1]) << 8 | u32::from(x[2]);
        [alphabet[(v >> 18) as usize], alphabet[((v >> 12) & 63) as usize], alphabet[((v >> 6) & 63) as usize], alphabet[(v & 63) as usize]]
    }).collect()
}

fn check(encode: Encoder, decode: Decoder) {
    for url in [false,true] {
        for n in 0..300 {
            let input: Vec<u8> = (0..n).map(|i| (i * 73 + n * 17) as u8).collect();
            let expected = encode_reference(&input, url);
            for offset in 0..32 {
                let mut raw = vec![0xa5;n+offset]; raw[offset..].copy_from_slice(&input);
                let written = n / 24 * 32;
                let mut output = vec![0xa5;offset+written+17];
                assert_eq!(unsafe { encode(&raw[offset..], &mut output[offset..offset+written], url) }, n / 24 * 24);
                assert_eq!(&output[offset..offset+written], &expected[..written]);
                assert!(output[..offset].iter().chain(&output[offset+written..]).all(|&b|b==0xa5));
                let consumed=expected.len()/32*32; let written=consumed/4*3;
                let mut text=vec![0xa5;offset+expected.len()];text[offset..].copy_from_slice(&expected);
                let mut output=vec![0xa5;offset+written+17];
                assert_eq!(unsafe { decode(&text[offset..], &mut output[offset..offset+written], url) }, Ok(consumed));
                assert_eq!(&output[offset..offset+written], &input[..written]);
                assert!(output[..offset].iter().chain(&output[offset+written..]).all(|&b|b==0xa5));
            }
        }
        for pos in 0..160 {
            for byte in 0..=255 {
                let mut text=vec![b'A';160];text[pos]=byte;
                let mut out=vec![0xa5;120];
                let result=unsafe{decode(&text,&mut out,url)};
                let valid=byte.is_ascii_alphanumeric() || byte==if url{b'-'}else{b'+'} || byte==if url{b'_'}else{b'/'};
                if valid {assert_eq!(result,Ok(160));} else {
                    assert_eq!(result,Err(pos),"{pos} {byte} {url}");
                    assert!(out[pos/32*24..].iter().all(|&b|b==0xa5));
                }
            }
        }
    }
}

fn sample(mut operation: impl FnMut(), iterations:usize) -> f64 {
    let now=Instant::now();while now.elapsed()<Duration::from_millis(1){operation();}
    let start=Instant::now();for _ in 0..iterations {operation();}
    start.elapsed().as_nanos() as f64 / iterations as f64
}

fn main(){
    assert!(std::is_x86_feature_detected!("avx2"));
    check(baseline::encode,baseline::decode);check(candidate::encode,candidate::decode);
    if std::env::args().any(|x|x=="--check"){return;}
    println!("op,url,raw_bytes,sample,baseline_ns,candidate_ns,speedup");
    for url in [false,true] {
        for n in [24,48,96,4080,1048560] {
            let raw:Vec<u8>=(0..n).map(|i|(i*73+17)as u8).collect();let text=encode_reference(&raw,url);
            let mut out=vec![0; text.len()]; let mut decoded=vec![0;n];
            let count=(100000000/n).max(10);
            for k in 0..9 {
                let (a,b) = if k%2==0 {
                    let a=sample(||{black_box(unsafe{baseline::encode(black_box(&raw),black_box(&mut out),black_box(url))});},count);
                    let b=sample(||{black_box(unsafe{candidate::encode(black_box(&raw),black_box(&mut out),black_box(url))});},count);(a,b)
                }else{
                    let b=sample(||{black_box(unsafe{candidate::encode(black_box(&raw),black_box(&mut out),black_box(url))});},count);
                    let a=sample(||{black_box(unsafe{baseline::encode(black_box(&raw),black_box(&mut out),black_box(url))});},count);(a,b)
                };
                assert_eq!(out,text);println!("encode,{url},{n},{k},{a:.3},{b:.3},{:.3}",a/b);
                let (a,b)=if k%2==0{
                    let a=sample(||{black_box(unsafe{baseline::decode(black_box(&text),black_box(&mut decoded),black_box(url))});},count);
                    let b=sample(||{black_box(unsafe{candidate::decode(black_box(&text),black_box(&mut decoded),black_box(url))});},count);(a,b)
                }else{
                    let b=sample(||{black_box(unsafe{candidate::decode(black_box(&text),black_box(&mut decoded),black_box(url))});},count);
                    let a=sample(||{black_box(unsafe{baseline::decode(black_box(&text),black_box(&mut decoded),black_box(url))});},count);(a,b)
                };
                assert_eq!(decoded,raw);println!("decode,{url},{n},{k},{a:.3},{b:.3},{:.3}",a/b);
            }
        }
    }
}
