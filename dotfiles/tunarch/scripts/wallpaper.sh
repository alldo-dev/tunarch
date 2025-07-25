#!/bin/bash

UTILS_FILE=/home/$(whoami)/.local/share/tunarch/utils.sh 

if [ ! -f "$UTILS_FILE" ]; then
    echo -e "No utilities file (utils.sh) for tunarchy found under /home/$(whoami)/.local/share/"
    exit 1
fi

source "$UTILS_FILE" 


_logColor "$YELLOW" "scripts/wallpaper" "running scripts/wallpaper.sh"

CACHE_DIR=$(_createCacheDir)
CURRENT_WALLPAPER="$CACHE_DIR/current_wallpaper"
DEFAULT_WALLPAPER="/home/$(whoami)/wallpapers/lofi1.jpg"

if [ ! -f "$DEFAULT_WALLPAPER" ]; then
    echo -e "No default wallpaper found for $DEFAULT_WALLPAPER"
    exit 1
fi

if [ ! -f "$CURRENT_WALLPAPER" ]; then
    notify-send "No current wallpaper has been found under $CACHE_DIR"
    notify-send "setting the default wallpaper to $DEFAULT_WALLPAPER"
    touch $CURRENT_WALLPAPER
    echo "$DEFAULT_WALLPAPER" > $CURRENT_WALLPAPER
Fi
