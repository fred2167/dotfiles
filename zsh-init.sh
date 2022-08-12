# install zsh powerlevel 10k, sytax-highlight, autosuggestion
mkdir zsh
TOOLS="$HOME/dotfiles/zsh"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git  $TOOLS/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $TOOLS/zsh-autosuggestions
git clone --depth=1 https://github.com/zdharma-continuum/fast-syntax-highlighting $TOOLS/fast-syntax-highlighting

# create soft link for rc  at home directory
ln -s $HOME/dotfiles/config/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/config/.vimrc $HOME/.vimrc
