mkdir -p ~/.backup
mkdir -p ~/.config/qtile
ln -snf `pwd`/vimrc ~/.vimrc
ln -snf `pwd`/tmux.conf ~/.tmux.conf
ln -snf `pwd`/qtile_config.py ~/.config/qtile/config.py
ln -snf `pwd`/gitconfig ~/.gitconfig
ln -snf `pwd`/gitignore ~/.gitignore
ln -snf `pwd`/autostart.sh ~/.autostart.sh

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

ln -snf `pwd`/ohmyzshrc ~/.zshrc
