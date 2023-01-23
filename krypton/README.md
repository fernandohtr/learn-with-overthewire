# Krypton

[Krypton wargame](https://overthewire.org/wargames/krypton/) progress.

## Prerequisites

- ssh
- sshpass
- shell

## First access

On first access you will use the default path with ssh. This is necessary
because on first login ssh will add the host to ssh's `host_know` list.

Example:
```
ssh -p 2231 krypton1@krypton.labs.overthewire.org
```

Thereafter the autokrypton script can be used.


## Usage

After finding the password for a certain level, the password is saved in a file
with the respective access level number.

### Using shell

```bash
./autokrypton.sh <level number>
# Example
./autokrypton.sh 2
```

### Level 0

#### Question

Welcome to Krypton! The first level is easy. The following string encodes the
password using Base64:

```
S1JZUFRPTklTR1JFQVQ=
```

Use this password to log in to krypton.labs.overthewire.org with username
krypton1 using SSH on port 2231. You can find the files for other levels in
/krypton/

#### Solution

```bash
echo S1JZUFRPTklTR1JFQVQ= | base64 -d
# ***password for next level***
```
