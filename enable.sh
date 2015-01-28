#!/usr/bin/env bash

# Copy non critical dot files without backup
cp -v conf/.curlrc ~/.curlrc
cp -v conf/.gitconfig ~/.gitconfig
cp -v conf/.gitignore_global ~/.gitignore_global

# Setup ZSH
if [[ -f '~/.zshrc' ]]; then
  mv ~/.zshrc ~/.zshrc.previous
fi
cp -v conf/.zshrc ~/.zshrc
mkdir -v ~/.zshrcd

# Install oh-my-zsh and modules
if [[ -d '~/.oh-my-zsh' ]]; then
  mv -f ~/.oh-my-zsh ~/.oh-my-zsh.previous
fi
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
(cd ~/.oh-my-zsh/themes/ && git clone https://github.com/Y4Rvik/gabriel-zsh.git gabriel && mv gabriel/gabriel.zsh-theme . && mv gabriel/gabriel-bira.zsh-theme .)
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting 

# Setup vim  
if [[ -f '~/.vimrc' ]]; then
  mv ~/.vimrc ~/.vimrc.previous
fi
cp -v conf/.vimrc ~/.vimrc

# Install vim modules
if [[ -d '~/.vim' ]]; then
  mv -f ~/.vim ~/.vim.previous
fi
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle
# Install Plugins
vim +PluginInstall +qall

# Setup tmux configs
if [[ -f '~/.tmux.conf' ]]; then
  mv ~/.tmux.conf ~/.tmux.conf.previous
fi
cp -v conf/.tmux.conf ~/.tmux.conf

# Setup tmuxinator 
if [[ -d '~/.tmuxinator' ]]; then
  mv -f ~/.tmuxinator ~/.tmuxinator.previous
fi
cp -vr conf/.tmuxinator ~/.tmuxinator 

# Install tmux-plugins
if [[ -d '~/.tmux' ]]; then
  mv -f ~/.tmux ~/.tmux.previous
fi
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# start a server but don't attach to it
tmux start-server
# create a new session but don't attach to it either
tmux new-session -d
# install the plugins
~/.tmux/plugins/tpm/scripts/install_plugins.sh
# killing the server is not required
tmux kill-server
