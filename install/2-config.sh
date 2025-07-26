#!/bin/sh

UTILS_FILE=/home/$(whoami)/.local/share/tunarch/utils.sh 

if [ ! -f "$UTILS_FILE" ]; then
    echo -e "No utilities file (utils.sh) for tunarchy found under /home/$(whoami)/.local/share/"
    exit 1
fi

source "$UTILS_FILE" 

_logColor "$CYAN" "$LOG_HEADER" "we need to add your user to the input group"
sudo usermod -a -G input $USER

_logColor "$CYAN" "$LOG_HEADER" "copying dotfiles to /home/$(whoami)/.config/"

# Copy the config files
cp -Rf /home/$(whoami)/.local/share/tunarch/dotfiles/* /home/$(whoami)/.config/

echo "source /home/$(whoami)/.local/share/tunarch/dotfiles/.bashrc" >/home/$(whoami)/.bashrc

