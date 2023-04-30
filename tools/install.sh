#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine="Linux";;
    Darwin*)    machine="Mac";;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [[ $machine = "Linux" ]]
then
    if [[ $(whoami) == "fredc"]] then sudo dpkg -i $SCRIPT_DIR/deb/*.deb fi # install tools on devpod

    cat $SCRIPT_DIR/list.txt | xargs -I % sudo apt install %
else
    cat $SCRIPT_DIR/list.txt | xargs -I % brew install %
fi

cat $SCRIPT_DIR/git-delta-config >> ~/.gitconfig