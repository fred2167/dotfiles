#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

mkdir $SCRIPT_DIR/bin
cd $SCRIPT_DIR/bin

cat $SCRIPT_DIR/list.txt | xargs -I % git clone --depth=1 %

ln -s $SCRIPT_DIR/.zshrc $HOME/.zshrc
