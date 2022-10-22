# install zsh powerlevel 10k, sytax-highlight, autosuggestion
TOOLS="$HOME/dotfiles/zsh"
if [ ! -d $TOOLS ]; then 
mkdir zsh

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git  $TOOLS/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $TOOLS/zsh-autosuggestions
git clone --depth=1 https://github.com/zdharma-continuum/fast-syntax-highlighting $TOOLS/fast-syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search $TOOLS/zsh-history-substring-search 
git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use.git $TOOLS/zsh-you-should-use

fi
# create soft link for rc  at home directory
ln -s $HOME/dotfiles/config/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/config/.vimrc $HOME/.vimrc
