#!/bin/bash

UTILS_FILE=/home/$(whoami)/.local/share/tunarch/utils.sh 

if [ ! -f "$UTILS_FILE" ]; then
    echo -e "No utilities file (utils.sh) for tunarchy found under /home/$(whoami)/.local/share/"
    exit 1
fi

source "$UTILS_FILE" 



while IFS= read -r line; do
    # If the line starts with # and the next line is not the lines to be added
    if [[ $line == \#HandleLidSwitchDocked=ignore ]]; then
        # Add the new lines
        echo "HandleLidSwitchDocked=ignore" | sudo tee -a /etc/systemd/logind.conf >/dev/null
	_logColor "$MAGENTA" "laptop-lid-handler" "adding HandleLidSwitchDocked=ignore to /etc/systemd/logind.conf"
    fi
    if [[ $line == \#HoldoffTimeoutSec=5s ]]; then
        # Add the new lines
        echo "HoldoffTimeoutSec=5s" | sudo tee -a /etc/systemd/logind.conf >/dev/null
	_logColor "$MAGENTA" "laptop-lid-handler" "adding HoldoffTimeoutSec=5s to /etc/systemd/logind.conf"
    fi
done </etc/systemd/logind.conf
