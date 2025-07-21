#!/bin/sh

source "$HOME/.acr/utils.sh"
wallpapers_dir="$HOME/wallpapers"

_logColor "$cyan" "$log_header" "installing intial wallpapers"

if [ ! -d "$wallpapers_dir" ]; then
    _logColor "$yellow" "$log_header" "wallpaper directory does not exist under $wallpapers_dir, creating one..."
    mkdir "$wallpapers_dir"
fi

# Copy the config files
_logColor "$cyan" "$log_header" "copying initial set of wallpapers to $wallpapers_dir"
cp -R $HOME/.acr/wallpapers/* $wallpapers_dir
