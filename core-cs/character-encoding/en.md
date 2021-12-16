In modern development envionment, encodings other than Unicode are insignificant. But you can still encounter some of them legacy systems. Here's short history. 

## Short History

A concept of character encoding is an old thing, but modern form of character encoding started with an invention of electrical telegraph. 

Initial encodings only had characters that were considered necessary for transmission, as the price of transmission was high.

But as the era of computer began, needs for more various character sets has grown continuously, and many vendors tried different encodings to achieve higher efficiency.

### ASCII

> American Standard Code for Information Interchange

First computational character encoding developed by ASA (curruntly ANSI). It evolved from 7-bit teleprinter codes.

It includes lower and upper case English characters, numerals, punctuations and control characters all fit in 7-bit range (0-127).

Control characters are invisible instruction characters like BS(backspace), CR(carriage return) and transmission controls like ESC (escape).

![ASCII chart from a pre-1972 printer manual. Source - Wikipedia](images/ascii.png)

### Code Page

To encode more languages, each language's characters are mapped on separate code pages identifies with numbers. 

Each vendor has its own character sets. For example, UTF-8 is assigned to 1208 at IBM, 65001 at Microsoft, and 4110 at SAP.

### ANSI

ANSI is Not A Fixed Standard Name. What people referres to ANSI are these Code Pages in most cases.

- Code Page 1252 of Microsoft Windows (alias : windows-1252)
- Code page 437 of IBM PC

### EUC

> Extended Unix Code

Multibyte character encoding system used primarily for Japanese, Korean, and simplified Chinese.

Most of the conventions and standards for those languages moved on to Unicode and UTF-8. Yet EUC-KR is still popular for some Korean developers.

## Unicode

> Every characters in encoded in a single table. 

It covers 159 languages, and has 144,697 characters and expanding.

Unicode use two encoding forms, 8-bit or 16-bit. The largest encodings can encode up to 10FFFFh (1,114,111 in decimal).

Character sets are added sequentially. Which means you can identify each language with its range (i.e. English is 61-7A and Korean is AC00-D7A3). It's commonly used in CSS, to define which font-family to use for each language.

### Planes

Unicode has planes, which is a continuous group of 65,536 (216) code points. There are 17 planes, identified by the numbers 0 to 16,

- Basic Multilingual Plane (Plane 0 or BMP)

  - Includes all currently used languages
  - Some emojis

