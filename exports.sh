#!/usr/bin/env bash

export BUN_INSTALL="$HOME/.bun"
export EDITOR="$HOME/.local/bin/lvim"

# Set Path
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/.local/bin:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"

# Load completions for bun
[ -f "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Assuming leahneukirchen/lr was installed via make install
if [[ $SHELL == *"zsh" ]]; then
  [ -f "/usr/local/share/zsh/site-functions/_lr" ] && source "/usr/local/share/zsh/site-functions/_lr"
fi
