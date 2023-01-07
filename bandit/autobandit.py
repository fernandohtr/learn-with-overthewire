#! /Users/fernando.toledo/.asdf/shims/python
import os
import subprocess

from sys import argv

try:
    NUMBER = argv[1]
except:
    pass
    
if len(argv) == 1:
    print('Level must be passed')
elif not NUMBER in os.listdir():
    print(f'Password for Level {NUMBER} dons\'t exist')
else:
    subprocess.run([
        'sshpass',
        '-f',
        f'{NUMBER}',
        'ssh',
        f'bandit{NUMBER}@bandit.labs.overthewire.org',
        '-p',
        '2220',
    ])
