SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR/bin
cat $SCRIPT_DIR/list.txt | xargs -I % git clone --depth=1 %

ln -s $SCRIPT_DIR/.zshrc $HOME/.zshrc