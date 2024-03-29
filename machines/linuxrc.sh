#!/bin/bash
alias fd="fdfind"
alias ls="exa"
alias ll="exa --long"
alias la="exa -al"
export FZF_DEFAULT_COMMAND='fdfind'

# find and replace
fr() {
    rg "$1" --files-with-matches -0 | xargs -0 sed -i "s/$1/$2/g"
}
