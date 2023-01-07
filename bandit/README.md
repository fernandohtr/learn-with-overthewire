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

```bash
ls
# readme
cat readme
# ***password for next level***
```
