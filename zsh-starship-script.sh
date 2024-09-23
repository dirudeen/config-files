#!/bin/bash

#show all running commands
set -x;
# exit script when there is an errors
set -e
# update the apt packages
sudo apt update;

# install zsh and nala
sudo apt install zsh nala -y;

#install ohmyzsh
if [ ! -d ~/.oh-my-zsh ]; then 
  # Install oh-my-zsh without running zsh after installation
  echo "Installing oh my zsh...";
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";  
  sleep 3;
  echo "Installing zsh-syntax-highlighting, zsh-autosuggestions and zsh-autocompletions...";
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting;
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions;
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions;
else
  echo "Oh My Zsh is already installed";
fi

# clone the config-file from my repo
if [ ! -d ~/config-files ]; then
  echo "clonning config-files";
  git clone https://github.com/dirudeen/config-files.git;
fi

#install starship
if [ which starship > /dev/null 2>&1 ]; then 
  echo "Installing starship...";
  curl -sS https://starship.rs/install.sh | sh;
  sleep 3;
  echo "copying starship.toml to config";
  mkdir -p ~/.config && cp ~/config-files/startship.toml ~/.config/
else
  echo "Starship is already installed";
fi

# replace the defautl zshrc to the one in the config files
rm -f ~/.zshrc && cp ~/config-files/.zshrc ~/;

# execute zsh to initialize OhMyZsh
exec zsh;

# source zshrc config to load all the plugins
source ~/.zshrc;
