#!/bin/sh

source ~/.acr/utils.sh
_logColor "$magenta" "\[hyprland\]" "Installing hyprland software:"
_logColor "$magenta" "\[hyprland\]" "hprland | base wayland compositor"
_logColor "$magenta" "\[hyprland\]" "hyprpolkitagent | polkit authentication daemon"
_logColor "$magenta" "\[hyprland\]" "hyrpland-qtutils | utility apps for dialogs and popups"
_logColor "$magenta" "\[hyprland\]" "xdg-desktop-portal-hyprland | lets other applications communicate with the compositor through D-Bus"
_logColor "$magenta" "\[hyprland\]" "xdg-desktop-portal-gtk | lets other applications communicate with the compositor through D-Bus"


yay -S --noconfirm --needed \
  hyprland hyprpolkitagent hyprland-qtutils \
  xdg-desktop-portal-hyprland xdg-desktop-portal-gtk

# Start Hyprland on first session
echo "[[ -z \$DISPLAY && \$(tty) == /dev/tty1 ]] && exec Hyprland" >~/.bash_profile
