{{TOC}}

[TOC]

☑️ sign means I'm still working on.

> I'm mainly use shell command on building React/React Native apps and its ci/cd pipelines, with a few backend stacks.

> So I'll try not to be verbouse and to write mainly important shell commands for frontend + ci/cd usecases.





# Introduction

## terminal, shell and console

Differences of these concepts are insignificant for modern computer users, but here are short descriptions.

### shell

> (unix term) A command-line interpreter.

- A user interface which actually processes your commands and returns output. The most common shell in modern linux system is `bash`. 

- It manages foreground and background processes, command history and command line editing.

- There are many kinds of shells. [See the article : Differences between login, non-login, interactive and non-interactive shell.](./differences-between-login-non-login-interactive-and-non-interactive-shell)

### terminal

> (traditionally) A physical "text input/output device", like monitor and keyboard.

- Back in the days, it was a physical device including monitor and keyboard.

- More historically, it was a punch card for input and printer for output.

- In current unix-like system, it's a wrapper program that runs a shell. It's also called `tty`. You can command `tty` on your shell to see your shell's terminal.

### console

> (traditionally) A special sort of terminal, which is plugged into a dedicated serial port on a computer for a low-level commication with OS.

- Originally, console meant a terminal device that is physically plugged into a computer. 

- Current unix-like systems have virtual console, which is a software implementation of traditional terminal.

- It's the primary user interface for OS. 

### pipeline summary

```sh
terminal (remote or local, multiple, user interface)
-> shell (local, multiple)
-> console (local, single and initial) 
```





---

## Shell Scripts vs Other Scripting Languages

### Shell Scripts are Portable : Ubiquity and Independence

#### Shell scripts are very ubiquitous to all systems. 

- OSs use shell scripts internally, from running daemons at startup, to running apps by clicking app icons.

- Popular mobile OSs like iOS and Android are also UNIX-like so they also use POSIX compatible shells internally.

#### Shells don't require any 3rd-party dependencies to run. 

- They are are glued tightly into the operating systems.

- And you don't have to worry about all the system requirements and dependency updates that modern high-level scripting languages like Python comes with. 

#### It's more bulletproof with passing time. 

- I'm very sure that you're shell script will run in every environment after 10 years. My first (nasty) `.bash_profile` script from 2014 can still run on every machine I use. 

- But, some python2 scripts I downloaded won't run in my python3 because of outdated dependencies. And Java8 modules I wrote in 2016 won't mingle well with Java 11 today.

### Downsides

#### Downsides of Shell scripts

- Lack of modern language features. Even very common internal objects like string don't exist. It doesn't even have 2-d arrays.

- You can do basically everything what your OS offers, but at the same time, without proper high level language, you'll not be able to do any practical thing.

#### Downsides of NOT Using scripting languages

- Languages don't support every shell commands as an internal API. So in many cases, you will have to spawn a shell as another process, and talk to it with streams. Python has `subprocess.call()` and Nodejs has `child_process.exec()` to do this. 

- But if you don't write a proper shell script for multiple chained commands, and try to chain commands them with multiple subprocesses, your code will get unmaintainable, very quickly.

#### Downsides of Both

- If you want more performance, more direct/intuitive access to memory, and decent maintainability, you should be using other languages like C family or Rust. But they can be too much for simple jobs.

### Use right tools for right purposes

#### Not overusing shell scripts

- Good signals of overusing shell script is when you're struggling to find a good answer on the internet, and bombarded with thousands of different snippets solutions.

- So if you feel like your bash script is getting complex and unreadable, you should definately consider using other modern scripting languages like Python or Ruby.

#### Comibining languages

- Personally, if a (readable) shell script goes over 100 lines, I break it down into smaller scripts that has simple functionality, and execute them through high-level scripting languages.





---

## What are Interactive, Login Shells?

### TL;DR

- **interactive** : does it interact with the terminal?

- **login** : does it require login for execution? 

### Each Shell

#### interactive shell

- shell that directly reads and writes through a user’s terminal

#### non-interactive shell

- a shell that is not associated with a terminal, like when executing a script

#### login shell

- the first shell process of a user's shell session

#### non-login shell

- another shell process that extends of user's existing login shell session.

### Use Cases

#### interactive, login

- When you first login to your interactive session.

#### non-interactive, login

