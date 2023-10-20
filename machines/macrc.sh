 #!/bin/bash
export FZF_DEFAULT_COMMAND='fd'
alias uuidgen="uuidgen | tr '[A-Z]' '[a-z]' | tr -d '\n' | tee >(pbcopy)"
alias now="date +%s000 | tr -d '\n' | tee >(pbcopy)"

# find and replace
fr() {
    rg "$1" --files-with-matches -0 | xargs -0 sed -i "" "s/$1/$2/g"
}
