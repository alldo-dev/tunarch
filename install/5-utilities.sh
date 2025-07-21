#!/bin/sh

source ~/.acr/utils.sh
_logColor "$cyan" "$log_header" "Installing utility software:"
_logColor "$magenta" "utilities" "Installing utility software:"
_logColor "$magenta" "utilities" "rofi | application laucher"
_logColor "$magenta" "utilities" "waybar | wayland status bar"
_logColor "$magenta" "utilities" "wl-clipboard | cli copy/paste utils for wayland"
_logColor "$magenta" "utilities" "cliphist | wayland clipboard manager with multimedia support"
_logColor "$magenta" "utilities" "pavucontrol| audio volume control"
_logColor "$magenta" "utilities" "libnotify| notification library"
_logColor "$magenta" "utilities" "inotify-tools | interface for inotify used by various other tools"


yay -S --noconfirm --needed \
  rofi \
  waybar \
  wl-clipboard \
  cliphist \
  pavucontrol \
  libnotify \
  inotify-tools
