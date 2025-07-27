#!/bin/bash

UTILS_FILE=/home/$(whoami)/.local/share/tunarch/utils.sh 

if [ ! -f "$UTILS_FILE" ]; then
    echo -e "No utilities file (utils.sh) for tunarchy found under /home/$(whoami)/.local/share/"
    exit 1
fi

source "$UTILS_FILE" 


if [ $# -ne 1 ]; then
    echo "Usage: change-wallpaper <path-to-wallpaper>"
    echo "Example: 'sh change-wallpaper.sh path/to/wallpaper.jpg'"
    exit 1 # error
fi


WALLPAPER="$1"
WALLPAPER_EXTENSION="${wallpaper##*.}"
LOG_HEADER="change-wallpaper.sh"


_logColor "$YELLOW" "$LOG_HEADER" "running scripts/change-wallpaper.sh"

# check that the image extension is accepted
ACCEPTED_EXTENSIONS=(jpg png jpeg webp svg)

IS_ACCEPTED=false
for extension in "${ACCEPTED_EXTENSIONS[@]}"; do
    if [[ $WALLPAPER_EXTENSION == $EXTENSION ]] ; then
	    IS_ACCEPTED=true
    fi
done

if ! $IS_ACCEPTED; then
    notify-send "file $WALLPAPER Has an extension that is not accepted, only [ jpg png jpeg webp svg ] are accepted"
    _logColor "$RED" "$LOG_HEADER" "file $WALLPAPER Has an extension that is not accepted, only [ jpg png jpeg webp svg ] are accepted"
    exit 1
fi


if [ ! -f "$WALLPAPER" ]; then
    notify-send "file $WALLPAPER Does not exist"
    _logColor "$RED" "$LOG_HEADER" " file $WALLPAPER Does not exist"
fi

# get or make cacheDir (from utils.sh)
CACHE_DIR=$(_createCacheDir)
touch "$CACHE_DIR/current_wallpaper"
echo $WALLPAPER >"$CACHE_DIR/current_wallpaper"

_logColor "$GREEN" "LOG_HEADER" "changing wallpaper to $WALLPAPER"
notify-send "changing wallpaper to $WALLPAPER"

# change swww wallpaper
# swww img $WALLPAPER --transition-type random
matugen image $WALLPAPER

# change SDDM wallpaper
sudo $RICE_DIR/dotfiles/$RICE/scripts/sddm-wallpaper.sh $(whoami)

# change hyprlock wallpaper
HYPRLOCK_TPL="$RICE_DIR/templates/hyprlock.tpl"
sed "s|<%PATH_TO_WALLPAPER%>|$WALLPAPER|g" "$HYPRLOCK_TPL" > "/home/$(whoami)/.config/hypr/hyprlock.conf"
