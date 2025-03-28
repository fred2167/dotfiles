#!/bin/bash
uinit (){
	cd $GOPATH
	git checkout main
	git pull origin main
	arc cascade -hc
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
	gitlog | rg $(whoami) | less
}

rmbranch(){
	git ls-remote | grep fredc | sed 's/.*\t//g' | xargs git push origin --delete
}

port_fowrad_michael_angelo(){
	if lsof -Pi :9999 -sTCP:LISTEN -t >/dev/null; then
    	echo "michanel angelo instance port foraward: Port 9999 is in use."
	else
    	ssh -fN -L 9999:localhost:5435 fredc@phx5-w83 -p 31117
 	fi
}

if [[ "$(uname)" == "Darwin" ]];
then
	export DEVPOD_NO_SSHWRAP=1
	echo -e "`date +"%Y-%m-%d %H:%M:%S"` direnv hooking zsh"
	eval "$(direnv hook zsh)"
	port_fowrad_michael_angelo
fi
