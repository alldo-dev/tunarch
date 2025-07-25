#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: sddm-wallpaper.sh <FOR_USER>"
    echo "Example: 'sh sddm-wallpaper.sh myusername'"
    exit 1 # error
fi

FOR_USER=$1

#terminal colors
BLACK="\u001b[30m"
RED="\u001b[31m"
GREEN="\u001b[32m"
YELLOW="\u001b[33m"
BLUE="\u001b[34m"
MAGENTA="\u001b[35m"
CYAN="\u001b[36m"
WHITE="\u001b[37m"


#------------------------------------------------------------------------------
# util functions
#------------------------------------------------------------------------------

_logColor() {
    if [ $# -ne 3 ]; then
        echo "Usage: _logColor <header_color> <header> <header_message>"
        echo "Example: _logColor '\u001b[32m' '[_logColor]' 'my message'"
    else
        HEADER_COLOR="$1"
        HEADER="$2"
        HEADER_MSG="$3"
        echo -e "${HEADER_COLOR}[${HEADER}] ${WHITE}${HEADER_MSG}"
    fi
}

# Creates cache folder
CACHE_DIR="/home/$FOR_USER/.cache/tunarch" 
_createCacheDir(){
    if [ ! -d $CACHE_DIR]; then
	mkdir -p $CACHE_DIR
	notify-send "Created tunarch cache directory at $CACHE_DIR"
	echo $CACHE_DIR
    fi
    echo $CACHE_DIR
}


LOG_HEADER="sddm-wallpaper.sh"

_logColor "$YELLOW" "$LOG_HEADER" "running scripts/wallpaper.sh"

WALLPAPER="$(cat "$CACHE_DIR/current_wallpaper")"
WALLPAPER_FILENAME="$(cat "$CACHE_DIR/current_wallpaper")"
EXTENSION="${wallpaper##*.}"

SDDM_THEME=Sugar-Candy
SDDM_BACKGROUNDS_DIR="/usr/share/sddm/themes/$SDDM_THEME/Backgrounds"

if [ ! -f "/home/$FOR_USER/.local/share/tunarch/sddm/theme.conf" ]; then
    sddm_theme_conf="/home/$FOR_USER/.local/share/tunarch/sddm/theme.conf"
fi

if [ ! -f "$WALLPAPER" ]; then
    notify-send "file $WALLPAPER Does not exist"
    _logColor "$RED" "$LOG_HEADER" " file $WALLPAPER Does not exist"
fi 

echo $WALLPAPER

_logColor "$GREEN" "$LOG_HEADER" "setting the sddm background to $WALLPAPER"

if [ ! -d /etc/sddm.conf.d/ ]; then
    mkdir /etc/sddm.conf.d
    _logColor "$GREEN" "$LOG_HEADER" "Directory /etc/sddm.conf.d created"
fi

cp /home/$FOR_USER/.local/share/tunarch/sddm/sddm.conf /etc/sddm.conf.d/
_logColor "$GREEN" "$LOG_HEADER" "sddm config updated at /etc/sddm.conf.d/sddm.conf"

cp $WALLPAPER $SDDM_BACKGROUNDS_DIR/wallpaper.$EXTENSION

sed -i "s|^Background=\".*\"|Background=\"Backgrounds/wallpaper.$EXTENSION\"|" /usr/share/sddm/themes/$sddm_theme/theme.conf

