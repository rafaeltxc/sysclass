# Home files
cp ./dotfiles/tmux.conf $HOME/.tmux.conf
cp ./dotfiles/vimrc $HOME/.vimrc
cp ./dotfiles/zshrc $HOME/.zshrc

cp -r ./config/ncspot $HOME/ncspot
cp -r ./config/vim $HOME/vim
cp -r ./config/zsh $HOME/zsh

# Local files
cp ./local/bin/vm /usr/local/bin/vm

cp -r ./local/lib/llama /usr/local/lib/llama
cp -r ./local/lib/vm /usr/local/lib/vm

# Skel (for new profiles)
cp ./dotfiles/tmux.conf /etc/skel/.tmux.conf
cp ./dotfiles/vimrc /etc/skel/.vimrc
cp ./dotfiles/zshrc /etc/skel/.zshrc

cp -r ./config/ncspot /etc/skel/ncspot
cp -r ./config/vim /etc/skel/vim
cp -r ./config/zsh /etc/skel/zsh
