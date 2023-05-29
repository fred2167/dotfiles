#!/bin/bash

if [[ "$(uname)" == "Darwin" ]];
then
	alias upw="op item get e6j2nznf3uasgobokmech6uvai --fields label=password | pbcopy"
	export DEVPOD_NO_SSHWRAP=1
	echo -e "`date +"%Y-%m-%d %H:%M:%S"` direnv hooking zsh"
	eval "$(direnv hook zsh)"
fi

if [[ "$(uname)" == "Linux" ]];
then
	export PATH="$HOME/.local/bin:$PATH"
fi

uinit (){
	cd $GOPATH
	git checkout main
	git pull
	arc cascade
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
	gitlog | rg $(whoami)
}

rmbranch(){
	git branch -r | rg origin/$(whoami) | sed 's#origin/###g' | xargs git push origin --delete
}
