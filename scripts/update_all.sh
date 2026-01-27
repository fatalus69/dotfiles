#!/usr/bin/env bash

# This updates all git repositories in the directory it's being executed in
# Usage: update_all

set -eou pipefail
shopt -s nullglob

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../variables.sh"

printf "Updating all Repositories in %s/ \n\n" "$(pwd)"

for dir in */ ; do
    if [ -d "$dir/.git" ]; then
        git -C "$dir" fetch > /dev/null 2>&1

        if ! git -C "$dir" rev-parse @{u} >/dev/null 2>&1; then
            printf "%sSkipping %s (no upstream)%s\n" "$YELLOW" "$dir" "$RESET"
            continue
        fi

        LOCAL=$(git -C "$dir" rev-parse @)
        REMOTE=$(git -C "$dir" rev-parse @{u})
        BASE=$(git -C "$dir" merge-base @ @{u})

        if [ "$LOCAL" = "$REMOTE" ]; then
            echo "$dir is already up to date."
        elif [ "$LOCAL" = "$BASE" ]; then
            printf "%sUpdating %s%s...\n" "$GREEN" "$dir" "$RESET"

            git -C "$dir" pull > /dev/null 2>&1

            if [ -f "$dir/composer.json" ]; then
                composer -d "$dir" install --no-interaction --quiet --prefer-dist > /dev/null 2>&1
            fi

            if [ -f "$dir/package.json" ]; then
                npm --prefix "$dir" install --silent > /dev/null 2>&1
            fi
        else
            printf "%s%s has local changes that need to be resolved manually.%s\n" "$RED" "$dir" "$RESET"
        fi
    else
        printf "%sSkipping %s, not a Git Repository%s\n" "$YELLOW" "$dir" "$RESET"
    fi
done