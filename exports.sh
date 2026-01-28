#!/usr/bin/env bash

export BUN_INSTALL="$HOME/.bun"
export EDITOR="$HOME/.local/bin/lvim"

# Set Path
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/.local/bin:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"

# Load nvm and its completions
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

if [[ -n "$ZSH_VERSION" ]]; then
  # Assuming leahneukirchen/lr was installed via make install
  [ -f "/usr/local/share/zsh/site-functions/_lr" ] && source "/usr/local/share/zsh/site-functions/_lr"
  
  # Load completions for bun
  [ -f "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
fi
