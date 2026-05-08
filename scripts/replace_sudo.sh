#!/usr/bin/env bash

# This script checks if sudo is actually sudo-rs, if so it replaces it with the proper one.
# Useful after every systemupdate on Pika, as it ships with sudo-rs instead of sudo

set -euo pipefail

[ "$(id -u)" -ne 0 ] && echo "Please run as root user." && exit 1

SUDO_BIN="/usr/bin/sudo"
SUDO_WRAPPER="/usr/bin/sudo_wrapper" # aka sudo-rs
SUDO_ORIGINAL="/usr/bin/sudo_original"

if [[ -L "$SUDO_BIN" ]]; then
    TARGET="$(readlink -f "$SUDO_BIN")"
    if [[ "$TARGET" == "$SUDO_WRAPPER" ]]; then
        if [[ ! -f "$SUDO_ORIGINAL" ]]; then
            echo "Install sudo!"
            exit 1
        fi
        ln -sf "$SUDO_ORIGINAL" "$SUDO_BIN"
        echo "Replaced sudo-rs with the sudo"
    fi
fi