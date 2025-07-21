#!/bin/bash

sddm_theme_name="sddm-sugar-candy"

source ~/.acr/utils.sh

if [ -d /usr/share/sddm/themes/$sddm_theme_name ]; then
    _logColor "$yellow" "sddm-theme" "configuring sddm theme to $sddm_theme_name"
    sudo cp ~/.acr/sddm/sddm.conf /usr/lib/sddm/sddm.conf.d/default.conf
fi
