mkdir -p ~/.backup
ln -snf `pwd`/vimrc ~/.vimrc
ln -snf `pwd`/tmux.server.conf ~/.tmux.conf
ln -snf `pwd`/zshrc.local ~/.zshrc.local
ln -snf `pwd`/zshrc ~/.zshrc
ln -snf `pwd`/gitconfig ~/.gitconfig
ln -snf `pwd`/gitignore ~/.gitignore
# set up vim
#vim +BundleInstall! +qall
