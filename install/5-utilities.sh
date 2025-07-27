#!/bin/sh

UTILS_FILE=/home/$(whoami)/.local/share/tunarch/utils.sh 

if [ ! -f "$UTILS_FILE" ]; then
    echo -e "No utilities file (utils.sh) for tunarchy found under /home/$(whoami)/.local/share/"
    exit 1
fi

source "$UTILS_FILE" 


_logColor "$CYAN" "$log_header" "Installing utility software:"
_logColor "$MAGENTA" "utilities" "Installing utility software:"
_logColor "$MAGENTA" "utilities" "rofi | application laucher"
_logColor "$MAGENTA" "utilities" "waybar | wayland status bar"
_logColor "$MAGENTA" "utilities" "wl-clipboard | cli copy/paste utils for wayland"
_logColor "$MAGENTA" "utilities" "cliphist | wayland clipboard manager with multimedia support"
_logColor "$MAGENTA" "utilities" "pavucontrol| audio volume control"
_logColor "$MAGENTA" "utilities" "libnotify| notification library"
_logColor "$MAGENTA" "utilities" "inotify-tools | interface for inotify used by various other tools"
_logColor "$MAGENTA" "utilities" "swww | wayland wallpaper service"

yay -S --noconfirm --needed \
  rofi \
  waybar \
  wl-clipboard \
  cliphist \
  pavucontrol \
  libnotify \
  inotify-tools \
  swww
