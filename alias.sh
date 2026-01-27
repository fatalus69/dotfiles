#!/usr/bin/env bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias python='python3'
alias onefetch='onefetch --nerd-fonts --include-hidden --no-bots'
alias drush='ddev drush'

# Source bash/zshrc
if [[ $SHELL == *"zsh" ]]; then
    alias sz="source $HOME/.zshrc"
elif [[ $SHELL == *"bash" ]]; then
    alias sb="source $HOME/.bashrc"
fi

# alias custom scripts
for script in "$SCRIPT_DIR/scripts/"*.sh; do
    # Looks nice, especially when I make more scripts,
    # but I don't see the path to it when I do which NAME

    script_name=$(basename "$script" .sh)
    alias "$script_name"="bash $script"
done