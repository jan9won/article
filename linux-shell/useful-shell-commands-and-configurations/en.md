☑️ sign means I'm still writing

{{TOC}}

[TOC]

---

## terminal, shell and console

Differences of these concepts are insignificant for modern computer users, but here are short descriptions.

### shell

> (unix term) A command-line interpreter.

A user interface which actually processes your commands and returns output. The most common shell in modern linux system is `bash`. 

It manages foreground and background processes, command history and command line editing.

There are many kinds of shells. [See the article : Differences between login, non-login, interactive and non-interactive shell.](./differences-between-login-non-login-interactive-and-non-interactive-shell)

### terminal

> (traditionally) A physical "text input/output device", like monitor and keyboard.

Back in the days, it was a physical device including monitor and keyboard.

More historically, it was a punch card for input and printer for output.

In current unix-like system, it's a wrapper program that runs a shell. It's also called `tty`. You can command `tty` on your shell to see your shell's terminal.

### console

> (traditionally) A special sort of terminal, which is plugged into a dedicated serial port on a computer for a low-level commication with OS.

Originally, console meant a terminal device that is physically plugged into a computer. 

Current unix-like systems have virtual console, which is a software implementation of traditional terminal.

It's the primary user interface for OS. 

### summary

```sh
terminal (remote or local, multiple, user interface)
-> shell (local, multiple)
-> console (local, single and initial) 
```





---

## Shell Scripts vs Other Scripting Languages

### Shell Scripts are Portable : Ubiquity and Independence

**Shell scripts are very ubiquitous to all systems.** 

OSs use shell scripts internally, from running daemons at startup, to running apps by clicking app icons.

Popular mobile OSs like iOS and Android are also UNIX-like so they also use POSIX compatible shells internally.

**Shells don't require any 3rd-party dependencies to run.** 

They are are glued tightly into the operating systems.

And you don't have to worry about all the system requirements and dependency updates that modern high-level scripting languages like Python comes with. 

**It's more bulletproof with passing time.** 

I'm very sure that you're shell script will run in every environment after 10 years. My first (nasty) `.bash_profile` script from 2014 can still run on every machine I use. 

But, some python2 scripts I downloaded won't run in my python3 because of outdated dependencies. And Java8 modules I wrote in 2016 won't mingle well with Java 11 today.

### Downsides

**Downsides of Shell scripts**

Lack of modern language features. Even very common internal objects like string don't exist. It doesn't even have 2-d arrays.

You can do basically everything what your OS offers, but at the same time, without proper high level language, you'll not be able to do any practical thing.

**Downsides of Modern high-level scripting languages**

Languages don't support every shell commands as an internal API. So in many cases, you will have to spawn a shell as another process, and talk to it with streams. Python has `subprocess.call()` and Nodejs has `child_process.exec()` to do this. 

But if you don't write a proper shell script for multiple chained commands, and try to chain commands them with multiple subprocesses, your code will get unmaintainable, very quickly.

#### Downsides of Both

If you want more performance, more direct/intuitive access to memory, and decent maintainability, you should be using other languages like C family or Rust. But they can be too much for simple jobs.

### Use right tools for right purposes

**Not overusing shell scripts**

Good signals of overusing shell script is when you're struggling to find a good answer on the internet, and bombarded with thousands of different snippets solutions.

So if you feel like your bash script is getting complex and unreadable, you should definately consider using other modern scripting languages like Python or Ruby.

**Comibine multiple languages for each purposes** 

Personally, if a (readable) shell script goes over 100 lines, I break it down into smaller scripts that has simple functionality, and execute them through high-level scripting languages.





---

## What are Interactive, Login Shells?

> **interactive** : does it interact with terminal?

> **login** : does it requires login before executing? 

### interactive shell

shell that directly reads and writes through a user’s terminal

### non-interactive shell

a shell that is not associated with a terminal, like when executing a script

### login shell

