#! /bin/bash
NUMBER=$1

if [ -z "$NUMBER" ]; then
	echo "Level must be passed"
elif [ ! -f "$NUMBER" ]; then
	echo "Password for Level $NUMBER dons't exist"
else
	sshpass -f $NUMBER ssh krypton$NUMBER@krypton.labs.overthewire.org -p 2231
fi
