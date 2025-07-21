#!/bin/bash

source "$HOME/.acr/utils.sh"

_logColor "$yellow" "scripts/wallpaper" "running scripts/wallpaper.sh"

cacheDir=$(_createCacheDir)
current_wallpaper="$cacheDir/current_wallpaper"
default_wallpaper="$HOME/wallpapers/lofi1.jpg"

if [ ! -f "$current_wallpaper" ]; then
    notify-send "No current wallpaper has been found under $cacheDir"
    notify-send "setting the default wallpaper to $default_wallpaper"
    touch $current_wallpaper
    echo "$default_wallpaper" > $current_wallpaper
fi
