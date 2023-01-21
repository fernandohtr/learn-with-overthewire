# Bandit

[Bandit wargame](https://overthewire.org/wargames/bandit/) progress.

## Prerequisites

- ssh
- shell or python3

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
