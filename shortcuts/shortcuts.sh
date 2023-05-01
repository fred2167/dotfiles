#!/bin/bash

open_with_fzf() {
    fd -t f -H -I | fzf --multi --preview 'bat --color=always --style=numbers --line-range=:100 {}'| xargs -ro code
}
cd_with_fzf() {
    cd $HOME
    cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview")"
}

rf(){
    # Switch between Ripgrep launcher mode (CTRL-R) and fzf filtering mode (CTRL-F)
    rm -f /tmp/rg-fzf-{r,f}
    RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case --type-not bazel --type-not yaml --type-not json"
    INITIAL_QUERY="${*:-}"
    FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" \
    fzf --ansi \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --disabled --query "$INITIAL_QUERY" \
        --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
        --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
        --bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
        --bind "start:unbind(ctrl-r)" \
        --prompt '1. ripgrep> ' \
        --delimiter : \
        --header '╱ CTRL-R (ripgrep mode) ╱ CTRL-F (fzf mode) ╱' \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
        --bind 'enter:become(code --goto {1}:{2}:{3})'
}

# bind shortcusts to control keys
zle -N cd_with_fzf cd_with_fzf
zle -N open_with_fzf open_with_fzf
bindkey ^G cd_with_fzf
bindkey ^O open_with_fzf