- When shell reads shell configs
- When you run a command or a script over remote shell.

#### interactive, non-login

- When 

#### non-interactive, non-login

- When shell runs a script or a command, it runs another shell to do it.





---

## `bash`, `sh`, `zsh` and others

### `#!` (shebang)

- You can add `#!` (shabang) to the first line of any shell script, to define path to a shell executable script should use.

### `sh`

- `sh` is POSIX standard. 
- Even most of old OSs are POSIX compatible, like Windows NT by having POSIX subsystem from beginning in 1993. So if you need ultimate portability for every legacy systems, you should use POSIX standard.
- Syntax is fully compatible with `bash`. But other popular ones like `zsh` or `fish` are partly compatible. 

### `bash`

- `sh` commands can be quite cryptic when you're dealing with more complicated tasks like complexed comparison or iterations. `bash` has more features to simplify them. 

- `bash` is considered a standard shell for the majority of the development community. And you don't really have to worry about its compatibility for the most of time. 

- Here are some concerns on `bash` or any shell's compatibility.

  1. **Using the latest syntaxes when publishing to public**

     - Bash is evolving every year and adding more advanced syntaxes every update. It's just like using the lastest ECMAScript. You don't want to migrate to ECMA2021 before majority of people update their environments (in this case, the browsers). 

     - So if you're publishing it without any system requirement checks, you should avoid using `bash`'s new and experimental commands.

     - Or you can always require developers to check system requirements and install latest `bash` before running your script.

  2. **Containerized environment**
     - If you're using your script in the containerized environment, you can use whatever shell you want and just add it to your container's image. 

### `zsh`

- `zsh` is the default shell for OSX terminal app. Syntax is similar to `bash` but there are many incompatibilities. You'll be get used to it if you're using OSX.

### `fish` and others

- There are many different shells out there with many different features. `fish` has been quite a trend for people looking for more interactive and visually intuitive shell. It's a can run on Unix-like systems.



## Difference Between Many Config Files

- `bash` 
  - `~/.bash_profile` is for login shells
    - `~/.bash_login` will be read it if `~/.bash_profile ` doesn't exist
    - `~/.profile` is for bourne shells, and `bash` will be read it if `~/.bash_profile ` and `~/.bash_login` don't exist
  - `~/.bashrc` is for interactive non-login shells

- `zsh` 
  - [reference](https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout)

## Some Stats and Configs

### `cat /etc/shells`

- print your available shells

### `chsh [user]`

- change shell for user
- it will require input for the shell paths you can get with `cat /etc/shells` above
- or you can run `chsh -s /bin/<shell binary>` command





---

# Auth & Permission

## Why worry about having many users?

- Back in the days, most computers were owned by organizations like universites, and many users did i/o on a single machine through terminals like puchcard and printer. 
- So systems needed to authentical users and give permission to the file on the same disk.

- We can also have many users on one machine today. i.e. desktops can be used by multiple family members, and servers can be maintained by many admins.

## Authentication

### ☑️ ssh

#### ssh key pair generation (local)

```sh

```

#### ssh public key register (remote)

```sh

```

#### .ssh/config file

```sj
```

#### ssh daemon configuration

```sh
# mac
vim sshd_config

# linux

# edite these lines 
port
password authentication false
```

#### restart running ssh daemon after configuration

```bash
# mac
sudo launchctl unload /System/Library/LaunchDaemons/ssh.plist
sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist

# linux with 

```

#### Register SSH Agent On Shell Login

```bash
sshagent() {
	if [ -z "$SSH_AUTH_SOCK" ] then;
		eval "$(ssh-agent -s)"
		eval "$(ssh-add ~/.ssh/mbp13)"
	fi
}
```



## Security

### ☑️ firewall

- 

### ☑️ fail2ban

- ban authentication attempt of the IP address that failed too many times

### `last`

- This command prints shell login records on current console.
- Personally, I pretty-print `last` outputs like this, every shell login to check any unused shells alive on the machine. 

```sh
lastLogin=$(last | grep -wv 'still' | head -n 3 | sed -E 's/\([0-9]*\:[0-9]*\)//g; s/ttys[0-9]*//g; s/ - / /g; s/ logged in//g; s/  */ /g; s/^/██ /' )

stillLogin=$(last | grep 'still' | sed -E 's/\([0-9]*\:[0-9]*\)//g; s/ttys[0-9]*//g; s/ - / /g; s/ logged in//g; s/  */ /g; s/^/██ /' )
```

