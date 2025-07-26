#!/bin/sh

UTILS_FILE=/home/$(whoami)/.local/share/tunarch/utils.sh 

if [ ! -f "$UTILS_FILE" ]; then
    echo -e "No utilities file (utils.sh) for tunarchy found under /home/$(whoami)/.local/share/"
    exit 1
fi

source "$UTILS_FILE" 


_logColor "$CYAN" "$LOG_HEADER" "The Following fonts will be installed"
echo -e "ttf-font-awesome"
echo -e "ttf-firacode-nerd"
echo -e "ttf-gohu-nerd"

#-------------------------------------------------------------------------------
# FONTS INSTALLATION
#-------------------------------------------------------------------------------

# https://archlinux.org/groups/x86_64/nerd-fonts/

# FIRA CODE
yay -Sy --noconfirm --needed ttf-font-awesome ttf-firacode-nerd

mkdir -p /home/$(whoami)/.local/share/fonts

if ! fc-list | grep -qi "FiraCode Nerd Font"; then
  cd /tmp
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip
  unzip FiraCode.zip -d FiraCodeFont
  cp FiraCodeFont/FiraCodeNerdFont-Regular.ttf /home/$(whoami)/.local/share/fonts
  cp FiraCodeFont/FiraCodeNerdFont-Bold.ttf /home/$(whoami)/.local/share/fonts
  cp FiraCodeFont/FiracodeNerdFont-Italic.ttf /home/$(whoami)/.local/share/fonts
  cp FiraCodeFont/FiraCode-BoldItalic.ttf /home/$(whoami)/.local/share/fonts
  rm -rf FiraCode.zip FiraCodeFont
  fc-cache
  cd -
fi

if ! fc-list | grep -qi "GohuFont"; then
  cd /tmp
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Gohu.zip
  unzip Gohu.zip -d GohuFont
  cp GohuFont/GohuFont11NerdFontMono-Regular.ttf /home/$(whoami)/.local/share/fonts
  cp GohuFont/GohuFont11NerdFont-Regular.ttf /home/$(whoami)/.local/share/fonts
  cp GohuFont/GohuFont14NerdFontMono-Regular.ttf /home/$(whoami)/.local/share/fonts
  cp GohuFont/GohuFont14NerdFont-Regular.ttf /home/$(whoami)/.local/share/fonts
  rm -rf GohuFont.zip GohuFont
  fc-cache
  cd -
fi

