#!/bin/bash

# Function to create symbolic link and backup existing file if it exists
create_link() {
  local src=$1
  local dest=$2
  if [ -f $dest ]; then
    mv $dest ${dest}_orig
  fi
  ln -fs $(pwd)/$src $dest
}

# Ask user for platform
read -p "Are you using Linux or macOS? (Enter 'linux' or 'mac'): " platform

# Set the shell configuration file based on the platform
if [ "$platform" == "linux" ]; then
  shell_rc=".bashrc"
elif [ "$platform" == "mac" ]; then
  shell_rc=".zshrc"
else
  echo "Invalid platform specified. Please run the script again and enter 'linux' or 'mac'."
  exit 1
fi

# Create links for the shell configuration file, .vimrc, and .gitconfig
create_link $shell_rc ~/$shell_rc
create_link .vimrc ~/.vimrc
create_link .gitconfig ~/.gitconfig

echo "Configuration files have been linked successfully."
