Introduction on character encoding.

{{TOC}}

[TOC]

---

## Short History

Character encodings evolved to represent necessary characters in a limited lenght of serialized data, for electrical message transmission. 

Modern character encoding started with an invention of telegraph. It intended to make messaging protocol as efficient as possible, as messaging costs were high. So it only had upper case English letters, numerals and some puncuations. 

As the era of computer started, cost of messaging gone down, and  needs for more various characters has grown continuously. So since then, computer-dedicted character ecodings were created and evolved.  


## ASCII
> American Standard Code for Information Interchange

First computational character encoding, developed by ASA (curruntly ANSI). It evolved from 7-bit teleprinter codes.

It includes lower and upper case English characters, numerals, punctuations and control characters in 7-bit range (0-127).

![ASCII chart from a pre-1972 printer manual. Source - Wikipedia](images/ascii.png)

Control characters include non-visible character instructions like BS(backspace), CR(carriage return) and transmission controls like ESC (escape).

ASCII includes All the special characters and control characters on contemporary QWERTY keyboards.

## Needs for More Languages

### Code Page
> Map each language in separate table.

Made by microsoft. Each language is mapped on separate "Code Page" represented like CP292(Korean).

**Limitations**

### EUC
> Extended Unix Code

(Made for this, by this organization)

Korean developers would be familiar with EUC-KR encoding when using remote server.

**Limitations**

### ANSI (Not A Fixed Standard)

(ANSI is made for this)

ANSI does not indicate a single standard. What people refers to ANSI is usually (these ones)

(These standards look like this) 

### Limitation of Multi-Table Apporachs

Limitations

## Unicode
> Map All the Languages on a Single Table

How characters are encoded

- Unlimited incremetal mapping, added in order of appearence.
- Each language is range sequentially (i.e. English is 61-7A and Korean is AC00-D7A3).
- It includes emojis and even fictional languages like (startrek thing). Unicode is expanding every update, as it’s team accepts proposals.

### Needs For Larger Encoding

As UNICODE invented.

### Fixed Length Encoding

#### UCS-2

#### UTF-32

### Variable Length Encoding

#### UTF-16

#### UTF-8

----

## Common Compatibility Issues And Environment Setup

### Hangul Encoding

#### UTF-8 vs EUC-KR vs CP949

#### When to Use Which

### Between Shells

>  Related Article : [Different Kind of Shells, Login Shell and Interactive Shell](./difference-between-login-shell-and-non-login-shell)

##### Login Shells

**???** Login shells will read your environment variables. You can configure character encoding with environment variable `LANG`, like `export LANG=en\_US.UTF-8`

##### Non-Login Shells



### Proxy Servers

configure it to UTF-8

#### nginx config

```nginx
# /path/to/nginx.conf

```

#### apache config

```apache
# /path/to/apache.conf

```

### Client Side Locale

Don’t forget encoding attribute.

Check client’s encoding when talking to client’s machine directly through streams, like reading file.

### Create And Read Files

File itself can be encoded in various ways.

So check file’s encoding before taking operations.
```bash

```

### Operating Systems and Runtimes
- Windows until 8 : 
- Windows from 9 : 
- Mac and Unix-Like Systems : 
- Android
- IOS

---

> **Reviews**
> 
> - last reviewed : 2021-11-24
> 
> **Related Versions**
> 
> - Unicode : 14.0.0
> - ECMAScript : 12th edition
> 
> **References**
> 
> * [Primary Reference (blog)][1]
> * ASCII
> * Code PAge
> * EUC
> * ANSI
> * Unicode
> * [utf-16][2] , [Endians and Byte Order Mark][3]
> * [UTF-8]()
> * Hangul
>   * [CP949]()
>   * [Unified Hangul Enoding]()
> * [Comparison]()
> * Web Compatibility