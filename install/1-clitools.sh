#!/bin/sh

UTILS_FILE=/home/$(whoami)/.local/share/tunarch/utils.sh 

if [ ! -f "$UTILS_FILE" ]; then
    echo -e "No utilities file (utils.sh) for tunarchy found under /home/$(whoami)/.local/share/"
    exit 1
fi

source "$UTILS_FILE" 

HEADER="clitools"

_logColor "$MAGENTA" "$HEADER" "extra tools and software"
_logColor "$MAGENTA" "$HEADER" "unzip | decompression tool"


yay -S --noconfirm  \
  unzip
  
