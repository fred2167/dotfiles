# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE="$HOME/.zsh_history" # Defines the path to your history file
HISTSIZE=10000                 # Maximum number of history entries in memory
SAVEHIST=10000                 # Maximum number of history entries saved to file
setopt appendhistory           # Appends new history entries to the history file
setopt extended_history        # Saves timestamps with history entries
setopt inc_append_history      # Appends history to file immediately after each command
setopt share_history           # Shares history between multiple active Zsh sessions

DOTFILES=$HOME/dotfiles

# add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# enable zsh plugins
[ -f $DOTFILES/zsh/zsh_tools_init.sh ] && source $DOTFILES/zsh/zsh_tools_init.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
CONFIGS=$DOTFILES/config
[[ ! -f $CONFIGS/.p10k.zsh ]] || source $CONFIGS/.p10k.zsh

# bind zsh command line to vim
bindkey -v

# MISCELLANEOUS
export EDITOR="vim"

# make man page have color using LESS
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# enable config files
if [[ -f $CONFIGS/.alias.sh ]]; then source $CONFIGS/.alias.sh; fi
if [[ -f $CONFIGS/.fzf_config.sh ]]; then source $CONFIGS/.fzf_config.sh; fi

# enable machine specific config
MACHINES=$DOTFILES/machines
if [[ "$(uname)" == "Linux" ]]; then {source $MACHINES/linuxrc.sh}; fi
if [[ "$(uname)" == "Darwin" ]]; then {source $MACHINES/macrc.sh}; fi

# add my shortcuts
if [[ -f "$DOTFILES/shortcuts/fzf-git.sh" ]]; then source "$DOTFILES/shortcuts/fzf-git.sh"; fi
if [[ -f "$DOTFILES/shortcuts/shortcuts.sh" ]]; then source "$DOTFILES/shortcuts/shortcuts.sh"; fi

# add Uber specific shortcuts
if [[ (-f "$DOTFILES/shortcuts/uber.sh") && ("$(whoami)" == "fredc")]]; then source "$DOTFILES/shortcuts/uber.sh"; fi

# conditionally hookup direnv when avaliable
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi