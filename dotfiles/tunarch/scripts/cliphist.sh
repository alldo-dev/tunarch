#!/bin/bash


ROFI_CONFIG=~/.config/rofi/cliphist-config.rasi

if [ ! -f "$ROFI_CONFIG" ]; then
    echo -e "no rofi config file found for cliphist in $ROFI_CONFIG"
    notify-send "no rofi config file found for cliphist in $ROFI_CONFIG"
    exit 1
fi

source "$UTILS_FILE" 



case $1 in
    # delete old item
    d)
        cliphist list | rofi -dmenu -replace -config $ROFI_CONFIG | cliphist delete
        ;;
    # wipe database
    w)
        if [ $(echo -e "Clear\nCancel" | rofi -dmenu -config $ROFI_CONFIG) == "Clear" ]; then
            cliphist wipe
        fi
        ;;
    # catch-all
    *)
        cliphist list | rofi -dmenu -replace -config $ROFI_CONFIG | cliphist decode | wl-copy
        ;;
esac
