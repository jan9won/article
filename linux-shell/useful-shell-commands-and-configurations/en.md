☑️ sign means I'm still writing

{{TOC}}

[TOC]



> Commands in this article is tested with `bash` v5.x.x, and `zsh` v.5.8

## terminal, shell and console

Differences of these concepts are insignificant for modern computer users, but here are short descriptions.

#### shell

> (unix term) A command-line interpreter.

A user interface which actually processes your commands and returns output. The most common shell in modern linux system is `bash`. 

It manages foreground and background processes, command history and command line editing.

There are many kinds of shells. [See the article : Differences between login, non-login, interactive and non-interactive shell.](./differences-between-login-non-login-interactive-and-non-interactive-shell)

#### terminal

> (traditionally) A physical "text input/output device", like monitor and keyboard.

Back in the days, it was a physical device including monitor and keyboard.

More historically, it was a punch card for input and printer for output.

In current unix-like system, it's a wrapper program that runs a shell. It's also called `tty`. You can command `tty` on your shell to see your shell's terminal.

#### console

> (traditionally) A special sort of terminal, which is plugged into a dedicated serial port on a computer for a low-level commication with OS.

Originally, console meant a terminal device that is physically plugged into a computer. 

Current unix-like systems have virtual console, which is a software implementation of traditional terminal.

It's the primary user interface for OS. 

#### summary

```sh
terminal (remote or local, multiple, user interface)
-> shell (local, multiple)
-> console (local, single and initial) 
```



---

## ☑️ Auth

#### Why worry about many users?

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

### File Stats

#### `du -sh` file size

check size for individual files or directories

- `-s` is for simplification (w/o full path strings)
- `-h` is human-readable
- if <?path> is empty it displays current directory

#### `ls`

- `-l` show long stats
- `-a` show all hidden files
- I use `alias la='ls -a'` for shorthand

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



---

## ☑️ Strings

### ☑️ String Matching

#### ☑️ `grep <options> <string>`

​	common options

- `-E, --extended-regexp` : use extended regular expression (same as egrep)
- `-o, --only-matching` : print only the matched (non-empty) parts of a matching line
- `-n, --line-number` : prefix each match with line number
- `-w, --word-regexp` : only match beginning or end of a 'word' (preceded or followed by non-word characters : Letters, Digits, Uderscores) 
- `-v, --invert-match` : works as 'not' operator
- `-i, --ignore-case` : case insensitive match
- `-c, --count` : print count of matching lines

#### bash `[[]]` (double brackets)

```sh
[[ "$string" == *"keyword"* ]]
[[ "$string" =~ "keyword" ]]
```

#### difference between `[[]]` and `[]` 

[source](https://stackoverflow.com/a/47576482/13287692)

`[[]]` is bash extension, and it magically handles things like pathname expansion, word splitting, or regular expressions 

`[]` is posix, and can't do what `[[]]` can do.

### ☑️ String Manipulation

#### ☑️ `awk`

#### ☑️ `tr`

#### ☑️ `cut`

#### ☑️ `sed <options> <rules as string>` 

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

### Examples for Git Branch Naming

#### Any String -> Hyphen Separated Lowercase

```bash
# 1. make all characters lowercase
# 2. replace characters not in [a-zA-Z0-9] into "-" (hyphen)
# 3. remove every "-" start and end of line
#
# [source] Animation Libraries For Web And Hybrid Apps
# [result] animation-libraries-for-web-and-hybrid-apps
escape(){
	echo "$1" | 
	tr '[:upper:]' '[:lower:]' | 
	sed -r 's/([^a-zA-Z0-9])/-/g' |
	sed -r 's/(^|-)*.(-|$)//g'
}
```

#### Any Hyphen or Underscore Separated String -> Spaced Camelcase

```sh
# 1. replace "-" or "_" into space
# 2. trim multiple spaces into single space
# 3. replace every first character to uppercase
#
# [source] animation--libraries__for_web-and-hybrid-apps
# [result] Animation Libraries For Web And Hybrid Apps
camelcase(){
	echo "$1" | 
	sed 's/[-{,1}|_{,1}]/ /g' | 
	tr -s "" | 
	awk -F " " '{for(i=1;i<=NF;i++){$i=toupper(substr($i,1,1)) substr($i,2)}} 1' OFS=" "
}

# IFS (Internal Field Separator)
# OFS (Output Field Separator)
```



------

## Flow Controls

### `if`

```sh
if [[<condition>]]; 
	then 
		<commands on true condition>
	else 
  	<commands on false condition>
fi
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

```bash
#!/bin/bash

for i in ${seq -s " " 3);do

	echo "$i"

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

## Processes

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

## Environments

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

## Some Useful `zsh` Configs

### Difference Between `zsh` Config Files

https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout

### Open app aliases

```bash
# open app with aliases
alias my_command='open -a <application or executable> <args>'
alias code='opan -a "Visual Studio Code"'
```

### Backup Automation

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

### (mac) remove `.DS_Store`

As you can ignore .DS_Store with application configurations, reconsider removing it. `.DS_Store.` serves many roles for OSX like layout and icon of a directory.

i.e. In git, you can add `.DS_Store` in `~/.gitignore_global`, and for `rsync` you can add  `—exclude .DS_Store` flag.

```bash
# [1] find .DS_Store recursively
# [2] wrap string inside quotes (in case of whitespace in path name)
# [3] delete each path 
find . -name ".DS_Store" |
sed "s/^/'/;s/$/'/" | 
xargs rm |** 
```



------



> References
>
> https://www.computerhope.com/unix/ugrep.htm