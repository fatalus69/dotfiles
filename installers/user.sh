#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

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

if [[ -d "$SCRIPT_DIR/.config/" ]]; then
    cp -r "$SCRIPT_DIR/.config/*" "$HOME/.config/"
fi

PS3="What do you want to be in your .bashrc file? "
types=("All" "Aliases" "Exports" "Completions" "Prompt")

select type in "${types[@]}"; do 
    case $REPLY in
        1) # All
            { echo "source $SCRIPT_DIR/../prompt.sh"; echo "source $SCRIPT_DIR/../completions/completions.sh"; echo "source $SCRIPT_DIR/../exports.sh"; echo "source $SCRIPT_DIR/../alias.sh"; } >> "$HOME/.bashrc"
            break
            ;;
        2) # Aliases
            echo "source $SCRIPT_DIR/../alias.sh" >> "$HOME/.bashrc"
            break
            ;;
        3) # Exports
            echo "source $SCRIPT_DIR/../exports.sh" >> "$HOME/.bashrc"
            break
            ;;
        4) # Completions
            echo "source $SCRIPT_DIR/../completions/completions.sh" >> "$HOME/.bashrc"
            break
            ;;
        5) # Prompt
            echo "source $SCRIPT_DIR/../prompt.sh" >> "$HOME/.bashrc"
            break
            ;;
        *)
            echo "Invalid type"
            exit 1
            ;;
    esac
    break
done
