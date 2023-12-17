#!/usr/bin/env bash

ZSHTOOLS=$(dirname -- "$0")/plugins
source $ZSHTOOLS/powerlevel10k/powerlevel10k.zsh-theme
source $ZSHTOOLS/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $ZSHTOOLS/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSHTOOLS/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZSHTOOLS/zsh-you-should-use/you-should-use.plugin.zsh
source $ZSHTOOLS/jq-zsh-plugin/jq.plugin.zsh
source ~/.fzf.zsh

# zsh substring search key binding
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

bindkey '^j' jq-complete

# fzf configs
eval "$(zoxide init zsh)"
