#!/bin/sh

UTILS_FILE=/home/$(whoami)/.local/share/utils.sh 

if [ ! -f "$UTILS_FILE" ]; then
    echo -e "No utilities file (utils.sh) for tunarchy found under /home/$(whoami)/.local/share/"
fi

source "$UTILS_FILE" 

_logColor "$CYAN" "$LOG_HEADER" "making sure yay is installed..."

sudo pacman -S --needed --noconfirm base-devel

if ! command -v yay &>/dev/null; then
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin
  makepkg -si --noconfirm
  cd ~
  rm -rf yay-bin
fi
