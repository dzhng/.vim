#!/bin/bash

ln -fs $PWD/.prettierrc.json ~/.prettierrc.json
ln -fs $PWD/.vimrc ~/.vimrc
ln -fs $PWD/.zshrc ~/.zshrc

# download plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
