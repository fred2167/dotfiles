# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#enable automatic load enviroment variable
eval "$(direnv hook zsh)"

DOTFILES=$HOME/dotfiles
ZSHTOOLS=$DOTFILES/zsh
CONFIGS=$HOME/dotfiles/config

# enable power prompt
source $ZSHTOOLS/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $CONFIGS/.p10k.zsh ]] || source $CONFIGS/.p10k.zsh

# enable zsh syntax highlight
source $ZSHTOOLS/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# enable zsh autosuggestions
source $ZSHTOOLS/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey -v
export EDITOR="vim"
export LSCOLORS=ExFxBxDxCxegedabagacad

ALIAS="$CONFIGS/.alias.sh"
if [ -f "$ALIAS" ]; then
       source $ALIAS
fi

# make man page have color using LESS
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
