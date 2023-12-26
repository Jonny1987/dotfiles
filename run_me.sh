#!/bin/bash
[ ! -f ~/.bashr ] || mv ~/.bashrc ~/.bashrc_orig
ln -fs $(pwd)/.bashrc ~/.bashrc

[ ! -f ~/.vimrc ] || mv ~/.vimrc ~/.vimrc_orig
ln -fs $(pwd)/.vimrc ~/.vimrc

[ ! -f ~/.gitconfig ] || mv ~/.gitconfig ~/.gitconfig_orig
ln -fs $(pwd)/.gitconfig ~/.gitconfig
