#!/bin/sh

source ~/.acr/utils.sh
_logColor "$magenta" "extras" "extra tools and software"
_logColor "$magenta" "extras" "btop | resources monitor in the terminal"


yay -S --noconfirm  \
  btop \
  
