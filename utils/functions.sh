#!/usr/bin/env bash

set -euo pipefail

[[ $- != *i* ]] && return

# 0 => yes, 1 => error / no
function askYesOrNo() {
    if [[ $n -lt 1 ]]; then
	    return 1	
	fi

    local question="$1"
    local answer=""

    read -pr "${question} [Y/n] " answer
    if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
        return 0
    fi

    return 1
}
