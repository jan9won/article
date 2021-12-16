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

## ☑️ Needs for More Languages

### Code Page and ANSI
> Map each language in separate table.

#### ☑️ Code Page

Made by microsoft. Each language is mapped on separate "Code Page" represented like CP292(Korean).

**Limitations**

#### ANSI is Not A Fixed Standard Name

What people referres to ANSI are these Code Pages in most cases.

- Code Page 1252 of Microsoft Windows (alias : windows-1252)
- Code page 437 of IBM PC

### ☑️ EUC
> Extended Unix Code

(Made for this, by this organization)

Korean developers would be familiar with EUC-KR encoding when using remote server.

**Limitations

### ☑️ Limitation of Multi-Table Apporachs

Limitations

### ☑️ Unicode
> Map All the Languages on a Single Table

How characters are encoded

- Unlimited incremetal mapping, added in order of appearence.
- Each language is range sequentially (i.e. English is 61-7A and Korean is AC00-D7A3).
- It includes emojis and even fictional languages like (startrek thing). Unicode is expanding every update, as it’s team accepts proposals.

## ☑️ Unicode Encodings 

Encodings were quite linear and plain before Unicode.

But since Unicode was invented, 

### Fixed Length Encoding

#### ☑️ UCS-2

#### ☑️ UTF-32

### Variable Length Encoding

#### ☑️ UTF-16

#### ☑️ UTF-8

----

## Common Compatibility Issues And Environment Setup

### Hangul Encoding

#### ☑️ UTF-8 vs EUC-KR vs CP949

#### ☑️ When to Use Which

### ☑️ Between Shells

>  Related Article : [Different Kind of Shells, Login Shell and Interactive Shell](./difference-between-login-shell-and-non-login-shell)

##### Login Shells

**???** Login shells will read your environment variables. You can configure character encoding with environment variable `LANG`, like `export LANG=en\_US.UTF-8`

##### Non-Login Shells



### HTTP Servers

Most applications use UTF-8 as default these days.

So you can confidently set default encoding to UTF-8.

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

### ☑️ Cheking Client Machine's Encoding

On HTML file, don’t forget encoding attribute.

You can also check client’s encoding when talking to client’s machine directly through streams, like reading file.

Operating systems' encodings.

- Windows until 8
- Windows from 9
- Mac and Unix-Like Systems
- Android
- IOS

### ☑️ Runtime Environments

- C family
- Javascript
- Python
- Rust
- Go

### ☑️ Read and Write Files

File itself can be encoded in various ways.

So check file’s encoding before taking operations.
```bash

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
> * [Primary Reference (blog)][1]
> * [ASCII](https://en.wikipedia.org/wiki/ASCII)
> * [Code Page](https://en.wikipedia.org/wiki/Code_page) and [ANSI](https://en.wikipedia.org/wiki/ANSI_character_set)
> * [EUC](https://en.wikipedia.org/wiki/Extended_Unix_Code)
> * Unicode
> * [utf-16][2] , [Endians and Byte Order Mark][3]
> * [UTF-8]()
> * Hangul
>   * [CP949]()
>   * [Unified Hangul Enoding]()
> * [Comparison]()
> * Web Compatibility