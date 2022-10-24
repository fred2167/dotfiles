#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ln -s $SCRIPT_DIR/.vimrc $HOME/.vimrc