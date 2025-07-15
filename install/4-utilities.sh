#!/bin/sh

source ~/.acr/utils.sh
_logColor "$cyan" "$log_header" "Installing utility software:"
_logColor "$magenta" "\[utilities\]" "Installing utility software:"
_logColor "$magenta" "\[utilities\]" "rofi | application laucher"
_logColor "$magenta" "\[utilities\]" "waybar | wayland status bar"


yay -S --noconfirm --needed \
  rofi waybar
