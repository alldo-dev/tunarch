#!/bin/sh

UTILS_FILE=/home/$(whoami)/.local/share/tunarch/utils.sh 

if [ ! -f "$UTILS_FILE" ]; then
    echo -e "No utilities file (utils.sh) for tunarchy found under /home/$(whoami)/.local/share/"
    exit 1
fi

source "$UTILS_FILE" 


_logColor "$MAGENTA" "sddm - must have" "Installing sddm software:"
_logColor "$MAGENTA" "sddm - must have" "sddm | simple desktop display manager and login screen"
_logColor "$MAGENTA" "sddm - must have" "qt5-graphical effects | provides visual effects for qt user interfaces"
_logColor "$MAGENTA" "sddm - must have" "qt5-quickcontrols2 | adds control functionality for qt user interfaces"
_logColor "$MAGENTA" "sddm - must have" "qt5-svg | svg renderer for qt user interfaces"
_logColor "$MAGENTA" "sddm - must have" "sddm-theme-sugar-candy | sugar candy theme for sddm"


yay -S --noconfirm --needed \
	sddm \
	qt5-graphicaleffects \
	qt5-quickcontrols2 \
	qt5-svg \
	sddm-theme-sugar-candy
  
