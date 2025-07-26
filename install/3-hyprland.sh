#!/bin/sh

UTILS_FILE=/home/$(whoami)/.local/share/tunarch/utils.sh 

if [ ! -f "$UTILS_FILE" ]; then
    echo -e "No utilities file (utils.sh) for tunarchy found under /home/$(whoami)/.local/share/"
fi

source "$UTILS_FILE" 

_logColor "$MAGENTA" "hyprland - must have" "Installing hyprland software:"
_logColor "$MAGENTA" "hyprland - must have" "hyprland | base wayland compositor"
_logColor "$MAGENTA" "hyprland - must have" "dunst | notification daemon"
_logColor "$MAGENTA" "hyprland - must have" "pipewire | audio processing engine"
_logColor "$MAGENTA" "hyprland - must have" "wireplumber | session and policy manager for wireplumber"
_logColor "$MAGENTA" "hyprland - must have" "xdg-desktop-portal-hyprland | lets other applications communicate with the compositor through D-Bus"
_logColor "$MAGENTA" "hyprland - must have" "hyprpolkitagent | polkit authentication daemon"
_logColor "$MAGENTA" "hyprland - must have" "qt5-wayland | qt functionality wrapper for wayland"
_logColor "$MAGENTA" "hyprland - must have" "qt6-wayland | qt functionality wrapper for wayland"
_logColor "$MAGENTA" "hyprland - must have" "hyrpland-qtutils | utility apps for dialogs and popups"
_logColor "$MAGENTA" "hyprland - must have" "xdg-desktop-portal-gtk | lets other applications communicate with the compositor through D-Bus"
_logColor "$MAGENTA" "hyprland - must have" "hyprlock| simple, yet fast, multi-threaded and GPU-accelerated screen lock for Hyprland"


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
  hyprland-qtutils \
  hyprlock

# Start Hyprland on first session
echo "[[ -z \$DISPLAY && \$(tty) == /dev/tty1 ]] && exec Hyprland" >/home/$(whoami)/.bash_profile
