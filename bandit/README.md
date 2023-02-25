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
ls -R
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

### Level 11

#### Question

The password for the next level is stored in the file data.txt, where all
lowercase (a-z) and uppercase (A-Z) letters have been rotated by 13 positions

#### Solution

```bash
ls
# data.txt
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
# The password is ***password for next level***
```

### Level 12

#### Question

The password for the next level is stored in the file data.txt, which is a
hexdump of a file that has been repeatedly compressed. For this level it may
be useful to create a directory under /tmp in which you can work using mkdir.
For example: mkdir /tmp/myname123. Then copy the datafile using cp, and rename
it using mv (read the manpages!)

#### Solution

```bash
ls
# data.txt
mktemp -d
# /tmp/tmp.wW0Kh4m0PC
cp data.txt /tmp/tmp.wW0Kh4m0PC
cat data.txt | xxd -r > hexdump
file hexdump
# hexdump: gzip compressed data, was "data2.bin" ...
mv hexdump hexdump.gz
gzip -d hexdump.gz
ls
# data.txt  hexdump
file hexdump
# hexdump: bzip2 compressed data, block size = 900k
mv hexdump hexdump.bz2
ls
# data.txt  hexdump.bz2
bzip2 -d hexdump.bz2
file hexdump
# hexdump: gzip compressed data, was "data4.bin" ...
mv hexdump hexdump.gz
gzip -d hexdump.gz
ls
# data.txt  hexdump
file hexdump
# hexdump: POSIX tar archive (GNU)
tar -xvf hexdump
# data5.bin
ls
# data5.bin  data.txt  hexdump
file data5.bin
# data5.bin: POSIX tar archive (GNU)
tar -xvf data5.bin
# data6.bin
file data6.bin
# data6.bin: bzip2 compressed data, block size = 900k
mv data6.bin data6.bin.bz2
bzip2 -d data6.bin.bz2
ls
# data5.bin  data6.bin  data.txt  hexdump
file data6.bin
# data6.bin: POSIX tar archive (GNU)
tar -xvf data6.bin data6.bin
# data8.bin
file data8.bin
# data8.bin: gzip compressed data, was "data9.bin" ...
mv data8.bin data8.bin.gz
gzip -d data8.bin.gz
ls
# data5.bin  data6.bin  data8.bin  data.txt  hexdump
file data8.bin
data8.bin: ASCII text
cat data8.bin
# The password is ***password for next level***
```

### Level 13

#### Question

The password for the next level is stored in /etc/bandit_pass/bandit14 and can
only be read by user bandit14. For this level, you don’t get the next password,
but you get a private SSH key that can be used to log into the next level.
Note: localhost is a hostname that refers to the machine you are working on

#### Solution

```bash
ls
# sshkey.private
ssh bandit14@localhost -p 2220 -i sshkey.private
whoami
# bandit14
cat /etc/bandit_pass/bandit14
# ***password for next level***
```

### Level 14

#### Question

The password for the next level can be retrieved by submitting the password of
the current level to port 30000 on localhost.

#### Solution

```bash
cat /etc/bandit_pass/bandit14
# # copy last level password
nc localhost 30000
# # pass the copied password
# Correct!
# ***password for next level***
```

### Level 15

#### Question

The password for the next level can be retrieved by submitting the password of
the current level to port 30001 on localhost using SSL encryption.

Helpful note: Getting “HEARTBEATING” and “Read R BLOCK”? Use -ign_eof and read
the “CONNECTED COMMANDS” section in the manpage. Next to ‘R’ and ‘Q’, the ‘B’
command also works in this version of that command…

#### Solution

```bash
pass=**password of current level**; openssl s_client -connect localhost:30001
# CONNECTED(00000003)
# Can't use SSL_get_servername
# depth=0 CN = localhost
# verify error:num=18:self-signed certificate
# <...>
#     Verify return code: 10 (certificate has expired)
#     Extended master secret: no
#     Max Early Data: 0
# ---
# read R BLOCK
#
# # pass the current level password
# Correct!
# ***password for next level***
```

### Level 16

#### Question

The credentials for the next level can be retrieved by submitting the password
of the current level to a port on localhost in the range 31000 to 32000. First
find out which of these ports have a server listening on them. Then find out
which of those speak SSL and which don’t. There is only 1 server that will give
the next credentials, the others will simply send back to you whatever you send
to it.

#### Solution

