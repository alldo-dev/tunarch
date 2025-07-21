#!/bin/sh

source ~/.acr/utils.sh
_logColor "$magenta" "sddm - must have" "Installing sddm software:"
_logColor "$magenta" "sddm - must have" "sddm | simple desktop display manager and login screen"
_logColor "$magenta" "sddm - must have" "qt5-graphical effects | provides visual effects for qt user interfaces"
_logColor "$magenta" "sddm - must have" "qt5-quickcontrols2 | adds control functionality for qt user interfaces"
_logColor "$magenta" "sddm - must have" "qt5-svg | svg renderer for qt user interfaces"
_logColor "$magenta" "sddm - must have" "sddm-theme-sugar-candy | sugar candy theme for sddm"


yay -S --noconfirm --needed \
	sddm \
	qt5-graphicaleffects \
	qt5-quickcontrols2 \
	qt5-svg \
	sddm-theme-sugar-candy
  