the first shell process of a user's shell session

### non-login shell

another shell process that extends of user's existing login shell session.

### Use Cases

- interactive, login
  - When you first login to your interactive session.
- non-interactive, login
  - When shell reads shell configs
  - When you run a command or a script over remote shell.
- interactive, non-login
  - When 
- non-interactive, non-login
  - When shell runs a script or a command, it runs another shell to do it.





---

## `bash`, `sh`, `zsh` and others

### `#!` (shebang)

You can add `#!` (shabang) to the first line of any shell script, to define path to a shell executable script should use.

### `sh`

`sh` is POSIX standard. 

Even most of old OSs are POSIX compatible, like Windows NT by having POSIX subsystem from beginning in 1993. So if you need ultimate portability for every systems, you should use `sh`.

i.e. To distribute an uncompiled, yet cross-platform CLI app, without requiring any system requirements, you'll need to use `sh`.

Though on a system side it's very compatible, on a language side it's only fully compatible with `bash`. Other popular ones like `zsh` or `fish` are partly compatible. So you should always add `#!/bin/sh`.

### `bash`

`sh` commands can be quite cryptic when you're dealing with more complicated tasks like complexed comparison or iterations. `bash` has more features to simplify them. 

`bash` is considered a standard shell for the majority of the development community. And you don't really have to worry about its compatibility for the most of time. 

Here are some concerns on `bash` or any shell's compatibility.

1. **Using the latest syntaxes when publishing to public**

   Bash is evolving every year and adding more advanced syntaxes every update. It's just like using the lastest ECMAScript. You don't want to migrate to ECMA2021 before majority of people update their environments (in this case, the browsers). 

   So if you're publishing it without any system requirement checks, you should avoid using `bash`'s new and experimental commands.

   Or you can always require developers to check system requirements and install latest `bash` before running your script.

2. **Containerized environment**

   If you're using your script in the containerized environment, you can use whatever shell you want and just add it to your container's image. 

### `zsh`

`zsh` is the default shell for OSX terminal app. Syntax is similar to `bash` but there are many incompatibilities. You'll be get used to it if you're using OSX.

Its binary is under `/bin/zsh`.

You can always change to `bash` using `chsh -s /bin/bash` command. And update `bash` with `brew install bash`

### `fish` and others

There are many different shells out there with many different features. `fish` has been quite a trend for people looking for more interactive and visually intuitive shell. It's a can run on Unix-like systems.





---

## ☑️ Auth

### Why worry about having many users?

Back in the days, most computers were owned by organizations like universites, and many users did i/o on a single machine through terminals like puchcard and printer. So systems needed a safe and efficient user auth management system.

We can also have many users on one machine today. Like desktops used by many family members, and servers maintained by many admins.

### ☑️ Authentication

#### ☑️ ssh

ssh key generation (local)

```sh

```

ssh key allowance (remote)

```sh

```

.ssh/config file

```sj
```

ssh daemon configuration

```sh
# mac
vim sshd_config

# linux

# edite these lines 
port
password authentication false
```

ssh daemon restart after configuration

```bash
# mac
sudo launchctl unload /System/Library/LaunchDaemons/ssh.plist
sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist

# linux with 

```

#### ☑️ firewall

- 

#### ☑️ fail2ban

- ban authentication attempt of the IP address that failed too many times

#### `last`

- This command prints shell login records on current console.
- Personally, I pretty-print `last` outputs like this, every shell login to check any unused shells alive on the machine. 

```sh
lastLogin=$(last | grep -wv 'still' | head -n 3 | sed -E 's/\([0-9]*\:[0-9]*\)//g; s/ttys[0-9]*//g; s/ - / /g; s/ logged in//g; s/  */ /g; s/^/██ /' )

stillLogin=$(last | grep 'still' | sed -E 's/\([0-9]*\:[0-9]*\)//g; s/ttys[0-9]*//g; s/ - / /g; s/ logged in//g; s/  */ /g; s/^/██ /' )
```