```bash
nmap localhost -p 31000-32000
# Starting Nmap 7.80 ( https://nmap.org ) at 2023-02-25 23:32 UTC
# Nmap scan report for localhost (127.0.0.1)
# Host is up (0.00010s latency).
# Not shown: 996 closed ports
# PORT      STATE SERVICE
# 31046/tcp open  unknown
# 31518/tcp open  unknown
# 31691/tcp open  unknown
# 31790/tcp open  unknown
# 31960/tcp open  unknown
nmap localhost -p 31046,31518,31691,31790,31960 -sV -T4
# <...>
# PORT      STATE SERVICE     VERSION
# 31046/tcp open  echo
# 31518/tcp open  ssl/echo
# 31691/tcp open  echo
# 31790/tcp open  ssl/unknown
# 31960/tcp open  echo
# <...>
openssl s_client -connect localhost:31790
# # pass the current level password
# <...>
# Correct!
# -----BEGIN RSA PRIVATE KEY-----
# MIIEogIBAAKCAQEAvmOkuifmMg6HL2YPIOjon6iWfbp7c3jx34YkYWqUH57SUdyJ
# imZzeyGC0gtZPGujUSxiJSWI/oTqexh+cAMTSMlOJf7+BrJObArnxd9Y7YT2bRPQ
# Ja6Lzb558YW3FZl87ORiO+rW4LCDCNd2lUvLE/GL2GWyuKN0K5iCd5TbtJzEkQTu
# DSt2mcNn4rhAL+JFr56o4T6z8WWAW18BR6yGrMq7Q/kALHYW3OekePQAzL0VUYbW
# JGTi65CxbCnzc/w4+mqQyvmzpWtMAzJTzAzQxNbkR2MBGySxDLrjg0LWN6sK7wNX
# x0YVztz/zbIkPjfkU1jHS+9EbVNj+D1XFOJuaQIDAQABAoIBABagpxpM1aoLWfvD
# KHcj10nqcoBc4oE11aFYQwik7xfW+24pRNuDE6SFthOar69jp5RlLwD1NhPx3iBl
# J9nOM8OJ0VToum43UOS8YxF8WwhXriYGnc1sskbwpXOUDc9uX4+UESzH22P29ovd
# d8WErY0gPxun8pbJLmxkAtWNhpMvfe0050vk9TL5wqbu9AlbssgTcCXkMQnPw9nC
# YNN6DDP2lbcBrvgT9YCNL6C+ZKufD52yOQ9qOkwFTEQpjtF4uNtJom+asvlpmS8A
# vLY9r60wYSvmZhNqBUrj7lyCtXMIu1kkd4w7F77k+DjHoAXyxcUp1DGL51sOmama
# +TOWWgECgYEA8JtPxP0GRJ+IQkX262jM3dEIkza8ky5moIwUqYdsx0NxHgRRhORT
# 8c8hAuRBb2G82so8vUHk/fur85OEfc9TncnCY2crpoqsghifKLxrLgtT+qDpfZnx
# SatLdt8GfQ85yA7hnWWJ2MxF3NaeSDm75Lsm+tBbAiyc9P2jGRNtMSkCgYEAypHd
# HCctNi/FwjulhttFx/rHYKhLidZDFYeiE/v45bN4yFm8x7R/b0iE7KaszX+Exdvt
# SghaTdcG0Knyw1bpJVyusavPzpaJMjdJ6tcFhVAbAjm7enCIvGCSx+X3l5SiWg0A
# R57hJglezIiVjv3aGwHwvlZvtszK6zV6oXFAu0ECgYAbjo46T4hyP5tJi93V5HDi
# Ttiek7xRVxUl+iU7rWkGAXFpMLFteQEsRr7PJ/lemmEY5eTDAFMLy9FL2m9oQWCg
# R8VdwSk8r9FGLS+9aKcV5PI/WEKlwgXinB3OhYimtiG2Cg5JCqIZFHxD6MjEGOiu
# L8ktHMPvodBwNsSBULpG0QKBgBAplTfC1HOnWiMGOU3KPwYWt0O6CdTkmJOmL8Ni
# blh9elyZ9FsGxsgtRBXRsqXuz7wtsQAgLHxbdLq/ZJQ7YfzOKU4ZxEnabvXnvWkU
# YOdjHdSOoKvDQNWu6ucyLRAWFuISeXw9a/9p7ftpxm0TSgyvmfLF2MIAEwyzRqaM
# 77pBAoGAMmjmIJdjp+Ez8duyn3ieo36yrttF5NSsJLAbxFpdlc1gvtGCWW+9Cq0b
# dxviW8+TFVEBl1O4f7HVm6EpTscdDxU+bCXWkfjuRb7Dy9GOtt9JPsX8MBTakzh3
# vBgsyi/sN3RqRBcGU40fOoZyfAMT8s1m/uYv52O6IgeuZ/ujbjY=
# -----END RSA PRIVATE KEY-----
#
# closed
mktemp -d
# /tmp/tmp.FwkwiXiSKB
cd /tmp/tmp.FwkwiXiSKB
vim rsafile
# # paste de rsa private key inside the file and save
chmod 600 rsafile
ssh -i rsafile bandit17@localhost -p 2220
whoami
# bandit17
cat /etc/bandit_pass/bandit17
# ***password for next level***
```
