# link config files
ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/.emacs $HOME/.emacs
ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
mkdir -p $HOME/.config/alacritty
ln -s $HOME/dotfiles/alacritty.yml $HOME/.config/alacritty/alacritty.yml

# install Vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install Vim plugins
vim +PlugInstall +qall
