#!/bin/sh

UTILS_FILE=/home/$(whoami)/.local/share/tunarch/utils.sh 

if [ ! -f "$UTILS_FILE" ]; then
    echo -e "No utilities file (utils.sh) for tunarchy found under /home/$(whoami)/.local/share/"
    exit 1
fi

source "$UTILS_FILE" 


_logColor "$MAGENTA" "extras" "extra tools and software"
_logColor "$MAGENTA" "extras" "btop | resources monitor in the terminal"
_logColor "$MAGENTA" "extras" "mpv | media player"


yay -S --noconfirm  \
  btop \
  unzip \
  mpv
  