## Permission

### Edit Permission

#### `chmod <permission> <file>`

- Change file access permissions

#### `chown <owner[:group]> <file>`

- Change ownership of the file

#### `chgrp <group> <file>`

- Change user group of the file

#### `umask <permission>`

- Configure file access for all the files to be created afterwards
- without argument, it print current configuration

### Get Permission Info

#### `ls -l`

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

###  `chmod` Permission Codes

#### Write with Symbolic Mode

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

#### Write with Absolute Mode

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

#### Frequently Used File Permissions

- `700` `rwx------` : All permissions to owner, no permission to others
- `755` `rwxr-xr-x` : All permissions to owner, read and execute for others

### `umask` Permission Codes

- Umask's octal permission codes are different from others.
- `umask` can configure directory level permissions, so it has different meaning.
- The **symbolic writing mode rules are same** so you can use it here.

#### `umask` File / Directory Permissions

0. `rw-` / `rwx`
1. `rw-` / `rw-` 
2. `r--` / `r-x`
3. `r--` / `r--`
4. `-w-` / `-wx`
5. `-w-` / `-w-`
6. `--x` / `--x`
7. `---` / `---`

#### Frequently Used `umask` Permissions

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

# Files & I/O

## basic printing

### `echo`

- sends `newline` as a last character
- it can work differently on different systems
- no more formatting abilities that just printing

### `printf`

- sends `EOF` as a last character, no `newline` so you should add it if it's needed
- works same on every system (more portable)
- allows much better formatting, it's based on C's `printf` function so usage of `%` signs are the same

### `wc`

- "word count" shows different counts of file's content
- options
  - `-c` bytes
  - `-m` characters
  - `-w` words
  - `-l` lines

## standard i/o

### `stdout`

a default place for output to go

### `stdin`

a default place for input to go

### `stderr`

a default place for error output to go

## redirecting output to files

### `>`

overwrite

### `>>`

append

### `>&1`

Redirect **stdout** to **stdout**

### `>&2`

Redirect **stdout** to **stderr**

### `2>&1`

Redirect **stderr** to **stdout** 

### `&>`

Redirect both **stdout** and **stderr** to the file 

### careful of `zsh`'s MULTIOS option

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

## piping

### `|` (pipeline operator)

connect the standard output of one command to the standard input of another

### `xargs`

execute command for each arguments passed through pipe

```sh
touch keyword_file1 keyword_file2 keyword_file3 file4 file5

find . -name "keyword*" | xargs rm

ls 
# result is, file4 file5
```

## File Listing and Stats

### `du -sh` file size

check size for individual files or directories

- `-s` is for simplification (w/o full path strings)
- `-h` is human-readable
- if <?path> is empty it displays current directory

### `ls`

- `-l` show long stats
- `-a` show all hidden files
- I use `alias la='ls -a'` for shorthand

### `lsof`

- find all open files, and stat about processes using that file
- `+D [path_to_dir]` will stat only inside designated directory

### `df -h <?path>`

check size of path, directory will be added recursively

- `-h` is human-readable
- `-H` is for 1000 instead of 1024
- if <?path> is empty it displays whole accessible disks

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

## Reading Files

### `cat`

- concat multiple files

### `more`

- interactive reader, only go forward

### `less`

- interactive reader, may other features

### `top`

- read from first line

### `tail`

- read from last line



## Clipboards

### copy and paste with clipboard

- `xclip -selection clipboard` and `xclip -selection clipboard -o` 
- `pbcopy` and `pbpaste`

### copy from remote shell

- remote shell will not copy to your local machine's clipboard
- there are some options to do this, but I recommend number 3 for daily use
  1. use `⌘ s` to save your current terminal window's content
     - it'll only copy visible lines in terminal window
  2. copy contents to temporary file and send the file to your local machine 
     - it'll be too much work for frequent use
  3. use `cat`,`head`,`tail` to print the file content on terminal and use mouse to drag over content and use `⌘ c` to copy.





---

# Parameters & Variables

Command line arguments are the strings following your command.

`command <...arguments>`

## Parameters

### Positional Parameters

#### `$0`

