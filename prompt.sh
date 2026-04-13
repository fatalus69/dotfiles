#!/usr/bin/env bash

if [[ "$HOME" == "/root" ]]; then
    # Root prompt for servers
    PS1='\[\e[91m\]\u\[\e[0m\]@\[\e[96m\]\h\[\e[0m\]:\[\e[33m\]\w\[\e[0m\]\$ '
else
    # more or less normal bash prompt
    PS1='\[\e[92m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[0m\]\\$ '
fi
