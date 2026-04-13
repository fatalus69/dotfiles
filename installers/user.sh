#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CURRENT_SHELL="bash"

source "$SCRIPT_DIR/../utils/variables.sh"

# Perhaps add more shells except fish
if [[ -n "${ZSH_VERSION:-}" ]]; then
    CURRENT_SHELL="zsh" 
fi

if [[ -e "$HOME/.${CURRENT_SHELL}rc" ]]; then
    if [[ ! -e "$HOME/.${CURRENT_SHELL}rc.bak" ]]; then
        cp "$HOME/.${CURRENT_SHELL}rc" "$HOME/.${CURRENT_SHELL}rc.bak"
    else
        read -rp "You already have a backup file to your .${CURRENT_SHELL}rc (.${CURRENT_SHELL}rc.bak). Overwrite this file? [y/n] " answer
        if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
            cp "$HOME/.${CURRENT_SHELL}rc" "$HOME/.${CURRENT_SHELL}rc.bak"
        fi
    fi
fi

if [[ -d "$SCRIPT_DIR/../.config/" ]]; then
    cp -r "$SCRIPT_DIR/../.config/*" "$HOME/.config/"
fi

# Cllear before writing it. Perhaps do something else, so this can run multiple times if you want specific things. Would require to set something that indicates that the rc file was generated from my script
{ echo "#!/usr/bin/env $CURRENT_SHELL"; echo ""; }> "$HOME/.${CURRENT_SHELL}rc"

PS3="What do you want to be in your .${CURRENT_SHELL}rc file? "
types=("All" "Aliases" "Exports" "Completions" "Prompt")

select type in "${types[@]}"; do 
    case $REPLY in
        1) # All
            { echo "source $SCRIPT_DIR/../prompt.sh"; echo "source $SCRIPT_DIR/../completions/completions.sh"; echo "source $SCRIPT_DIR/../exports.sh"; echo "source $SCRIPT_DIR/../alias.sh"; } >> "$HOME/.${CURRENT_SHELL}rc"
            break
            ;;
        2) # Aliases
            echo "source $SCRIPT_DIR/../alias.sh" >> "$HOME/.${CURRENT_SHELL}rc"
            break
            ;;
        3) # Exports
            echo "source $SCRIPT_DIR/../exports.sh" >> "$HOME/.${CURRENT_SHELL}rc"
            break
            ;;
        4) # Completions
            echo "source $SCRIPT_DIR/../completions/completions.sh" >> "$HOME/.${CURRENT_SHELL}rc"
            break
            ;;
        5) # Prompt
            echo "source $SCRIPT_DIR/../prompt.sh" >> "$HOME/.${CURRENT_SHELL}rc"
            break
            ;;
        *)
            echo "Error: Invalid selection."
            printf "%sError: Invalid selection.%s" "$RED" "$RESET"
            echo "Restoring changes from $HOME/.${CURRENT_SHELL}rc.bak ..."

            mv "$HOME/.${CURRENT_SHELL}rc.bak" "$HOME/.${CURRENT_SHELL}rc"

            exit 1
            ;;
    esac
    break
done

source "$HOME/.${CURRENT_SHELL}rc"