- name of the currently running process
- if you write `echo $0` in ./yourscript.sh and run with shell, you'll get `./yourscript.sh`
- if you run `echo $0` in terminal directly, you'll get your current shell's name followed by minus character, like `-zsh`

#### `$<positive integer>`

- The arguments passed to the script will be variables in order

####  `$#`

- The number of arguments supplied to the script

#### `$* `

- Stores all arguments

#### `$@`

- Stores all arguments, individually quoted with `""`

### Manipulating Positional Parameters

#### `set`

- does many things 
  - change the values of shell options
  - set the positional parameters
  - display the names and values of shell variables

#### `--`

- double dash

- signify the end of command options

- i.e. `grep` literal `-v`, otherwise it'll be considered as an option of `grep`

  ```bash
  grep -v file		# does not work
  
  grep -- -v file		# greps "-v"
  ```

- i.e. `pm2 ` pass options to command, otherwise it'll be considered as an option of  pm2

  ```bash
  pm2 start http-server ./my-path --port 3000		
  # will try to run both "http-server" and "./my-path" with option --port 3000
  
  pm2 start http-server -- ./my-path --port 3000
  # options are passed to "http-server"
  ```

#### `shift`

- `shift [count]` 
- removes `[count]` number of arguments from the beginning of the `argv`

```bash
myFunction() {
	echo "$1 : $argv"
	shift
	echo "$1 : $argv"
	shift
	echo "$1 : $argv"
}
myFunction 1 2 3	
# 1 : 1 2 3
# 2 : 2 3
# 3 : 3
```

#### Parse Flagged Options with `while` and `shift`

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

### Special Parameters

#### `$?`

- find the return value of the last executed command

#### `$$`

- `PID` of current shell
- `ps -p $$` will print current shell's name 

#### `$!`

- `PID` of last process

#### `$-`

- current **shell's** flags

#### `$_`

- arguments provided to the last **command**

### ☑️ Parameter Expansions

아래 예를 테스트하기 위한 변수: string="abc-efg-123-abc"

