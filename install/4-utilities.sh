#!/bin/sh

source ~/.acr/utils.sh
_logColor "$cyan" "$log_header" "Installing utility software:"
_logColor "$magenta" "utilities" "Installing utility software:"
_logColor "$magenta" "utilities" "rofi | application laucher"
_logColor "$magenta" "utilities" "waybar | wayland status bar"
_logColor "$magenta" "utilities" "wl-clipboard | cli copy/paste utils for wayland"
_logColor "$magenta" "utilities" "cliphist | wayland clipboard manager with multimedia support"


yay -S --noconfirm --needed \
  rofi \
  waybar \
  wl-clipboard \
  cliphist

