# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#enable automatic load enviroment variable
#eval "$(direnv hook zsh)"

DOTFILES=$HOME/dotfiles
ZSHTOOLS=$DOTFILES/zsh/bin
CONFIGS=$HOME/dotfiles/config

#add my scripts to path
PATH=$PATH:$DOTFILES/cml/bin
if [ -d "$DOTFILES/cml/bin/uber" ]; then
PATH=$PATH:"$DOTFILES/cml/bin/uber"
fi

# enable zsh plugins
source $ZSHTOOLS/powerlevel10k/powerlevel10k.zsh-theme
source $ZSHTOOLS/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $ZSHTOOLS/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSHTOOLS/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZSHTOOLS/zsh-you-should-use/you-should-use.plugin.zsh
source $ZSHTOOLS/zsh-auto-notify/auto-notify.plugin.zsh


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $CONFIGS/.p10k.zsh ]] || source $CONFIGS/.p10k.zsh


# bind zsh command line to vim
bindkey -v
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# disable auto notify based on commands
AUTO_NOTIFY_IGNORE+=(fzf rg)

export EDITOR="vim"
export LSCOLORS=ExFxBxDxCxegedabagacad
export FZF_DEFAULT_COMMAND='fd'

ALIAS="$CONFIGS/.alias.sh"
if [ -f $ALIAS ]; then
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


open_with_fzf() {
    fd -t f -H -I | fzf | xargs -ro code 
}
# open_with_fzf() {
#     fd -t f -H -I | fzf -m --preview="xdg-mime query default {}" | xargs -ro -d "\n" xdg-open 2>&-
# }
cd_with_fzf() {
    cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)" 
}

zle -N cd_with_fzf cd_with_fzf
zle -N open_with_fzf open_with_fzf
bindkey ^F cd_with_fzf
bindkey ^O open_with_fzf