- Plane 1 to 16 : Supplementary Multilingual Plane (or Astral Plane)

  - Supplementary Multilingual Plane (Plane 1)
    - Math Symbols, Emojis, and many other less-used ones.

  > insignificant Supplementary planes
  >
  > - Supplementary Ideographic Plane (Plane 2)
  >   - Used for CJK (Chinese–Japanese–Korean) characters, that were not included in earlier character encoding standards.
  > - Tertiary Ideographic Plane (Plane 3)
  >   - Used for more CJK Extensions
  > - Unassigned planes (Plane 4 to 13)
  >   - No characters have yet been assigned
  > - Supplementary Special-purpose Plane (Plane 14)
  > - Private Use Area Planes [[edit](https://en.wikipedia.org/w/index.php?title=Plane_(Unicode)&action=edit&section=9)]
  >   - Can be used for private character encoding for third parties.

### Encodings

> Other than UTF-8 is insignificant. But we can learn about some useful concepts like endianness.

#### Fixed-Length and Variable-Length

How many bytes are used for each code point?

- fixed
  - UCS-2 : 2 byte integer (a single 16 bit code unit)
  - UTF-32 : 4 byte integer (a single 32 bit code unit)
- variable
  - UTF-16 : 1 ~ 2, 2-byte integer (variable 16 bit code units)
  - UTF-8 : 1 ~ 4, 1-byte integer (variable 8 bit code units)

In variable-length encodings, higher Unicode range is, more code units are used. Latin characters comes first, so languages like English and German use less bytes than languages like CJK or emojis.

i.e.

| encoding | !           | ⵣ           |
| -------- | ----------- | ----------- |
| UTF-8    | 21          | E2 B5 A3    |
| UTF-16   | 00 21       | 2D 63       |
| UTF-32   | 00 00 00 21 | 00 00 2D 63 |

#### Details of each encodings

##### UCS-2

**Maximum** 

65,536 characters

**Encoding**

It's a fixed encoding so implementation is simply a code point.

**Example**

`ⴰ` to UCS-2

```ll
ⴰ = U+2D30 = "2D 30"
```

**Usage** 

It's deprecated encoding, and was used in Windows and Java in the past.

Now UCS-2 is mostly used as fallback for GSM (Global System for Mobile Communications) network's GSM-7 encoding.

GSM-7 was originally used for pagers, but is still used for encoding SMS on your phone. One GSM message can send up to 160 characters. Longer messages will be a multipart message, which will be resassembled on reciever's side.

GSM-7 only includes English and some Latin and Special characters. So many other languages fall back to UCS-7.

As a SMS message is transmitted in 140 octets, a message which is encoded in UCS-2 has a maximum of 70 characters.

#####  UTF-32

>  Maximum 1,114,112 characters

It's used for internal APIs, but not frequently.

**Encoding**

It's a fixed encoding so implementation is simply a code point.

**Example**

`ⴰ` to UTF-32  

```
ⴰ = U+2D30 = "00 00 2D 30"
```

**Endianness and BOM**

(BOM is further explained in UTF-16 below)

BOM exists, but as UTF-32 is mostly used for internal API not external transmission, BOM doesn't have to be cared about in most cases.

##### UTF-16

**Maximum** 

1,112,064 characters

**Usage** 

It's used for many internal APIs, like Windows, Javascript, Python and more. Sadly, UTF-16 has some disadvantages over UTF-8, but as many APIs will not be chaging encodings, we should know how to operate with it.

**Encoding**

For code points in BMP (under 65,536), it simply uses a code point, which is *one* 2-byte code unit.

For code points in Supplementary Planes (over 65,536), it uses *two* 2-byte code unit. 

1. Code point is subtracted by `0x10000` which leaves 20-bits.

2. This remaining 20-bit is represented with two 10-bits, each added with `0x110110` and `0x110111`, making two 16-bit code units.

But for supplement planes, it uses surrogate pairs. It combines 

```
U' = yyyyyyyyyyxxxxxxxxxx  // U - 0x10000
W1 = 110110yyyyyyyyyy      // 0xD800 + yyyyyyyyyy
W2 = 110111xxxxxxxxxx      // 0xDC00 + xxxxxxxxxx
```

**Example**

UTF-16 encoding of 🙂 (code point U+1F642)

```
// Code point subtracted by 10000
U = 0x1F642
U' = 0x1F642 - 0x10000 = 0x0F642 = 1111011001000010

// U' devided into two 10 bits
0000111101 1001000010

// Each added to prefixes
W1 = 110110 0000111101 = "D83D"
W2 = 110111 1001000010 = "DE42"

// Reconstructed into two 2-byte units
🙂 = "0xD83D 0xDE42"
```

**Endianness and BOM**

But here's a problem. 

UTF-16 uses two bytes per units, and different computer architectures stores bytes in different orders! 

i.e., In big-endian order, means 🙂 will be "D8 3D  DE 42". But in little-endian order, 🙂 will be "3D D8  42 DE". 

To solve this problem, UTF-16 add BOM (Byte Order Mark) before the first actual coded value. 

BOM is at code point U+FEFF.

- If BOM is read as U+FEFF. You know the endianness matches between computers.
- If BOM is read as U+FFFE. You know the endianness doesn't match between computers.
- If the BOM doesn't exists, you assume it's a big-endian system.

##### UTF-8

**Maximum** 

1,112,064 characters

**Usage** 

Everywhere. It's compatible with ASCII, 

**Encoding**

The first byte has information about the number of following bytes.

And the rest are prefixed with 0b10000000 to be distinguished from 11 prefix of the first byte.

As the 1-unit length has 7 bits of information, it matches the lenght of ASCII.

| byte units | range              | byte 1   | byte 2   | byte 3   | byte 4   |
| :--------- | ------------------ | -------- | -------- | -------- | -------- |
| 1          | U+0000 - U+007F    | 0xxxxxxx |          |          |          |
| 2          | U+0080 - U+07FF    | 110xxxxx | 10xxxxxx |          |          |
| 3          | U+0800 - U+FFFF    | 1110xxxx | 10xxxxxx | 10xxxxxx |          |
| 4          | U+10000 - U+10FFFF | 11110xxx | 10xxxxxx | 10xxxxxx | 10xxxxxx |

**Example**

UTF-8 encoding of 🙂 (code point U+1F642)

```
// U+1F642 is in 4 bytes units.

0x1F642 = 0b11111011001000010

Binary 11110000 10011111 10011001 10000010
Hex    F0       9F       99       82
```

**Endianness and BOM**

UTF-8 doesn't need byte order mark, as it uses single byte per units!!

----

## Common Encoding Configurations

The problem is simple. You should know you and your messaging target's encodings, and encode/decode accordingly. But it can be challenging to debug when you already got problem with encoding. So configure properly before doing anything.

### Legacy Encodings

You should use utf-8 for dafault. But you can encounter legacy encodings in legacy systems. For example Korean developers will still encounter EUC-KR or CP949 encodings daily. In those cases you can encode/decode transmitted data, or configure each applications. 

### Shells

In most servers, UTF-8 with English locale will come as default. But you can choose whatever language you want (Read [bash manual]() for language codes). Shells will follow your configs. 

- `LANG` is base config
- `LANGUAGE` is for multiple languages
- `LC_ALL` is for overriding `LANG` and `LANGUAGE`
- other `LC_*` are detailed configs like time, numeric and address. You'll use `LC_TIME` in some occasions to get your local time right.

```sh
export LANG="ko_KR.UTF-8"

# system will use ko_KR if available, and en_US if not.
export LANGUAGE="ko_KR;en_US"

# time set to Korean time
# date command will print Korean time
export LC_TIME=ko_KR.UTF-8
date

```

### HTTP Servers

#### nginx

```nginx
# /etc/nginx/nginx.conf (differs by platforms)
# Add below lines to the root configuration file
http {
	...
	charset utf-8;
	source_charset utf-8;
	override_charset on;
	...
}
```

#### apache

```apache
# /etc/httpd/conf/httpd.conf (differs by platforms) 
# Add below line to the main configuration file
...
AddDefaultCharset utf-8
...
```

### Streams And Buffers

#### Detect File Encoding with Nodejs

You can use npm package "detect-character-encoding"

What this package does is simply to read the string and look for the encoding signal or byte order marks in it.

> Careful to bundle it in frontend as it does not support 32-bit operating systems.

```javascript
const fs = require('fs');
const en = require('detect-character-encoding');

const file = fs.readFileSync('file.txt');
const charset = detectCharacterEncoding(fileBuffer);
```



---

> **Reviews**
>
> - last reviewed : 2021-12-10
>
> **Related Versions**
>
> - Unicode : 14.0.0
> - ECMAScript : 12th edition
>
> **References**
>
> * [ASCII](https://en.wikipedia.org/wiki/ASCII)
> * [Code Page](https://en.wikipedia.org/wiki/Code_page) and [ANSI](https://en.wikipedia.org/wiki/ANSI_character_set)
> * [EUC](https://en.wikipedia.org/wiki/Extended_Unix_Code)
> * [Unicode](https://en.wikipedia.org/wiki/Unicode)
> * [UTF-16](https://en.wikipedia.org/wiki/UTF-16)
> * [Endians and Byte Order Mark](https://en.wikipedia.org/wiki/Endianness)
> * [UTF-8](https://en.wikipedia.org/wiki/UTF-8)