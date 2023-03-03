#! /bin/bash
NUMBER=$1
ARG=$2

if [ -z "$NUMBER" ]; then
	echo "Level must be passed"
elif [ ! -f "$NUMBER" ]; then
	echo "Password for Level $NUMBER dons't exist"
else
	sshpass -f $NUMBER ssh bandit$NUMBER@bandit.labs.overthewire.org -p 2220 $ARG
fi
