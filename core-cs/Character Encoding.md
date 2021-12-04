# Character Encoding

Character encoding basics for beginners.

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

---- 

## How To Map Character Codes To A Table

### Map Necessary English Characters Into A Single Table

#### Short History (from wikipedia)

> Concept of encoding character into serialized data started from the invention of telegraph.

* Optical Telegraph Codes
* Electrical Telegraph Codes
* Automatic Telegraph Codes
	* This one actually included control characters

#### ASCII

>  Improved telegraph code set for computational use.

1. It includes Control Characters, which are characters used for computational uses like space, delete and network protocol idicators.
2. All the characters on your keyboard is included. This added lower cased characters and special characters. 

### Map More Languages In Separate Tables

#### Code Page

by microsoft
each language is mapped on separate pages

#### EUC (Extended Unix Code)

(Made for this, by this organization)

Korean devs will be familiar to EUC-KR encoding when using remote server 

#### ANSI Is Not A Fixed Standard

(ANSI is made for this)

ANSI does not indicate a single standard. What people refers to ANSI is usually (these ones)

(These standards look like this) 

#### Limitation of Multiple-Table Apporach

### Unicode, Map All the Languages on a Single Table

How It Looks Like

- Unlimited incremetal mapping, added in order of appearence.
- Each language is range sequentially (i.e. English is 61-7A and Korean is AC00-D7A3).
- It includes emojis and even fictional languages like (startrek thing). Unicode is expanding every update, as it’s team accepts proposals.

### Needs For Encoding

Length of character

#### Fixed Length Encoding

##### UCS-2

##### UTF-32

#### Variable Length Encoding

##### UTF-16

##### UTF-8

---- 

## More About Common Compatibility Issues And Environment Setups

### More About Hangul Encoding

UTF-8 vs EUC-KR vs CP949

Which Encoding For What Use

### Between Shells

you can ensure character encoding by setting environment variable `LANG` 

export LANG=en\_US.UTF-8

### Servers (Nginx and Apache)

configure it to UTF-8

nginx config
```nginx

```

apache config
```apache

```

### Your Web-App and Client’s Operating System

Don’t forget encoding attribute.

Check client’s encoding when talking to client’s machine directly through streams, like reading file.

### Files and Filesystem

File itself can be encoded in various ways.

So check file’s encoding before taking operations.
```bash

```

Common system encodings
- Windows until 8 : 
- Windows from 9 : 
- Mac and Unix-Like Systems : 
- Android
- IOS

[1]:	https://www.joelonsoftware.com/2003/10/08/the-absolute-minimum-every-software-developer-absolutely-positively-must-know-about-unicode-and-character-sets-no-excuses/
[2]:	https://en.wikipedia.org/wiki/UTF-16
[3]:	https://docs.microsoft.com/en-us/globalization/encoding/byte-order-mark
