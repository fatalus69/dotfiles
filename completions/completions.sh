#!/usr/bin/env bash

# set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

function sourceCompletions() {
	for completion in "$SCRIPT_DIR/$1/"*.sh; do
		echo "$completion"
		exit 1
		source completion
	done
}

if [[ -n "$ZSH_VERSION" ]]; then
	sourceCompletions "zsh"
elif [[ -n "$BASH_VERSION" ]]; then
	sourceCompletions "bash"
fi
