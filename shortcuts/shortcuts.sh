#!/bin/bash

open_with_fzf() {
    fd -t f -H -I | fzf --multi | xargs -ro code
}
cd_with_fzf() {
    cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview")"
}

# bind shortcusts to control keys
zle -N cd_with_fzf cd_with_fzf
zle -N open_with_fzf open_with_fzf
bindkey ^F cd_with_fzf
bindkey ^O open_with_fzf