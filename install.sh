#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

$SCRIPT_DIR/zsh/install.sh
$SCRIPT_DIR/vim/install.sh
$SCRIPT_DIR/tools/install.sh