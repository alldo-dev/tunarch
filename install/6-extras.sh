#!/bin/sh

UTILS_FILE=/home/$(whoami)/.local/share/utils.sh 

if [ ! -f "$UTILS_FILE" ]; then
    echo -e "No utilities file (utils.sh) for tunarchy found under /home/$(whoami)/.local/share/"
fi

source "$UTILS_FILE" 


_logColor "$MAGENTA" "extras" "extra tools and software"
_logColor "$MAGENTA" "extras" "btop | resources monitor in the terminal"


yay -S --noconfirm  \
  btop \
  
