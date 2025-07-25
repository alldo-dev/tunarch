#!/bin/bash

SDDM_THEME_NAME="Sugar-Candy"

UTILS_FILE=/home/$(whoami)/.local/share/tunarch/utils.sh 

if [ ! -f "$UTILS_FILE" ]; then
    echo -e "No utilities file (utils.sh) for tunarchy found under /home/$(whoami)/.local/share/"
    echo 1
fi

source "$UTILS_FILE" 

if [ -d /usr/share/sddm/themes/$SDDM_THEME_NAME ]; then
    _logColor "$YELLOW" "sddm-theme" "configuring sddm theme to $SDDM_THEME_NAME"
    sudo cp $RICE_DIR/sddm/sddm.conf /usr/lib/sddm/sddm.conf.d/default.conf
fi
