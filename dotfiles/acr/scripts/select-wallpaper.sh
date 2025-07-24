#!/bin/bash

source $HOME/.acr/utils.sh

WALLPAPER_DIR="$HOME/wallpapers"


# Make sure WALLPAPER_DIR exists
if [ ! -d $WALLPAPER_DIR ]; then
    notify-send "$WALLPAPER_DIR does not exist"
    exit 1
fi

# Feed entries directly into rofi to avoid null byte issues
# SELECTED=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort | while read -r img; do
#     fname=$(basename "$img")
#     printf '%s\0icon\x1f%s\n' "$fname" "$img"
# done | rofi -dmenu -show-icons -p "Wallpaper" -config "$HOME/acr/dotfiles/rofi/wallpaper-select.rasi")
#

SELECTED=$( find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read file
        do
            echo -en "$file\x00icon\x1f$WALLPAPER_DIR/${file}\n"
        done | rofi -dmenu -replace -l 6 -config $HOME/.config/rofi/wallpaper-select.rasi)

# If the user made a selection, call the change-wallpaper script
if [[ -n "$SELECTED" ]]; then
    echo $SELECTED
    $HOME/.acr/dotfiles/acr/scripts/change-wallpaper.sh "$WALLPAPER_DIR/$SELECTED"
fi

