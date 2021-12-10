# Useful Shell Commands and Configurations

{{TOC}}

[TOC]



------

## Security and Authentication

### ssh keys and config

- **key generation**
- config
  - **auth**
  - **portf**
  - **password**
- **sshd restart ()**

```bash
# **mac**
**sudo launchctl unload /System/Library/LaunchDaemons/ssh.plist
sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist

# ubuntu

# centos**
```

### firewall

### fail2ban



---

## Formatting String for Git Usage

```bash
# Any String Into Branch Name
# 
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

# Any Branch Name Into Title
#
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

## Basic String I/O

### echo

### cat

**concat multiple files**

### **more**

**interactive reader, only go forward**

### l**ess**

**interactive reader, may other features**

### **top**

**first lines**

### **tail**

**last lines**

## **read**

read line-by-line from pipeline or stdin



------

## Basic String Match and Replace

### **grep**

- **-o (get all matches, even ones in a same line)**
- **-n (line number of a match)**
- **-E (use regex)**

### awk

### tr

### cut

### sed

- sed -E or -r

  - -regexp-extended

  - regex rules are still different

  - i.e. matches like **`\\d` or `\\s`** don't work. Use `[0-9]` or `[ ]` instead

  - **`+`** doesn't work, use **`\*`**

  - **`$`** matches end of line

  - `^` matches start of line

  - for both start and end, use  

    ```
    (^|<match>)*.(<match>|$)
    ```

    - `*.` is for unbounded match any character



------

## Flow Control

### for /w array

```bash
#!/bin/bash

# array in multi line
arr_1[0]="A"
arr_1[0]="B"
arr_1[0]="C"

# array in one line
arr_2=("A" "B" "C")

for i in ${arr_2[@]};do

	echo "$i"

done

# it will print this
#
# A
# B
# C
```

### for /w seq

```bash
#!/bin/bash

for i in ${seq -s " " 3);do

	echo "$i"

done
```

------

## Variables

### inline assignment

```bash
hello="world"
echo "$hello"

# world
```

- echo foo | read bar; do something here



------

## Processes

### **ps**

**return currently-running process' status**

- -**a (not only this users process)**
- -**x (include process out of shell's scope, like daemons)**
- -**u (group by user)**

### **top**

**realtime, interactive view for currently-running processes**

- btop / htop (ones with better interactivity)

### **kill <process id>**

kill process

### **exit**

- **0 (Success)**
- **1** (General errors)
- **2** (Error of shell builtin misuse)

### Don't Hangup Even If This Shell Session Dies

> To make background procss properly, use process managers like pm2

### nohup

### bg

### &

### **disown**

**https://serverfault.com/questions/34750/is-it-possible-to-detach-a-process-from-its-terminal-or-i-should-have-used-s**

### Don't Sleep (for desktop) ****

I use this for making my old mac book pro into a persistent server

- (mac) caffeinate
- (ubuntu) systemd-ihibit (not tested, from stof)



------

## Environments

### **`ps -p $$`**

which shell am I using?

### `which <keyword>`

where is this keyword's executable binary?

check version with this like `which python`

### **`cat /etc/os-release`**

[Linux Only] which os is this?

### **`reboot`**

reboot this machine

### `df -h <?path>`

check disk space

- `-h` is human-readable
- `-H` is for 1000 instead of 1024
- if <?path> is empty it displays whole accessible disks

### `du -sh`

check size for individual files or directories

- `-s` is for simplification (w/o full path strings)
- `-h` is human-readable
- if <?path> is empty it displays current directory

### Network Speed Test

**https://phoenixnap.com/kb/linux-network-speed-test#ftoc-heading**

### `last`

who logged in last time?



------

## Files

### Authorization

- chmod
  - 700
  - 777



------

## Locale

### Korean Output

```bash
export LANG=en_US.UTF-8
```

- **centos7 (https://thefif19wlsvy.tistory.com/245)**
- **ubuntu (https://pragp.tistory.com/entry/Docker-한글-설정하기)**

### Korean Input

- **centos7**
- **ubuntu (https://donghak-dev.tistory.com/17)**



------

## For Mac Only

### If you really want to remove **.DS_Store**

- reconsider this, as you can ignore .DS_Store with configs like`~/.gitignore_global` for git, and `—exclude .DS_Store` for rsync

```bash
# [1] **print out all files starting from current directory
# [2] find .DS_Store
# [3] wrap string inside quotes
# [4] for each path, do rm** 
**find . | 
grep .DS_Store | 
sed "s/^/'/;s/$/'/" | 
xargs rm |** 
```

------

## Useful ~/.**zshrc Configs**

### Difference Between Each Config Files

https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout

### Common

```bash
# open app with aliases
alias my_command='open -a <application or executable> <args>'
alias code='opan -a "Visual Studio Code"'

# common navigation aliases
alias la='ls -a'
alias sizeof='du -sh'
```

### Backup with one command

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

### SSH Agent On Shell Open

```bash
sshagent() {
	[ -z "$SSH_AUTH_SOCK" ]
	eval "$(ssh-agent -s)"
	eval "$(ssh-add ~/.ssh/mbp13)"
}
```



------