#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

[ "$(id -u)" -ne 0 ] && echo "Please run as root user." && exit 1

# Backup
if [[ -d "$HOME/.bashrc" ]]; then
    if [[ ! -d "$HOME/.bashrc.bak" ]]; then
        cp "$HOME/.bashrc" "$HOME/.bashrc.bak"
    else
        read -rp "You already have a backup file to your .bashrc (.bashrc.bak). Overwrite this file? [y/n] " answer
        if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
            cp "$HOME/.bashrc" "$HOME/.bashrc.bak"
        fi
    fi
fi

# Clear bashrc file first, then write to it.
echo "" > "$HOME/.bashrc"

{ echo "source $SCRIPT_DIR/../prompt.sh"; echo "source $SCRIPT_DIR/../exports.sh"; echo "source $SCRIPT_DIR/../alias.sh"; } >> "$HOME/.bashrc"

source "$HOME/.bashrc"
