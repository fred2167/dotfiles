export FZF_DEFAULT_COMMAND='fd'
alias uuidgen="uuidgen | tr '[A-Z]' '[a-z]' | tr -d '\n' | tee >(pbcopy)"