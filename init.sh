mkdir -p ~/.backup
ln -snf `pwd`/vimrc ~/.vimrc
ln -snf `pwd`/tmux.conf ~/.tmux.conf
ln -snf `pwd`/zshrc.local ~/.zshrc.local
ln -snf `pwd`/zshrc.pre ~/.zshrc.pre
ln -snf `pwd`/gitconfig ~/.gitconfig
ln -snf `pwd`/screenrc ~/.screenrc
wget -O ~/.zshrc http://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
