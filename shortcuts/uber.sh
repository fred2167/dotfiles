#!/bin/bash

if [[ "$(uname)" == "Darwin" ]];
then
alias myrider="echo 'ff5f881b-c584-41f5-9222-8e0e726c830f' | tr -d '\n' | tee >(pbcopy)"
fi

uinit (){
	cd ~/go-code
	git checkout main
	git pull
	arc cascade
	cd ~/go-code/src/code.uber.internal/amd/amd-api
	make setup
	make test
}

ufmt() {
	upstream_branch=$(git rev-parse --abbrev-ref --symbolic-full-name @{u})
	change_files=$(git diff --name-only HEAD $upstream_branch | grep .go | sed 's|src|'$GOPATH'/src|g')
	echo "Formatting following files, Press enter to continue..."
	echo "$change_files" | sed 's|'$GOPATH'||g'
	read
	echo $change_files | xargs gofmt -w
	echo $change_files | xargs goimports -w
	echo "Done formatting......"
}

mydiff(){
	gitlog | grep fredc
}