### Permission

#### Permission Commands

##### `chmod <permission> <file>`

- Change file access permissions

##### `chown <owner[:group]> <file>`

- Change ownership of the file

##### `chgrp <group> <file>`

- Change user group of the file

##### `umask <permission>`

- Configure file access for all the files to be created afterwards
- without argument, it print current configuration

#### Show Permission Infos

##### `ls -l`

- print long list of stats

i.e. in Ubuntu, `drwxr-xr-x 3 root root 4096 Dec 15 11:41 testing`

i.e. in Mac OSX  `drwxr-xr-x@ 20 jangwonsuh staff  640 Dec 15 10:44 testing`

- `@` (at sign) is only in OSX
- it stands for "extended attributes" including extra data like
  - author name
  - file character encoding
  - short comments
  - security status
- you can `ls -l -@` to see extended attributes
- those attributes are key value pairs named like `com.apple.FinderInfo` (reverse DNS naming)

#### `chmod` File Permission Codes

##### Write with Symbolic Mode

​	parties

- `o` owner
- `u` user
- `g` group
- `a` all

​	permissions

- `r` read
- `w` write
- `x` execute

​	commands

- `+` add described permissions
- `-` remove described permissions
- `=` assign described permissions

​	example

```sh
chmod o+wx <file> # to owner, add permission, to write/execute
chmod u-x <file> # to user, remove permission, to execute
chmod g = rx <file> # to group, assign permission, to read/execute
```

##### Write with Absolute Mode

`<Octal><Octal><Octal>` format is used and each Octal Represents.

- first `<Octal>` : Owner permissions
- second `<Octal>` : Group permissions
- third `<Octal>` : Other permissions

Each octal characters are assigned to following permissions  

0. `---`
1. `--x`
2. `-w-`
3. `-wx`
4. `r--`
5. `r-x`
6. `rw-`
7. `rwx`

##### Frequently Used File Permissions

- `700` `rwx------` : All permissions to owner, no permission to others
- `755` `rwxr-xr-x` : All permissions to owner, read and execute for others

#### `umask` Permission Codes

Umask's octal permission codes are different from others.

Also, `umask` can configure directory level permissions, and it has different meaning.

The **symbolic writing mode rules are same** so you can learn only once.

##### `umask` File / Directory Permissions

0. `rw-` / `rwx`
1. `rw-` / `rw-` 
2. `r--` / `r-x`
3. `r--` / `r--`
4. `-w-` / `-wx`
5. `-w-` / `-w-`
6. `--x` / `--x`
7. `---` / `---`

##### Frequently Used `umask` Permissions

- The default permission for user is `022`
- You'll see four digits (like `0022`) if you are root.
- The first digit is for special permissions. 
  - `1` SUID
    - (file) Run program as owner
  - `2` SGID
    - (file) Assign authority to run program as owner
    - (directory) Inherit group ownership of all of the item beneath
  - `3` Sticky Bit
    - (directory) Only owner of the file can delete the file in this directory





---

## I/O

### printing

#### `echo`

- sends `newline` as a last character
- it can work differently on different systems
- no more formatting abilities that just printing

#### `printf`

- sends `EOF` as a last character, no `newline` so you should add it if it's needed
- works same on every system (more portable)
- allows much better formatting, it's based on C's `printf` function so usage of `%` signs are the same

### standard i/o

#### `stdout`

a default place for output to go

#### `stdin`

a default place for input to go

#### `stderr`

a default place for error output to go

### redirecting output to files

#### `>`

overwrite

#### `>>`

append

#### `>&1`

Redirect **stdout** to **stdout**

#### `>&2`

Redirect **stdout** to **stderr**

#### `2>&1`

Redirect **stderr** to **stdout** 

#### `&>`

Redirect both **stdout** and **stderr** to the file 

#### `zsh`'s MULTIOS option

