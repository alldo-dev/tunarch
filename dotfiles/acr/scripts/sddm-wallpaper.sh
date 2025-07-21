#!/bin/bash

source ~/.acr/utils.sh
log_header="sddm-wallpaper.sh"

_logColor "$yellow" "$log_header" "running scripts/wallpaper.sh"

cacheDir=$(_createCacheDir)
wallpaper="$(cat "$cacheDir/current_wallpaper")"
wallpaper_filename="$(cat "$cacheDir/current_wallpaper")"
extension="${wallpaper##*.}"

sddm_theme=Sugar-Candy
sddm_backgrounds_dir="/usr/share/sddm/themes/$sddm_theme/Backgrounds"

if [ ! -f "$HOME/.acr/sddm/theme.conf" ]; then
    sddm_theme_conf="$HOME/.acr/sddm/theme.conf"
fi

if [ ! -f "$wallpaper" ]; then
    notify-send "file $wallpaper does not exist"
    _logColor "$red" "$log_header" " file $wallpaper does not exist"
fi 

echo $wallpaper

_logColor "$green" "log_header" "setting the sddm background to $wallpaper"

if [ ! -d /etc/sddm.conf.d/ ]; then
    sudo mkdir /etc/sddm.conf.d
    _logColor "$green" "$log_header" "Directory /etc/sddm.conf.d created"
fi

sudo cp $HOME/.acr/sddm/sddm.conf /etc/sddm.conf.d/
_logColor "$green" "$log_header" "sddm config updated at /etc/sddm.conf.d/sddm.conf"

sudo cp $wallpaper $sddm_backgrounds_dir/wallpaper.$extension

sudo sed -i "s|^Background=\".*\"|Background=\"wallpaper.$extension\"|" /usr/share/sddm/themes/$sddm_theme/theme.conf
