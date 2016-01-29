mkdir -p ~/.backup
mkdir -p ~/.config/qtile
ln -snf `pwd`/vimrc ~/.vimrc
ln -snf `pwd`/tmux.conf ~/.tmux.conf
ln -snf `pwd`/zshrc.local ~/.zshrc.local
ln -snf `pwd`/zshrc ~/.zshrc
ln -snf `pwd`/qtile_config.py ~/.config/qtile/config.py
ln -snf `pwd`/gitconfig ~/.gitconfig
ln -snf `pwd`/gitignore ~/.gitignore

# set up vim
#vim +BundleInstall! +qall
