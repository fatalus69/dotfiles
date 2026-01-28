#!/usr/bin/env bash

# Exit if not an interactive shell
[[ $- != *i* ]] && return

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

alias ls='ls --color=auto'
alias ll='ls -laFh --color=auto'
alias grep='grep --color=auto'
alias python='python3'
alias onefetch='onefetch --nerd-fonts --include-hidden --no-bots'
alias drush='ddev drush'
alias laravel_clear='php artisan optimize &&php artisan cache:clear && php artisan config:clear && php artisan route:clear && php artisan view:clear'

# Source bash/zshrc
if [[ -n "$ZSH_VERSION" ]]; then
    alias sz="source $HOME/.zshrc"
elif [[ -n "$BASH_VERSION" ]]; then
    alias sb="source $HOME/.bashrc"
fi

# alias custom scripts
for script in "$SCRIPT_DIR/scripts/"*.sh; do
    # Looks nice, especially when I make more scripts,
    # but I don't see the path to it when I do which NAME

    script_name=$(basename "$script" .sh)
    alias "$script_name"="bash $script"
done