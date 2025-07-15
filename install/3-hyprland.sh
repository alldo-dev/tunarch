#!/bin/sh

source ~/.acr/utils.sh
_logColor "$magenta" "hyprland - must have" "Installing hyprland software:"
_logColor "$magenta" "hyprland - must have" "hyprland | base wayland compositor"
_logColor "$magenta" "hyprland - must have" "dunst | notification daemon"
_logColor "$magenta" "hyprland - must have" "pipewire | audio processing engine"
_logColor "$magenta" "hyprland - must have" "wireplumber | session and policy manager for wireplumber"
_logColor "$magenta" "hyprland - must have" "xdg-desktop-portal-hyprland | lets other applications communicate with the compositor through D-Bus"
_logColor "$magenta" "hyprland - must have" "hyprpolkitagent | polkit authentication daemon"
_logColor "$magenta" "hyprland - must have" "qt5-wayland | qt functionality wrapper for wayland"
_logColor "$magenta" "hyprland - must have" "qt6-wayland | qt functionality wrapper for wayland"
_logColor "$magenta" "hyprland - must have" "hyrpland-qtutils | utility apps for dialogs and popups"
_logColor "$magenta" "hyprland - must have" "xdg-desktop-portal-gtk | lets other applications communicate with the compositor through D-Bus"


yay -S --noconfirm --needed \
  hyprland \
  dunst \
  pipewire \
  wireplumber \
  xdg-desktop-portal-hyprland \
  hyprpolkitagent \
  qt5-wayland \
  qt6-wayland \
  xdg-desktop-portal-gtk \
  hyprland-qtutils

# Start Hyprland on first session
echo "[[ -z \$DISPLAY && \$(tty) == /dev/tty1 ]] && exec Hyprland" >~/.bash_profile
