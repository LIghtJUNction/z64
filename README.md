# z64

Strict RFC 4648 Base64 and Base64URL for caller-owned buffers. Always `no_std`,
using only `core`: no dependencies, allocation, build script, or external runtime.
Stable Rust; MSRV **1.70.0**. MIT licensed.

```rust
use z64::{decode, encode, Mode};

let mut text = [0; 8];
let n = encode(b"hello", &mut text, Mode::Standard).unwrap();
assert_eq!(&text[..n], b"aGVsbG8=");

let mut bytes = [0; 5];
let n = decode(&text[..n], &mut bytes, Mode::Standard).unwrap();
assert_eq!(&bytes[..n], b"hello");
```

## Modes and buffers

| Mode | Symbols 62 / 63 | Incomplete final quantum |
| --- | --- | --- |
| `Standard` | `+ /` | Requires `=` padding |
| `StandardNoPad` | `+ /` | Forbids `=` |
| `UrlSafe` | `- _` | Requires `=` padding |
| `UrlSafeNoPad` | `- _` | Forbids `=` |

Complete quanta have no padding in all four modes. Symbols 0–61 are shared;
the other alphabet's symbols 62/63 are rejected. Whitespace, line breaks, misplaced
padding, impossible lengths, and nonzero unused bits are errors.

`encoded_len(n, mode)` returns the exact size, or `None` on overflow.
`decoded_capacity(n)` returns `Some` of a safe upper bound for every `usize`,
without validating syntax. Terminal padding can reduce the exact decode capacity.
Both conversions return the actual written length. Exact-sized, unaligned slices
are supported; no readable or writable buffer tail is required.

## Error contract

All positions are zero-based byte offsets in the original input. Decode precedence:

1. Impossible length: padded input must be divisible by four; unpadded input must
   not have remainder one. `InvalidLength.index` is the end-of-input offset.
2. Output capacity, calculated using length and at most two terminal `=` bytes in
   padded modes. `OutputTooSmall` reports that required size even if content is invalid.
3. First illegal alphabet byte or misplaced `=`, from left to right.
4. Nonzero unused bits at the last alphabet symbol (`NonCanonical`).

Length/capacity errors leave output unchanged. On a content error at `index`,
only complete decoded quanta before that quantum may have changed: at most
`output[..(index / 4) * 3]`. That prefix is unspecified on error. The rest remains
unchanged. Successful calls change only `output[..written]`.

## Scope

The specification is [RFC 4648 §§3–5 and §10](https://www.rfc-editor.org/rfc/rfc4648.html).
There is no MIME handling, whitespace skipping, custom alphabet, streaming I/O,
CLI, serde integration, or other encoding format.
