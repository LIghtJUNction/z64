#![deny(unsafe_op_in_unsafe_fn)]
#[path="baseline.rs"] mod old;
#[path="avx512_first.rs"] mod new;
use std::{hint::black_box,time::Instant};
type Encoder=unsafe fn(&[u8],&mut[u8],bool)->usize;
type Decoder=unsafe fn(&[u8],&mut[u8],bool)->Result<usize,usize>;
fn main(){
 assert!(std::is_x86_feature_detected!("avx512vbmi"));
 let encoders:[(&str,Encoder);2]=[("old-avx2",old::encode),("avx512-vbmi",new::encode)];
 let decoders:[(&str,Decoder);2]=[("old-avx2",old::decode),("avx512-vbmi",new::decode)];
 println!("operation,variant,binary_bytes,url,sample,iterations,elapsed_ns,ns_per_call");
 for n in [24usize,48,96,192,384,4080,65520,1048560,4194288]{
  let input:Vec<u8>=(0..n).map(|i|(i*73+19)as u8).collect();
  let mut encoded=vec![0;n/3*4];let mut decoded=vec![0;n];let mut expected=encoded.clone();
  let iterations=(4_000_000/n).clamp(16,200000);
  for url in [false,true]{
   assert_eq!(unsafe{old::encode(&input,&mut expected,url)},n);
   for(_,f)in encoders{assert_eq!(unsafe{f(&input,&mut encoded,url)},n);assert_eq!(encoded,expected);for _ in 0..32{black_box(unsafe{f(black_box(&input),black_box(&mut encoded),black_box(url))});}}
   for(_,f)in decoders{assert_eq!(unsafe{f(&encoded,&mut decoded,url)},Ok(encoded.len()));assert_eq!(decoded,input);for _ in 0..32{let _ = black_box(unsafe{f(black_box(&encoded),black_box(&mut decoded),black_box(url))});}}
   for sample in 0..9{
    for shift in 0..2{
     let(name,f)=encoders[(sample+shift)%2];let start=Instant::now();
     for _ in 0..iterations{black_box(unsafe{f(black_box(&input),black_box(&mut encoded),black_box(url))});}
     let elapsed=start.elapsed().as_nanos();assert_eq!(encoded,expected);
     println!("encode,{name},{n},{url},{sample},{iterations},{elapsed},{}",elapsed as f64/iterations as f64);
     let(name,f)=decoders[(sample+shift)%2];let start=Instant::now();
     for _ in 0..iterations{let _ = black_box(unsafe{f(black_box(&encoded),black_box(&mut decoded),black_box(url))});}
     let elapsed=start.elapsed().as_nanos();assert_eq!(decoded,input);
     println!("decode,{name},{n},{url},{sample},{iterations},{elapsed},{}",elapsed as f64/iterations as f64);
    }
   }
  }
 }
}
