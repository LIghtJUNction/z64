from pathlib import Path
import subprocess
import argparse
parser=argparse.ArgumentParser(description='Recreate the four source snapshots from the fixed Git baseline.')
parser.add_argument('--repo',type=Path,required=True)
ROOT=parser.parse_args().repo
OUT=Path(__file__).parent
BASE='cda77a6bd866be19831decc420e95a5a5bd79e75'
source=subprocess.check_output(['git','show',BASE+':src/simd/avx512.rs'],cwd=ROOT,text=True)
tests=subprocess.check_output(['git','show',BASE+':src/simd/avx512_tests.rs'],cwd=ROOT,text=True).replace('for offset in 0..32 {','for offset in 0..64 {')
(OUT/'avx512_tests.rs').write_text(tests)
(OUT/'baseline.rs').write_text(source)
def block(s,needle):
 a=s.index(needle); b=s.index('{',a); d=1; e=b+1
 while d:
  if s[e]=='{':d+=1
  elif s[e]=='}':d-=1
  e+=1
 return a,e,s[a:e]
def encode(s):
 constants='''
const fn encode_offset(offset: u8) -> [u8; 64] {
    let mut indices = encode_indices();
    let mut i = 0;
    while i < 64 {
        indices[i] += offset;
        i += 1;
    }
    indices
}
const ENCODE_BULK_48: [u8; 64] = encode_offset(48);
const ENCODE_BULK_32: [u8; 64] = encode_offset(32);
const ENCODE_BULK_16: [u8; 64] = encode_offset(16);
'''
 s=s.replace('const ENCODE_INDICES: [u8; 64] = encode_indices();','const ENCODE_INDICES: [u8; 64] = encode_indices();\n'+constants)
 a,e,old=block(s,'    while input.len() - i >= 192 && output.len() - o >= 256 {')
 start=old.index('        // SAFETY:')
 stop=old.index('            _mm512_storeu_si512(output.as_mut_ptr().add(o).cast(), a);')
 new=old[:start]+'''        // SAFETY: three exact 64-byte loads cover precisely 192 input bytes;
        // four 64-byte stores cover precisely the 256-byte output block.
        unsafe {
            let a = _mm512_loadu_si512(input.as_ptr().add(i).cast());
            let b = _mm512_loadu_si512(input.as_ptr().add(i + 64).cast());
            let c = _mm512_loadu_si512(input.as_ptr().add(i + 128).cast());
            let wa = _mm512_permutexvar_epi8(indices, a);
            let wb = _mm512_permutex2var_epi8(a, indices48, b);
            let wc = _mm512_permutex2var_epi8(b, indices32, c);
            let wd = _mm512_permutexvar_epi8(indices16, c);
            let a = _mm512_permutexvar_epi8(_mm512_multishift_epi64_epi8(shifts, wa), alphabet);
            let b = _mm512_permutexvar_epi8(_mm512_multishift_epi64_epi8(shifts, wb), alphabet);
            let c = _mm512_permutexvar_epi8(_mm512_multishift_epi64_epi8(shifts, wc), alphabet);
            let d = _mm512_permutexvar_epi8(_mm512_multishift_epi64_epi8(shifts, wd), alphabet);
'''+old[stop:]
 guard='''    if input.len() >= 192 && output.len() >= 256 {
        // SAFETY: each permutation table contains exactly 64 bytes. Bulk-only
        // constants are prepared only when at least one complete block fits.
        let (indices48, indices32, indices16) = unsafe {
            (
                _mm512_loadu_si512(ENCODE_BULK_48.as_ptr().cast()),
                _mm512_loadu_si512(ENCODE_BULK_32.as_ptr().cast()),
                _mm512_loadu_si512(ENCODE_BULK_16.as_ptr().cast()),
            )
        };
'''
 s=s[:a]+guard+new+'\n    }'+s[e:]
 return s
def decode(s):
 constants='''
const fn decode_bulk_indices(skip: usize) -> [u8; 64] {
    let mut indices = [0; 64];
    let mut i = 0;
    while i < 64 {
        // Each source vector holds 48 decoded bytes as sixteen little-endian
        // 24-bit words. Select bytes directly across two adjacent vectors.
        let position = skip + i;
        let local = position % 48;
        indices[i] = (64 * (position / 48) + 4 * (local / 3) + 2 - local % 3) as u8;
        i += 1;
    }
    indices
}
const DECODE_BULK_0: [u8; 64] = decode_bulk_indices(0);
const DECODE_BULK_16: [u8; 64] = decode_bulk_indices(16);
const DECODE_BULK_32: [u8; 64] = decode_bulk_indices(32);
'''
 s=s.replace('const DECODE_INDICES: [u8; 64] = decode_indices();','const DECODE_INDICES: [u8; 64] = decode_indices();\n'+constants)
 a,e,old=block(s,'    while input.len() - i >= 256 && output.len() - o >= 192 {')
 old=old.replace('// SAFETY: the loop proves four complete 64-byte reads and four exact\n        // 48-byte masked writes. Validate the entire group before any write.','// SAFETY: the loop proves four complete 64-byte reads and three exact\n        // 64-byte writes. Validate the entire group before any write.')
 start=old.index('            let a = decode_vector(va, indices);')
 stop=old.index('\n        }',start)
 new=old[:start]+'''            let pairs = _mm512_set1_epi32(0x0140_0140);
            let quanta = _mm512_set1_epi32(0x0001_1000);
            let wa = _mm512_madd_epi16(_mm512_maddubs_epi16(va, pairs), quanta);
            let wb = _mm512_madd_epi16(_mm512_maddubs_epi16(vb, pairs), quanta);
            let wc = _mm512_madd_epi16(_mm512_maddubs_epi16(vc, pairs), quanta);
            let wd = _mm512_madd_epi16(_mm512_maddubs_epi16(vd, pairs), quanta);
            let a = _mm512_permutex2var_epi8(wa, indices0, wb);
            let b = _mm512_permutex2var_epi8(wb, indices16, wc);
            let c = _mm512_permutex2var_epi8(wc, indices32, wd);
            _mm512_storeu_si512(output.as_mut_ptr().add(o).cast(), a);
            _mm512_storeu_si512(output.as_mut_ptr().add(o + 64).cast(), b);
            _mm512_storeu_si512(output.as_mut_ptr().add(o + 128).cast(), c);'''+old[stop:]
 guard='''    if input.len() >= 256 && output.len() >= 192 {
        // SAFETY: these fixed 64-byte tables are needed only by a full bulk block.
        let (indices0, indices16, indices32) = unsafe {
            (
                _mm512_loadu_si512(DECODE_BULK_0.as_ptr().cast()),
                _mm512_loadu_si512(DECODE_BULK_16.as_ptr().cast()),
                _mm512_loadu_si512(DECODE_BULK_32.as_ptr().cast()),
            )
        };
'''
 s=s[:a]+guard+new+'\n    }'+s[e:]
 return s
(OUT/'encode3.rs').write_text(encode(source))
(OUT/'decode3.rs').write_text(decode(source))
(OUT/'combined.rs').write_text(decode(encode(source)))
(OUT/'tests.rs').write_text('''#![deny(unsafe_op_in_unsafe_fn)]
mod baseline;
mod encode3;
mod decode3;
mod combined;
''')
