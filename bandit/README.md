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
directory

#### Solution

```bash
ls
# -
cat ./-
# ***password for next level***
```