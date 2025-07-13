#!/bin/sh

source ~/.acr/utils.sh
_logColor "$cyan" "$log_header" "Installing Hyprland software:"
echo -e "hprland | base wayland compositor"
echo -e "hyprpolkitagent | polkit authentication daemon"
echo -e "hyrpland-qtutils | utility apps for dialogs and popups"
echo -e "rofi | ui window toolkit"
echo -e "waybar | wayland bar"
echo -e "xdg-desktop-portal-hyprland | lets other applications communicate with the compositor through D-Bus"
echo -e "xdg-desktop-portal-gtk | lets other applications communicate with the compositor through D-Bus"


yay -S --noconfirm --needed \
  hyprland hyprpolkitagent hyprland-qtutils \
  rofi wofi waybar \
  xdg-desktop-portal-hyprland xdg-desktop-portal-gtk

# Start Hyprland on first session
echo "[[ -z \$DISPLAY && \$(tty) == /dev/tty1 ]] && exec Hyprland" >~/.bash_profile