| 문자                       | 설명                                                         |
| -------------------------- | ------------------------------------------------------------ |
| ${변수}                    | $변수와 동일하지만 {} 사용해야만 동작하는 것들이 있음(예: echo ${string}) |
| ${변수:위치}               | 위치 다음부터 문자열 추출(예: echo ${string:4})              |
| ${변수:위치:길이}          | 위치 다음부터 지정한 길이 만큼의 문자열 추출(예: echo ${string:4:3}) |
| ${변수:-단어}              | 변수 미선언 혹은 NULL일때 기본값 지정, 위치 매개 변수는 사용 불가(예: echo ${string:-HELLO}) |
| ${변수-단어}               | 변수 미선언시만 기본값 지정, 위치 매개 변수는 사용 불가(예: echo ${string-HELLO}) |
| ${변수:=단어}              | 변수 미선언 혹은 NULL일때 기본값 지정, 위치 매개 변수 사용 가능(예: echo ${string:=HELLO}) |
| ${변수=단어}               | 변수 미선언시만 기본값 지정, 위치 매개 변수 사용 가능(예: echo ${string=HELLO}) |
| ${변수:?단어}              | 변수 미선언 혹은 NULL일때 단어 출력 후 스크립트 종료,(예: echo ${string:?HELLO}) |
| ${변수?단어}               | 변수 미선언시만 단어 출력 후 스크립트 종료(예: echo ${string?HELLO}) |
| ${변수:+단어}              | 변수 선언시만 단어 사용(예: echo ${string:+HELLO})           |
| ${변수+단어}               | 변수 선언 혹은 NULL일때 단어 사용(예: echo ${string+HELLO})  |
| ${#변수}                   | 문자열 길이(예: echo ${#string})                             |
| ${변수#단어}               | 변수의 앞부분부터 짧게 일치한 단어 삭제(예: echo ${string#a*b}) |
| ${변수##단어}              | 변수의 앞부분부터 길게 일치한 단어 삭제(예: echo ${string##a*b}) |
| ${변수%단어}               | 변수의 뒷부분부터 짧게 일치한 단어 삭제(예: echo ${string%b*c}) |
| ${변수%%단어}              | 변수의 뒷부분부터 길게 일치한 단어 삭제(예: echo ${string%%b*c}) |
| ${변수/찾는단어/변경단어}  | 처음 일치한 단어를 변경(예: echo ${string/abc/HELLO})        |
| ${변수//찾는단어/변경단어} | 일치하는 모든 단어를 변경(예: echo ${string//abc/HELLO})     |
| ${변수/#찾는단어/변경단어} | 앞부분이 일치하면 변경(예: echo ${string/#abc/HELLO})        |
| ${변수/%찾는단어/변경단어} | 뒷부분이 일치하면 변경(예: echo ${string/%abc/HELLO})        |
| ${!단어*}, ${!단어@}       | 선언된 변수중에서 단어가 포함된 변수 명 추출(예: echo ${!string*}, echo ${!string@}) |



## ☑️ Reserved Variables

### `which <keyword>`

find executable keyword's source, defined in

- `$PATH` Variable (see more in [this article](how-exactly-environment-variable-work))
- `alias` or `function` defined in shell configuration



| 문자          | 설명                                                         |
| ------------- | ------------------------------------------------------------ |
| HOME          | 사용자의 홈 디렉토리                                         |
| PATH          | 실행 파일을 찾을 경로                                        |
| LANG          | 프로그램 사용시 기본 지원되는 언어                           |
| PWD           | 사용자의 현재 작업중인 디렉토리                              |
| FUNCNAME      | 현재 함수 이름                                               |
| SECONDS       | 스크립트가 실행된 초 단위 시간                               |
| SHLVL         | 쉘 레벨(중첩된 깊이를 나타냄)                                |
| SHELL         | 로그인해서 사용하는 쉘                                       |
| PPID          | 부모 프로세스의 PID                                          |
| BASH          | BASH 실행 파일 경로                                          |
| BASH_ENV      | 스크립트 실행시 BASH 시작 파일을 읽을 위치 변수              |
| BASH_VERSION  | 설치된 BASH 버전                                             |
| BASH_VERSINFO | BASH_VERSINFO[0]~BASH_VERSINFO[5]배열로 상세정보 제공        |
| MAIL          | 메일 보관 경로                                               |
| MAILCHECK     | 메일 확인 시간                                               |
| OSTYPE        | 운영체제 종류                                                |
| TERM          | 로긴 터미널 타입                                             |
| HOSTNAME      | 호스트 이름                                                  |
| HOSTTYPE      | 시스템 하드웨어 종류                                         |
| MACHTYPE      | 머신 종류(HOSTTYPE과 같은 정보지만 조금더 상세하게 표시됨)   |
| LOGNAME       | 로그인 이름                                                  |
| UID           | 사용자 UID                                                   |
| EUID          | su 명령에서 사용하는 사용자의 유효 아이디 값(UID와 EUID 값은 다를 수 있음) |
| USER          | 사용자의 이름                                                |
| USERNAME      | 사용자 이름                                                  |
| GROUPS        | 사용자 그룹(/etc/passwd 값을 출력)                           |
| HISTFILE      | history 파일 경로                                            |
| HISTFILESIZE  | history 파일 크기                                            |
| HISTSIZE      | history 저장되는 개수                                        |
| HISTCONTROL   | 중복되는 명령에 대한 기록 유무                               |
| DISPLAY       | X 디스플레이 이름                                            |
| IFS           | 입력 필드 구분자(기본값:  - 빈칸)                            |
| VISUAL        | VISUAL 편집기 이름                                           |
| EDITOR        | 기본 편집기 이름                                             |
| COLUMNS       | 현재 터미널이나 윈도우 터미널의 컬럼 수                      |
| LINES         | 터미널의 라인 수                                             |
| LS_COLORS     | ls 명령의 색상 관련 옵션                                     |
| PS1           | 기본 프롬프트 변수(기본값: bash\$)                           |
| PS2           | 보조 프롬프트 변수(기본값: >), 명령을 "\"를 사용하여 명령 행을 연장시 사용됨 |
| PS3           | 쉘 스크립트에서 select 사용시 프롬프트 변수(기본값: #?)      |
| PS4           | 쉘 스크립트 디버깅 모드의 프롬프트 변수(기본값: +)           |
| TMOUT         | 0이면 제한이 없으며 time시간 지정시 지정한 시간 이후 로그아웃 |

###  `PATH`

```shell
```



## Variables

### Variable Assignment

Variable and value should ***not be spaced*** 

```bash
foo = "bar"
echo "$foo"		# foo: command not found

foo="bar"
echo "$foo"		# bar
```

### Inline Variable Assignment with `read`

```sh
echo foo | read bar
```



## Arrays

### Array Assignment

```sh
arr_1[0]="A"
arr_1[1]="B"
arr_1[2]="C"

# in one line
arr_2=("A" "B" "C")
```

### Array Assignment with String Split

see [Split String into Array with IFS](#split-string-into-array-with-ifs)

### Reading Array

```shell
#!/bin/bash
arr=("A" "B" "C")

echo $arr 		# A
echo ${arr[0]}  # A

echo ${arr[@]}  # A B C
echo ${arr[*]}  # A B C

echo ${!arr[@]}  # 0 1 2 
echo ${!arr[*]}  # 0 1 2 
```

#### Array in `for`

```shell
#!/bin/bash
arr=("A" "B" "C")

for el in ${arr[@]}; do
	echo $el
done
# A B C
```

```shell
#!/bin/bash
arr=("A" "B" "C")

for idx in ${!arr[@]}; do
	echo $idx
done
# 0 1 2
```

## ☑️ `function`

```bash
myFunction() {
	echo "$1"
	echo "$2"
	echo "$3"
}
myFunction 1 2 3	# 1 2 3
```

```bash
function myFunction() {
	echo "$1"
	shift
	echo "$1"
	shift
	echo "$1"
}
myFunction 1 2 3	# 1 2 3
```

## ☑️ Scopes

### ☑️ `alias`

```bash
# alias will 
alias my_command='open -a <application or executable> <args>'
alias code='opan -a "Visual Studio Code"'
```

### ☑️ `Export`

```bash

```





# Expressions

## Arithmetic Evaluations

### `(( ))`

- arithmatic evaluation

```bash
#!/bin/bash
((a = 1+2))
echo $a		# 3

((b = "1"+"2"))
echo $b		# 3
```

### `()` is not an evaluator

- see [this section](#-12)

### `let`

- shorthand for arithmetic evaluation

```shell
#!/bin/bash
let a=1+2
echo $a			# 3

let b="1"+"2"
echo $b			# 3
```

### `$(( ))`

- it's an arithmetic evaluation and expansion
- ***Returns*** calculated value

```bash
#!/bin/bash
$((1+2)) 			# command not found: 3

echo $((1+2)) 		# 3

a="foo"
b="bar"
c=$(( a += "$b" ))
echo $c				# foobar
```

### String Concat in Arithmetic Evaluation

```shell
c="foo"
((c+="bar"))
echo $c		# 0, string concat does not work in arithmetic evaluation

# string concat operators should be used like this
c="foo"
c+="bar"
echo $c		# foobar
```



## Arithmetic Operators

- Identical to other languages

| +    | 더하기                                    |
| ---- | ----------------------------------------- |
| -    | 빼기                                      |
| *    | 곱하기                                    |
| /    | 나누기                                    |
| **   | 누승(exponentiation), 거듭제곱(power)     |
| %    | modulo 나 mod (정수 나누기에서 나머지 값) |
| +=   | 상수값 만큼 증가(plus-equal)              |
| -=   | 상수값 만큼 감소(minus-equal)             |
| *=   | 상수값을 곱함(times-equal)                |
| /=   | 상수값으로 나눔(slash-equal)              |
| %=   | 상수값으로 나눈 나머지 값(mod-equal)      |



## Conditional Evaluations

### `test`

- [see this section](#file-test-operators) for file testing operators

### `[]`

- same as traditional `test` command
- POSIX standard

### `[[ ]]`

- not a POSIX standard, and for bash, zsh and else

- it provides more features like, 

  - `&&` and `||` operator

    ```bash
    [[ $string == "keyword" && 1 == "1" ]]
    ```

  - wildcard matching

    ```bash
    [[ "$string" == *"keyword"* ]]
    ```

  - regex matching

    ```bash
    [[ $string =~ "keyword" ]]
    ```

### `If`

>  `if` and `brackets` must be spaced.

```sh
if [[ <condition> ]]; then 
	...
elif [[]]; then
	...
else [[]]
	...
fi
```



## Conditional Operators

### `true`, `false` and `:`

- `true` and `:` Both means true, but `:` is more portable than `true`
- in conditions, it's opposite to C language. `true` is `0` and `false` is `1`

### Integer Comparison Operators

```sh
-eq # Equal
-ne # Not equal
-lt # Less than
-le # Less than or equal
-gt # Greater than
-ge # Greater than or equal 

<
<=
>
>=
```

### String Comparison Operators

```shell
=
==
!=

if [[ "$a" < "$b" ]]
if [ "$a" \< "$b" ]

if [[ "$a" > "$b" ]]
if [ "$a" \> "$b" ]

if [ -z "$String" ] # is null?

if [ -n "$String" ] # is not null?
```

### File test operators

[block vs character files](https://unix.stackexchange.com/questions/60034/what-are-character-special-and-block-special-files-in-a-unix-system)

```shell
if [ -e "/my/file" ]; then ...; fi
-e	# exists?

-f	# normal file?
-b  # block device file?
-c  # character device file?

-d	# directory?
-L  # symlink?

-r  # read permission?
-w  # write permission?
-x  # execute permission?

-p  # named pipe (FIFO)?
-s  # file size is not 0?
-t  # 


# those options can also be used inline with "test"
test -x [path_to_file]; echo $!# file exists?
```



## Loops

### Commons

#### `break`, `continue` is same as other languages

### `for`

#### `for` with array

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

#### `for` with `seq`

`seq` is similar to python's `range()` internal method. You can create array ranged array with it. And it can also add custom delimiter between them.

```bash
for i in ${seq -s " " 3);do

	echo "$i"

done
```

#### `for` with arithmetic expression

In bash, you can use indexed iteration like other languages.

```shell
#!/bin/bash

for (( i = 1 ; i <= 10 ; i++ ))
do
	echo ${i}
done
```

### `case`

#### with `while`

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

#### ☑️ with `for`

```shell




```



### `while`

#### `IFS` and `while`

If you wrap `IFS` inside `while`, you can avoid `IFS ` assignment leaking outside.

```shell
while <array>;
do
	case in <array element>
		<condition>|...|<condition>)
			<do something>
		;;
	esac
done
```



### `until`

```shell
idx=10
until [ $idx -le 5 ]; do
    echo $range
    idx--
done
```





# Execution

## Running Executables

Syntax : `[path_to_executable]` or `[path_to_script]` or `[path_to_shell] [path_to_script]`

- Run file or script with a ***new*** shell. 
- Path should be a relative or absolute path, not just a name of file.
- i.e. not `my-file.sh` but `./my-file.sh`



## `.` vs `source`

- Same Feature : Run content of the file as a ***subprocess*** in the ***current*** shell.
- Difference between two is portability.

`.` is POSIX standard and `source` is bash or others.



## `exec`

> [reference : exec vs eval](https://unix.stackexchange.com/a/296852)  
>
> [reference : about exec](https://www.geeksforgeeks.org/exec-command-in-linux-with-examples/)

### With Commands

- ***replaces current shell*** process (not a subprocess) and executes following command
- This means the `PID` will be the same between the current shell and the exec.
- options
  - `[-c] ` execute command with empty environment
  - `[-l]` pass dash as `argv[0]`
  - `[-a name]` passshell executable as `argv[0]`, Otherwise the default one is used.

### With Redirection

- it redirects command ouput to the designated path.
- it can be used to modify the current shell's environment

```shell
#!/bin/bash
exec > my-path
ls				# nothing prints
echo new-file	# nothing prints

exit

cat my-path

# Desktop
# Documents
# ...
# new-file
```



## `eval`

- Evaluate string as commands in the ***current*** shell. 
- This means the `PID` will be the same between the current shell and the exec

```shell
foo=bar
cmd="foo=baz"
echo $foo  # bar

eval "$cmd"
echo $foo  # baz
```



## `()`

- `()` runs command inside as a subshell.

- This provides encapsulation around the command.

```bash
#!/bin/bash
echo $BASHPID	# 33763
(echo $BASHPID)	# 36848
```



## ☑️ Create Execution Routines with `crontab`

```shell
* * * * * * <command>
s m h D M Y

# "/" for "per every"
```



## `make` and `makefile`

> [makefile tutorial](https://makefiletutorial.com/)
>
> [example of makefile : osx brew airport](https://github.com/xwmx/airport/blob/master/Makefile)

- Runs `./makefile`
- It usually help decide which parts of a large program need to be recompiled, primarily used for c/c++ projects
- Other languages typically have their own tools that serve a similar purpose as Make
- series of instructions to run depending

```bash
# Usage:
# make        # compile all binary
# make clean  # remove ALL binaries and objects

py = python3

all:
	echo ${py}

foo.log: %.py
	echo "running python file"
	${py} $<
```





------

# Process Management

## Listing Processes

### `ps`

**return currently-running process' status**

- `-a` : all processes (not only this users process)
- `-x` : include process out of this shell's scope (like daemons)
- `-u` : group processes by user

### `top`

**realtime, interactive view for currently-running processes**

- btop / htop (ones with better interactivity)

## Manipulating Processes

### `kill <process id>`

- kill process

### `sleep <seconds as integer>`

- sleep execution of current shell

### Process Exit Codes

The exit status of the executed command line is represented with a 8bit integer.

Following are the most common reserved exit codes.

- `0` : command was successful without any errors
- `<1-255>` : command failed
  - `1` : General errors 
  - `2` : Misuse of shell builtins

## Background Processes

> To make background procss properly, use process managers like pm2

### `^ z` key on keyboard

suspends process from running

### `jobs`

show current jobs including bg processes

```sh
jobs

# [1] + Suspended <process>
# [2] + Suspended <process>
```

### `bg` and `fg`

- push process background or bring process foreground

```sh
bg %1 # push job number 1 to the background
bg %2 # push job number 2 to the background
fg %2 # bring job number 2 to the foreground
```

### Difference between `nohup`, `disown` and `&`

Stack Exchange [Source](https://unix.stackexchange.com/questions/3886/difference-between-nohup-disown-and)

|                           | Separation from job control                                  | Separation from terminal stdio                              | Background                                                   | When the shell receives `SIGHUP`   | standard             |
| ------------------------- | ------------------------------------------------------------ | :---------------------------------------------------------- | ------------------------------------------------------------ | ---------------------------------- | -------------------- |
| normal process            | none                                                         | inherits stdin/stdout/stderr from the shell                 | no                                                           | sends `SIGHUP` to the process      | -                    |
| `&`                       | none                                                         | `stdout/stderr` inherits shell, but `stdin` doesn't         | puts process background, `bg` does same thing, `fg` brings it back. | sends `SIGHUP` to the process      | a POSIX standard     |
| `disown [...jobs]`        | removes the job from the shell's job control list, but still connected to the terminal. | `stdout/stderr` inherits shell, but `stdin` doesn't         | can only applied to jobs that ar e ***alreay*** on background | shell **won't send** it a `SIGHUP` | a POSIX standard     |
| `nohup [job] > [outfile]` | doesn't remove the process from the job list                 | closes `stdin` and redirects `stdout/stderr` to `nohup.out` | no                                                           | **shields** process from `SIGHUP`  | not a POSIX standard |





---

# Network and Protocols

## Network Stats

### ☑️ `port`

- 

### ☑️ `ping`

- 

### ☑️ test bandwidth

**https://phoenixnap.com/kb/linux-network-speed-test#ftoc-heading**

## Common Network Protocols

### ☑️ `curl`

- 

### ☑️ `sftp`

- 

### ☑️ `sshfs`

- 



------

# System Environment

### `/etc/os-release` (linux only)

- os release version information is stored here

### `reboot`

- reboot this machine

### ☑️ Locale Settings

```bash
# mac
export LANG=en_US.UTF-8

# centos

# ubuntu

```

- centos7 (https://thefif19wlsvy.tistory.com/245)
- ubuntu (https://pragp.tistory.com/entry/Docker-한글-설정하기)
- ubuntu (https://donghak-dev.tistory.com/17)

### Prevent Desktops from Sleeping

- (for mac) `caffeinate`
  - I use this for making my old mac book pro into a persistent server

- (for linux) `systemd-ihibit`





---

# String Matching and Manipulation



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

### Example Usecase of String Manipulation

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

# Some Useful Examples

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
> - [ibm zOS commands](https://www.ibm.com/docs/en/zos/2.2.0?topic=reference-shell-command-descriptions)
>
> - [grep](https://www.gnu.org/software/grep/manual/grep.html)
>
> - [grep summary](https://www.computerhope.com/unix/ugrep.htm)
>
> - [bash](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html)
> - [login and interactive shells](https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell)