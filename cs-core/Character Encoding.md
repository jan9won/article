# Character Encoding

Character encoding basics for beginners.

> **Reviews**
>
> - last reviewed : 2021-11-24
> - related versions
>   - Unicode : 2021-9-14
>   - ECMAScript : 2021-11-20  [Link](https://tc39.es/ecma262/#sec-terms-and-definitions-string-value)

## How To Map Character Codes To A Table

### Map Necessary English Characters Into A Single Table
<<<<<<< Updated upstream
#### Short History (from wikipedia)

- Optical Telegraph Codes
- Electrical Telegraph Codes
- Automatic Telegraph Codes

#### ASCII

>  Improved version of telegraph code set, for computational use.

1. There's Control Characters, which includes things like space and delete.
2. And There are alphabets and special characters on your keyboards.

### Map More Languages In Separate Tables
#### Code Page
#### EUC (Extended Unix Code)
#### ANSI Is Not A Fixed Standard

## How to Map Every Language In A Single Table
### Unicode
### Needs For Encoding

## How To Encode Unicode Characters More Efficiently
### Fixed Length Encoding
#### UCS-2
#### UTF-32
### Variable Length Encoding
#### UTF-16
#### UTF-8

## More About Hangul Encoding
### UTF-8 vs EUC-KR vs CP949
### Which Encoding For What Use

## More About Common Compatibility Issues And Environment Setups

### Between Shells

export LANG=en_US.UTF-8

### Between Backend Services

### Between Client App And Backend Servers

### Between Client App And It’s Operating System's Encoding Or Locale

### In Files

### Between Network Protocols (NGINX/Apache)

## References
- Primary Reference
	- https://www.joelonsoftware.com/2003/10/08/the-absolute-minimum-every-software-developer-absolutely-positively-must-know-about-unicode-and-character-sets-no-excuses/
- ASCII
- Code PAge
- EUC
- ANSI
- Unicode
- utf-16, Endians, Byte Order Mark
	- https://en.wikipedia.org/wiki/UTF-16
	- https://docs.microsoft.com/en-us/globalization/encoding/byte-order-mark
- UTF-8
- Hangul
	- CP949
	- Unified Hangul Enoding
	- Comparison
- Web Compatibility
