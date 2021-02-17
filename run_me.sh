#!/bin/bash
mv ~/.bashrc ~/.bashrc_orig
ln -fs ~/dotfiles/.bashrc ~/.bashrc
mv ~/.vimrc ~/.vimrc_orig
ln -fs ~/dotfiles/.vimrc ~/.vimrc
mv ~/.gitconfig ~/.gitconfig_orig
ln -fs ~/dotfiles/.gitconfig ~/.gitconfig
