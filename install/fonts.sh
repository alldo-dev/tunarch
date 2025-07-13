#!/bin/sh

source ~/.acr/utils.sh
_logColor "$cyan" "$log_header" "The Following fonts will be installed"
echo -e "ttf-font-awesome"
echo -e "ttf-firacode-nerd"

#-------------------------------------------------------------------------------
# FONTS INSTALLATION
#-------------------------------------------------------------------------------

# https://archlinux.org/groups/x86_64/nerd-fonts/

# FIRA CODE
yay -Sy --noconfirm --needed ttf-font-awesome ttf-firacode-nerd

mkdir -p ~/.local/share/fonts

if ! fc-list | grep -qi "FiraCode Nerd Font"; then
  cd /tmp
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip
  unzip FiraCode.zip -d FiraCodeFont
  cp FiraCodeFont/FiraCodeNerdFont-Regular.ttf ~/.local/share/fonts
  cp FiraCodeFont/FiraCodeNerdFont-Bold.ttf ~/.local/share/fonts
  cp FiraCodeFont/FiracodeNerdFont-Italic.ttf ~/.local/share/fonts
  cp FiraCodeFont/FiraCode-BoldItalic.ttf ~/.local/share/fonts
  rm -rf FiraCode.zip FiraCodeFont
  fc-cache
  cd -
fi

