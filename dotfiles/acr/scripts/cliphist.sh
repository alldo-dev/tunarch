#!/bin/bash

case $1 in
    # delete old item
    d)
        cliphist list | rofi -dmenu -replace -config ~/.config/rofi/cliphist-config.rasi | cliphist delete
        ;;
    # wipe database
    w)
        if [ $(echo -e "Clear\nCancel" | rofi -dmenu -config ~/.config/rofi/config-short.rasi) == "Clear" ]; then
            cliphist wipe
        fi
        ;;
    # catch-all
    *)
        cliphist list | rofi -dmenu -replace -config ~/.config/rofi/cliphist-config.rasi | cliphist decode | wl-copy
        ;;
esac