[source](https://thoughtbot.com/blog/input-output-redirection-in-the-shell#zsh-users-take-note)

```sh
# ZSH with MULTIOS option on
$ echo "hello there" >&1 | sed "s/hello/hi/"
hi there
hi there
# turned off
unsetopt MULTIOS
$ echo "hello there" >&2 | sed "s/hello/hi/"
hello there
hi there
```

### piping

#### `|` (pipeline operator)

connect the standard output of one command to the standard input of another

#### `xargs`

execute command for each arguments passed through pipe

```sh
touch keyword_file1 keyword_file2 keyword_file3 file4 file5

find . -name "keyword*" | xargs rm

ls 
# result is, file4 file5
```





------

## Files

### File Listing and Stats

#### `du -sh` file size

check size for individual files or directories

- `-s` is for simplification (w/o full path strings)
- `-h` is human-readable
- if <?path> is empty it displays current directory

#### `ls`

- `-l` show long stats
- `-a` show all hidden files
- I use `alias la='ls -a'` for shorthand

### `find`

`find <path> <options> '<pattern>'`

- match all files recursively starting from specified directory

- you can use regex for matching by `-regex` option

- you can specify type of file (not extentsion) by `-type <filetype>`

- ```
  b      block (buffered) special
  
  c      character (unbuffered) special
  
  d      directory
  
  p      named pipe (FIFO)
  
  f      regular file
       
  l      symbolic link; this is never true if the -L option
         or the -follow option is in effect, unless the
         symbolic link is broken.  If you want to search for
         symbolic links when -L is in effect, use -xtype.
  
  s      socket
  
  D      door (Solaris)
  ```

### Reading Files

#### `cat`

- concat multiple files

#### `more`

- interactive reader, only go forward

#### `less`

- interactive reader, may other features

#### `top`

- read from first line

#### `tail`

- read from last line





---

## Arguments

Command line arguments are the strings following your command.

`command <...arguments>`

### Reading Arguments

#### `$0` 

- name of the currently running process
- if you write `echo $0` in ./yourscript.sh and run with shell, you'll get `./yourscript.sh`
- if you run `echo $0` in terminal directly, you'll get your current shell's name followed by minus character, like `-zsh`

#### `$<positive integer>`

- The arguments passed to the script will be variables in order

#### `$#` 

- The number of arguments supplied to the script

#### `$* `

- Stores all arguments

#### `$@`

- Stores all arguments, individually quoted with `""`

#### `$?`

- find the return value of the last executed command

### Parsing Arguments

#### Check if Empty

```sh
if [[ $# -eq 0 ]]; then
    echo "No arguments provided"
    exit 1
fi
```

#### Parse Option Flags (while and shift)

```sh
while [[ $# > 1 ]]
do
	case "$1" in	
	
		-o|--option) # in case of option without argument
    	<do something with $2>
    	shift 1
      ;;
      
		-a|--argumentoption) # in case of option with following argument
      if [ -n "$2" ] && [ ${2:0:1} != "-" ];
      then
        <do something with $2>
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      ;;
      
    -*|--*) # in case of unsupported flags
      echo "Error: Unsupported flag: $1" >&2
      exit 1
      ;;
      
    *) # final fallback
      echo "Error: Bad argument: $1" >&2
      exit 1
      ;;
	esac
done
```





---

## Variables

### Assignment

```bash
hello="world"
echo "$hello"
# outputs, world
```

### Inline Assignment with `read`

```sh
echo foo | read bar
```

### Array Assignment

```sh
arr_1[0]="A"
arr_1[1]="B"
arr_1[2]="C"

# in one line
arr_2=("A" "B" "C")

```

### Split String into Array

see [Split String into Array with IFS](#split-string-into-array-with-ifs)





------

## Flow Controls

### `if`

#### Baisc Syntax

`if` and `brackets` must be spaced.

```sh
if [[ <condition> ]]; 
	then 
		<commands on true condition>
	else 
  	<commands on false condition>
fi
```

#### Double brackets `[[]]` for `bash`.

[source](https://stackoverflow.com/a/47576482/13287692)

In `bash`, you have more features like expanding variables with `[[]]` 

`[]` is POSIX standard, and can't do what `[[]]` can do.

If you have to worry about `bash`'s compatibility, you should go with POSIX standards. But in most containerized productions envionments, using bash will be no problem.

```sh
[[ "$string" == *"keyword"* ]]
[[ $string =~ "keyword" ]]
```

#### Integer Comparison Operators

Integer comparison more than `==` `!=`, can be achieved with flags below.

```sh
-eq # Equal
-ne # Not equal
-lt # Less than
-le # Less than or equal
-gt # Greater than
-ge # Greater than or equal
```

### `for` with array

```bash
#!/bin/bash

arr=("A" "B" "C")

for i in ${arr[@]};do

	echo "$i"

done

# it will print,
#
# A
# B
# C
```

### `for` with `seq`

`seq` is similar to python's `range()` internal method. You can create array ranged array with it. And it can also add custom delimiter between them.

```bash
for i in ${seq -s " " 3);do

	echo "$i"

done
```

### `for` in bash

In bash, you can use indexed iteration like other languages.

```shell
#!/bin/bash

for (( i = 1 ; i <= 10 ; i++ ))
do
	echo ${i}
done
```

### `case` with `while`

```sh
while <array>;
do
	case in <array element>
		<condition>|...|<condition>)
			<do something>
		;;
	esac
done
```





------

## Process Management

### Listing Processes

#### `ps`

**return currently-running process' status**

- `-a` : all processes (not only this users process)
- `-x` : include process out of this shell's scope (like daemons)
- `-u` : group processes by user

#### `top`

**realtime, interactive view for currently-running processes**

- btop / htop (ones with better interactivity)

### Manipulating Processes

#### `kill <process id>`

- kill process

#### `sleep <seconds as integer>`

- sleep execution of current shell

### Process Exit Codes

The exit status of the executed command line is represented with a 8bit integer.

Following are the most common reserved exit codes.

- `0` : command was successful without any errors
- `<1-255>` : command failed
  - `1` : General errors 
  - `2` : Misuse of shell builtins

### Background Processes

> To make background procss properly, use process managers like pm2

#### `^ z` key on keyboard

suspend process

#### `jobs`

show current jobs including bg processes

```sh
jobs

# [1] + Suspended <process>
# [2] + Suspended <process>
```

#### `bg` and `fg`

- push process background or bring process foreground

```sh
bg %1 # push job number 1 to the background
bg %2 # push job number 2 to the background
fg %2 # bring job number 2 to the foreground
```

#### `<commands> &` 

- make a background process of a command

#### `<commands> disown`

- process is removed from the list of jobs in the current interactive shell
- current shell won't send it a `SIGHUP` when exiting
- a POSIX standard

#### `nohup <commands>` [source](https://serverfault.com/questions/34750/is-it-possible-to-detach-a-process-from-its-terminal-or-i-should-have-used-s)

- process ignores `SIGHUP`
- redirects output to `nohup.out`
- not a POSIX standard

#### bandwidth test

**https://phoenixnap.com/kb/linux-network-speed-test#ftoc-heading**





---

## ☑️ Network Protocols

#### ☑️ `ping` 

#### ☑️ `curl`

#### ☑️ `sftp`

#### ☑️ `sshfs`

#### ☑️ `mail`



------

## System Environments

### OS Stats

#### `ps -p $$`

which shell am I using?

#### `which <keyword>`

find executable keyword's source, defined in

- `$PATH` Variable (see more in [this article](how-exactly-environment-variable-work))
- `alias` or `function` defined in shell configuration

#### (linux) `/etc/os-release`

- os release version information is stored here

#### `reboot`

reboot this machine

#### `df -h <?path>`

check disk space

- `-h` is human-readable
- `-H` is for 1000 instead of 1024
- if <?path> is empty it displays whole accessible disks

### Make Routines with `crontab`

### Prevent Device Sleep (for desktops)

I use this for making my old mac book pro into a persistent server

#### (mac) `caffeinate`

#### (linux) `systemd-ihibit`

### Clipboards

#### copy and paste with clipboard

- `xclip -selection clipboard` and `xclip -selection clipboard -o` 
- `pbcopy` and `pbpaste`

#### copy from remote shell

- remote shell will not copy to your local machine's clipboard
- there are some options to do this, but I recommend number 3 for daily use
  1. use `⌘ s` to save your current terminal window's content
     - it'll only copy visible lines in terminal window
  2. copy contents to temporary file and send the file to your local machine 
     - it'll be too much work for frequent use
  3. use `cat`,`head`,`tail` to print the file content on terminal and use mouse to drag over content and use `⌘ c` to copy.

### ☑️ Locale

#### ☑️ Output

```bash
# mac
export LANG=en_US.UTF-8

# centos

# ubuntu

```

- **centos7 (https://thefif19wlsvy.tistory.com/245)**
- **ubuntu (https://pragp.tistory.com/entry/Docker-한글-설정하기)**

#### ☑️ Input

```sh
# mac

# centos

# ubuntu
```

- **centos7**
- **ubuntu (https://donghak-dev.tistory.com/17)**





------

## Some Useful Commands

### Difference Between Many Config Files

`zsh` https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout

☑️ `bash`

### Open app with `alias`

```bash
# open app with aliases
alias my_command='open -a <application or executable> <args>'
alias code='opan -a "Visual Studio Code"'
```

### Backup Automation with `rsync` and `crontab`

```bash
remote_queue=(
	"<user-name>@<server-ip>:/Path/Target/Backup"
	# "root@143.198.236.175:/backup/"
)
local_queue=(
	"/Path/Source/Backup/1"
	"/Path/Source/Backup/2"
	"/Path/Source/Backup/3"
)

backup() {
	for remote in "${remote_queue[@]}"
	do
		for local in "${local_queue[@]}"
		do
			echo "\\n\\n\\n $local to $remote\\n"
			rsync -avhPe "ssh -i /path/to/ssh/pvt/key -p <port>" $local $remote --exclude=".DS_Store" --exclude='\\*.log' --exclude="other things to exclude" --delete
		done
	done
}
```

### Register SSH Agent On Shell Login

```bash
sshagent() {
	[ -z "$SSH_AUTH_SOCK" ]
	eval "$(ssh-agent -s)"
	eval "$(ssh-add ~/.ssh/mbp13)"
}
```





---

## ☑️ String Matching and Manipulation



==***WARNING***==

> As I mentioned [earlier](#when-and-when-not-to-use-shell-scripts), complex string manipulation in shell script can be very challenging and unecessary. 
>
> You should stop at the point when you have the ***raw data*** you want. And should only chain your output further when you need to run another command in pipe.
>
> If you're chaining multiple commands to just achieve things that a single javascript method like `String.prototype.includes()` can achieve, you're using a wrong tool.
>
> `grep` and `sed` would be enough for most cases.

***==But==***

> If you're maintaining a legacy code without proper documentation, you should be able to at least read what they're doing. So I wrote commands in order that I think it's frequently used.

### Matching with `grep`

`grep <options> <string>`

​	common options

- `-E, --extended-regexp` : use extended regular expression (same as egrep)
- `-o, --only-matching` : print only the matched (non-empty) parts of a matching line
- `-n, --line-number` : prefix each match with line number
- `-w, --word-regexp` : only match beginning or end of a 'word' (preceded or followed by non-word characters : Letters, Digits, Uderscores) 
- `-v, --invert-match` : works as 'not' operator
- `-i, --ignore-case` : case insensitive match
- `-c, --count` : print count of matching lines

### ☑️ Replacing with `sed`

` sed <options> <rules as string>`

https://thoughtbot.com/blog/sed-102-replace-in-place

-  `-r`

   - -regexp-extended (know that regex rules are still different from other language's builtins)
     - matches like `\\d` or `\\s` don't work, use `[0-9]` or `[ ]` instead
     - `+` doesn't work, use `\*`

- `-E` 

- Multiple Expressions with `;` as delimiter

  ```sh
  sed -r "s/.../.../g;s/.../.../g"
  ```

- See Common Regex Rules in [This Article](useful-regex-rules)

### ☑️ `tr`

### ☑️ `cut`

### Splitting with `IFS`

`IFS` is "internal field separator". 

Its defaulted to **space | tab | newline**. 

When you assign or  string, it will internally split them with IFS value.

in `read` command, `-r` option is for , and `-a` option makes it into an array.

```shell
mystring="a b c,d e"
read -ra myarray <<< $mystring"

for substring in $myarray;
do
	echo $substring
done

# result

# a
# b
# c,d
# e
```

When you set it to different character, strings will be splitted with it. 

You can also set multiple IFS at once.

```shell
IFS=","
mystring="a b c,d e"
for substring in $mystring;
do
	echo $substring
done

# result

# a b c
# d e
```

### ☑️ `awk` for More

`awk` is a whole other scripting language that you can use inside `bash` command inline. Sytaxes are quite mouthful to memorise, so I'll take some necessary operations.

```
awk <options> '<selection> <_criteria> <{action}>' input-file > output-file
```

`FS`,` OFS`

`RS`

`ORS`

`NR`

`NF`

`FILENAME`

`FNR`

### Example Usecase

Bash string manipulation is useful when you're trying to parse CLI inputs from user, and then pipe it into another command

i.e. You can enforce git branch naming rules by putting this function in git's `update` hook script.

```bash
escape(){
	printf "$1\n" |
	tr '[:upper:]' '[:lower:]' |
	sed -E 's/[^a-zA-Z0-9\/]/-/g' |
    sed -E 's/-*\//\//g; s/\/-*/\//g' |
	sed -E 's/--*/-/g' |
	sed -E 's/^-//g; s/-$//g'
}
```

What it does is, to make all characters lowercase, and separate each word with hyphen.

You can always chain sed commands with semicolon `;` line `6`, but piping has better readability.

1. `printf "$1\n"` print the first argument of the function
2. `tr '[:upper:]' '[:lower:]' ` make whole string uppercase
3. `sed -E 's/[^a-zA-Z0-9\/]/-/g'` replace all non-alphanumeric and non-slash (`/`) characters into minus sign (`-`).
4. `sed -E 's/-*\//\//g; s/\/-*/\//g' ` remove `-` around `/`
5. `sed -E 's/--*/-/g'` replace two or more `-` into a single one.
6. `sed -E 's/^-//g; s/-$//g'` if there's a preceding or trailing `-`, remove it.

So example result will be like this.

```shell
escape 'feature / article "Useful shell Commands" / Add the `sed` section'

# will print,
# feature/article-useful-shell-commands/add-the-sed-section
```

And you can pipe this new string to procede git branch update.

```shell
escape 'old string' | 
# <do something wit git command>
```





------

> **Reviews**
>
> last reviewed : 2021-12-21
>
> reviewed by : Jangwon Suh

> **Related Versions**
>
> - bash 5.x.x
> - zsh 5.x.x

> **References**
>
> (There's so many references from StackOverflow, so I omitted them. Thank you for all the StackOverflow community)
>
> - [grep](https://www.gnu.org/software/grep/manual/grep.html)
>
> - [grep summary](https://www.computerhope.com/unix/ugrep.htm)
>
> - [bash](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html)
> - [login and interactive shells](https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell)