#!/usr/bin/env bash

ZSHTOOLS=$(dirname -- "$0")/plugins
source $ZSHTOOLS/powerlevel10k/powerlevel10k.zsh-theme
source $ZSHTOOLS/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $ZSHTOOLS/zsh-autocomplete/zsh-autocomplete.plugin.zsh     
source $ZSHTOOLS/zsh-you-should-use/you-should-use.plugin.zsh
source ~/.fzf.zsh

eval "$(zoxide init zsh)"