 #!/bin/bash
export FZF_DEFAULT_COMMAND='fd -E *test.go'
alias uuidgen="uuidgen | tr '[A-Z]' '[a-z]' | tr -d '\n' | tee >(pbcopy)"
