#!/bin/sh

UTILS_FILE=/home/$(whoami)/.local/share/tunarch/utils.sh 

if [ ! -f "$UTILS_FILE" ]; then
    echo -e "No utilities file (utils.sh) for tunarchy found under /home/$(whoami)/.local/share/"
    exit 1
fi

source "$UTILS_FILE" 

WALLPAPERS_DIR="/home/$(whoami)/wallpapers"

_logColor "$CYAN" "$LOG_HEADER" "installing intial wallpapers"

if [ ! -d "$WALLPAPERS_DIR" ]; then
    _logColor "$YELLOW" "$LOG_HEADER" "wallpaper directory does not exist under $WALLPAPERS_DIR, creating one..."
    mkdir "$WALLPAPERS_DIR"
fi

# Copy the config files
_logColor "$CYAN" "$LOG_HEADER" "copying initial set of wallpapers to $WALLPAPERS_DIR"
cp -R $RICE_DIR/wallpapers/* $WALLPAPERS_DIR
