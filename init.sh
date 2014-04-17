mkdir -p ~/.backup
ln -snf `pwd`/vimrc ~/.vimrc
ln -snf `pwd`/tmux.conf ~/.tmux.conf
ln -snf `pwd`/zshrc.local ~/.zshrc.local
ln -snf `pwd`/gitconfig ~/.gitconfig
wget -O ~/.zshrc http://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
