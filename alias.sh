#!/usr/bin/env bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias python='python3'
alias onefetch='onefetch --nerd-fonts --include-hidden --no-bots'
alias drush='ddev drush'

# Source bash/zshrc
alias sb="source $HOME/.bashrc"
alias sz="source $HOME/.zshrc"

# Source custom scripts
alias update_all="bash $SCRIPT_DIR/scripts/update_all.sh"
