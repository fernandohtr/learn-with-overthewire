# Bandit

[Bandit wargame](https://overthewire.org/wargames/bandit/) progress.

## Prerequisites

- ssh
- sshpass
- shell or python3

## First access

On first access you will use the default path with ssh. This is necessary
because on first login ssh will add the host to ssh's `host_know` list.

Example:
```
ssh -p 2220 bandit0@bandit.labs.overthewire.org
```

Thereafter the autobandit script can be used.

## Usage

After finding the password for a certain level, the password is saved in a file
with the respective access level number.

### Using shell

```bash
./autobandit.sh <level number>
# Example
./autobandit.sh 12
```

### Using python

```bash
python3 autobandit.py <level number>
# Example
python3 autobandit.py 12
```

## Progress by level

Record how to find the password in each level

### Level 0

#### Question

The password for the next level is stored in a file called readme located in the
home directory. Use this password to log into bandit1 using SSH. Whenever you
find a password for a level, use SSH (on port 2220) to log into that level and
continue the game.

#### Solution

```bash
ls
# readme
cat readme
# ***password for next level***
```

### Level 1

#### Question

The password for the next level is stored in a file called - located in the home
directory.

#### Solution

```bash
ls
# -
cat ./-
# ***password for next level***
```

### Level 2

#### Question

The password for the next level is stored in a file called spaces in this
filename located in the home directory.

#### Solution

```bash
ls
# space in this filename
# A tip for this challenge is to type "spaces" and then type "tab" to
# autocomplete the filename
cat spaces\ in\ this\ filename
# ***password for next level***
```

### Level 3

#### Question

The password for the next level is stored in a hidden file in the inhere
directory.

#### Solution

```bash
ls
# inhere/
cd inhere/
ls -a
# . .. .hidden
cat .hidden
# ***password for next level***
```

### Level 4

#### Question

The password for the next level is stored in the only human-readable file in
the inhere directory. Tip: if your terminal is messed up, try the “reset”
command.

#### Solution

```bash
ls
# inhere/
cd inhere/
ls
# -file00  -file01  -file02  -file03  -file04  -file05  -file06  -file07  -file08  -file09
for i in $(ls); do file ./$i; done
# ...
# ./-file05: data
# ./-file06: data
# ./-file07: ASCII text
# ./-file08: data
# ./-file09: data
cat ./-file07
# ***password for next level***
```

### Level 5

#### Question

The password for the next level is stored in a file somewhere under the inhere
directory and has all of the following properties:

	human-readable
	1033 bytes in size
	not executable

#### Solution

```bash
ls
# inhere/
cd inhere/
# ls -R
# .:
# maybehere00  maybehere03  maybehere06  maybehere09  maybehere12  maybehere15  maybehere18
# maybehere01  maybehere04  maybehere07  maybehere10  maybehere13  maybehere16  maybehere19
# maybehere02  maybehere05  maybehere08  maybehere11  maybehere14  maybehere17
#
# ./maybehere00:
# -file1  -file2  -file3  spaces file1  spaces file2  spaces file3
#
# ./maybehere01:
# -file1  -file2  -file3  spaces file1  spaces file2  spaces file3
#
# ...
#
# ./maybehere18:
# -file1  -file2  -file3  spaces file1  spaces file2  spaces file3
#
# ./maybehere19:
# -file1  -file2  -file3  spaces file1  spaces file2  spaces file3
find . -readable -size 1033c -not -executable
# ./maybehere07/.file2
cat maybehere07/.file2
# ***password for next level***
```

### Level 6

#### Question

The password for the next level is stored somewhere on the server and has all
of the following properties:

	owned by user bandit7
	owned by group bandit6
	33 bytes in size

#### Solution

```bash
find / -user bandit7 -group bandit6 -size 33c 2> /dev/null
# It is necessary to use "2> /dev/null" because if not, a bunch of files with 
# "No files or directories" and "Permission denied" will be returned,
# polluting the display
#
# /var/lib/dpkg/info/bandit7.password
cat /var/lib/dpkg/info/bandit7.password
# ***password for next level***
```

### Level 7

#### Question

The password for the next level is stored in the file data.txt next to the word
millionth

#### Solution

```bash
ls
# data.txt
grep millionth data.txt
# millionth         ***password for next level***
```

### Level 8

#### Question

The password for the next level is stored in the file data.txt and is the only
line of text that occurs only once

#### Solution

```bash
ls
# data.txt
cat data.txt | sort | uniq -u
# ***password for next level***
```

### Level 9

#### Question

The password for the next level is stored in the file data.txt in one of the
few human-readable strings, preceded by several ‘=’ characters.

#### Solution

```bash
ls
# data.txt
file data.txt
# data.txt: data
strings data.txt | grep -E "==+"
# c========== the
# h;========== password
# ========== isT
# n.E========== ***password for next level***
```

### Level 10

#### Question

The password for the next level is stored in the file data.txt, which contains
base64 encoded data

#### Solution

```bash
ls
# data.txt
cat data.txt | base64 -d
# The password is ***password for next level***
```
