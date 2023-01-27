# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


DOTFILES=$HOME/dotfiles

# enable zsh plugins
ZSHTOOLS=$DOTFILES/zsh/bin
source $ZSHTOOLS/powerlevel10k/powerlevel10k.zsh-theme
source $ZSHTOOLS/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $ZSHTOOLS/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSHTOOLS/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZSHTOOLS/zsh-you-should-use/you-should-use.plugin.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
CONFIGS=$DOTFILES/config
[[ ! -f $CONFIGS/.p10k.zsh ]] || source $CONFIGS/.p10k.zsh

# bind zsh command line to vim
bindkey -v
# zsh substring search key binding
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# MISCELLANEOUS
export EDITOR="vim"
export LSCOLORS=ExFxBxDxCxegedabagacad

# make man page have color using LESS
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# enable alias
if [[ -f $CONFIGS/.alias.sh ]]; then source $CONFIGS/.alias.sh; fi

# enable machine specific config
MACHINES=$DOTFILES/machines
if [[ "$(uname)" == "Linux" ]]; then {source $MACHINES/linuxrc.sh}; fi
if [[ "$(uname)" == "Darwin" ]]; then {source $MACHINES/macrc.sh}; fi

# add my shortcuts
if [[ -f "$DOTFILES/shortcuts/shortcuts.sh" ]]; then source "$DOTFILES/shortcuts/shortcuts.sh"; fi

# add Uber specific shortcuts
if [[ -f "$DOTFILES/shortcuts/uber.sh" ]]; then source "$DOTFILES/shortcuts/uber.sh"; fi

