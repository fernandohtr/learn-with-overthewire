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

### Level 1

#### Question

The password for level 2 is in the file ‘krypton2’. It is ‘encrypted’
using a simple rotation. It is also in non-standard ciphertext format. When
using alpha characters for cipher text it is normal to group the letters into
5 letter clusters, regardless of word boundaries. This helps obfuscate any
patterns. This file has kept the plain text word boundaries and carried them to
the cipher text. Enjoy!

#### Solution

```bash
cd /krypton/krypton1
ls
# krypton2 README
cat krypton | tr 'A-Z' 'N-ZA-M'
# LEVEL TWO PASSWORD ***password for next level***
```

### Level 2

#### Question

ROT13 is a simple substitution cipher.

Substitution ciphers are a simple replacement algorithm. In this example of a
substitution cipher, we will explore a ‘monoalphebetic’ cipher. Monoalphebetic
means, literally, “one alphabet” and you will see why.

This level contains an old form of cipher called a ‘Caesar Cipher’. A Caesar
cipher shifts the alphabet by a set number. For example:
```
plain:  a b c d e f g h i j k ...
cipher: G H I J K L M N O P Q ...
```
In this example, the letter ‘a’ in plaintext is replaced by a ‘G’ in the
ciphertext so, for example, the plaintext ‘bad’ becomes ‘HGJ’ in ciphertext.

The password for level 3 is in the file krypton3. It is in 5 letter group
ciphertext. It is encrypted with a Caesar Cipher. Without any further
information, this cipher text may be difficult to break. You do not have direct
access to the key, however you do have access to a program that will encrypt
anything you wish to give it using the key. If you think logically, this is
completely easy.

One shot can solve it!

Have fun.

Additional Information:

The encrypt binary will look for the keyfile in your current working directory.
Therefore, it might be best to create a working direcory in /tmp and in there a
link to the keyfile. As the encrypt binary runs setuid krypton3, you also need
to give krypton3 access to your working directory.

Here is an example:

```
krypton2@melinda:~$ mktemp -d
/tmp/tmp.Wf2OnCpCDQ
krypton2@melinda:~$ cd /tmp/tmp.Wf2OnCpCDQ
krypton2@melinda:/tmp/tmp.Wf2OnCpCDQ$ ln -s /krypton/krypton2/keyfile.dat
krypton2@melinda:/tmp/tmp.Wf2OnCpCDQ$ ls
keyfile.dat
krypton2@melinda:/tmp/tmp.Wf2OnCpCDQ$ chmod 777 .
krypton2@melinda:/tmp/tmp.Wf2OnCpCDQ$ /krypton/krypton2/encrypt /etc/issue
krypton2@melinda:/tmp/tmp.Wf2OnCpCDQ$ ls
ciphertext  keyfile.dat
```

#### Solution

```bash
mktemp -d
# /tmp/tmp.fRJOFoWoE1
cd /tmp/tmp.fRJOFoWoE1
ln -s /krypton/krypton2/keyfile.dat
ls
# keyfile.dat
chmod 777 .
echo ABC > text
/krypton/krypton2/encrypt text
# ciphertext  keyfile.dat  text
cat ciphertext
# MNO
cat /krypton/krypton2/krypton3 | tr 'M-ZA-L' 'A-Z'
# ***password for next level***
```
