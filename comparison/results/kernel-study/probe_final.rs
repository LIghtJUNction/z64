#![deny(unsafe_op_in_unsafe_fn)]
mod baseline;
mod table;
mod count;
mod table_count;
use std::{hint::black_box,time::Instant};
type Kernel=unsafe fn(&[u8],&mut[u8],bool)->usize;
fn main(){
 assert!(std::is_x86_feature_detected!("avx2"));
 let kernels:[(&str,Kernel);4]=[("baseline",baseline::encode),("table",table::encode),("count",count::encode),("table-count",table_count::encode)];
 println!("variant,input_bytes,consumed_bytes,url,sample,iterations,elapsed_ns,ns_per_call");
 for n in [24usize,48,96,384,4096,65536,1048576,4194304]{
  let input:Vec<u8>=(0..n).map(|i|(i*73+19) as u8).collect();
  let consumed=n/24*24;
  let mut output=vec![0u8;n/24*32];
  let mut expected=output.clone();
  let iterations=(4_000_000/n).clamp(8,200_000);
  for url in [false,true]{
   unsafe{baseline::encode(&input,&mut expected,url);}
   for (_,f) in kernels{assert_eq!(unsafe{f(&input,&mut output,url)},consumed);assert_eq!(output,expected);for _ in 0..32{black_box(unsafe{f(black_box(&input),black_box(&mut output),black_box(url))});}}
   for sample in 0..9{
    for shift in 0..kernels.len(){
     let (name,f)=kernels[(sample+shift)%kernels.len()];
     let start=Instant::now();
     for _ in 0..iterations{black_box(unsafe{f(black_box(&input),black_box(&mut output),black_box(url))});}
     let elapsed=start.elapsed().as_nanos();
     assert_eq!(output,expected);
     println!("{name},{n},{consumed},{url},{sample},{iterations},{elapsed},{}",elapsed as f64/iterations as f64);
    }
   }
  }
 }
}
