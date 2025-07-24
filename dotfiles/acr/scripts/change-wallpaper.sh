#!/bin/bash

source ~/.acr/utils.sh

if [ $# -ne 1 ]; then
    echo "Usage: change-wallpaper <path-to-wallpaper>"
    echo "Example: 'sh change-wallpaper.sh path/to/wallpaper.jpg'"
    exit 1 # error
fi

_logColor "$yellow" "$log_header" "running scripts/change-wallpaper.sh"

wallpaper="$1"
wallpaper_extension="${wallpaper##*.}"
log_header="change-wallpaper.sh"

# check that the image extension is accepted
accepted_extensions=(jpg png jpeg webp svg)

is_accepted=false
for extension in "${accepted_extensions[@]}"; do
    if [[ $wallpaper_extension == $extension ]] ; then
	    is_accepted=true
    fi
done

if ! $is_accepted; then
    notify-send "file $wallpaper has an extension that is not accepted, only [ jpg png jpeg webp svg ] are accepted"
    _logColor "$red" "$log_header" "file $wallpaper has an extension that is not accepted, only [ jpg png jpeg webp svg ] are accepted"
    exit 1
fi


if [ ! -f "$wallpaper" ]; then
    notify-send "file $wallpaper does not exist"
    _logColor "$red" "$log_header" " file $wallpaper does not exist"
fi

# get or make cacheDir (from utils.sh)
cacheDir=$(_createCacheDir)
echo $wallpaper > "$cacheDir/current_wallpaper"

_logColor "$green" "log_header" "changing wallpaper to $wallpaper"
notify-send "changing wallpaper to $wallpaper"

sudo /home/$(whoami)/.acr/dotfiles/acr/scripts/sddm-wallpaper.sh $(whoami)
