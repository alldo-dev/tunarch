#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: sddm-wallpaper.sh <user>"
    echo "Example: 'sh sddm-wallpaper.sh myusername'"
    exit 1 # error
fi

USER=$1

#terminal colors
black="\u001b[30m"
red="\u001b[31m"
green="\u001b[32m"
yellow="\u001b[33m"
blue="\u001b[34m"
magenta="\u001b[35m"
cyan="\u001b[36m"
white="\u001b[37m"


#------------------------------------------------------------------------------
# util functions
#------------------------------------------------------------------------------

_logColor() {
    if [ $# -ne 3 ]; then
        echo "Usage: _logColor <header_color> <header> <header_message>"
        echo "Example: _logColor '\u001b[32m' '[_logColor]' 'my message'"
    else
        header_color="$1"
        header="$2"
        header_msg="$3"
        echo -e "${header_color}[${header}] ${white}${header_msg}"
    fi
}

# Creates cache folder
acr_cacheDir="/home/$USER/.cache/acr" 
_createCacheDir(){
    if [ ! -d $acr_cacheDir ]; then
	mkdir -p $acr_cacheDir
	notify-send "Created acr cache directory at $acr_cacheDir"
	echo $acr_cacheDir
    fi
    echo $acr_cacheDir
}


log_header="sddm-wallpaper.sh"

_logColor "$yellow" "$log_header" "running scripts/wallpaper.sh"

cacheDir=$(_createCacheDir)
wallpaper="$(cat "$cacheDir/current_wallpaper")"
wallpaper_filename="$(cat "$cacheDir/current_wallpaper")"
extension="${wallpaper##*.}"

sddm_theme=Sugar-Candy
sddm_backgrounds_dir="/usr/share/sddm/themes/$sddm_theme/Backgrounds"

if [ ! -f "/home/$USER/.acr/sddm/theme.conf" ]; then
    sddm_theme_conf="/home/$USER/.acr/sddm/theme.conf"
fi

if [ ! -f "$wallpaper" ]; then
    notify-send "file $wallpaper does not exist"
    _logColor "$red" "$log_header" " file $wallpaper does not exist"
fi 

echo $wallpaper

_logColor "$green" "log_header" "setting the sddm background to $wallpaper"

if [ ! -d /etc/sddm.conf.d/ ]; then
    mkdir /etc/sddm.conf.d
    _logColor "$green" "$log_header" "Directory /etc/sddm.conf.d created"
fi

cp /home/$USER/.acr/sddm/sddm.conf /etc/sddm.conf.d/
_logColor "$green" "$log_header" "sddm config updated at /etc/sddm.conf.d/sddm.conf"

cp $wallpaper $sddm_backgrounds_dir/wallpaper.$extension

sed -i "s|^Background=\".*\"|Background=\"Backgrounds/wallpaper.$extension\"|" /usr/share/sddm/themes/$sddm_theme/theme.conf

