#!/bin/sh
clear

#------------------------------------------------------------------------------
# variable declaration
#------------------------------------------------------------------------------

ASCII_ART=$(cat <<EOF
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                                                                                         │
│                                                                                         │
│  sdSS_SSSSSSbs   .S       S.    .S_sSSs     .S_SSSs     .S_sSSs      sSSs   .S    S.    │
│  YSSS~S%SSSSSP  .SS       SS.  .SS~YS%%b   .SS~SSSSS   .SS~YS%%b    d%%SP  .SS    SS.   │
│       S%S       S%S       S%S  S%S   \`S%b  S%S   SSSS  S%S   \`S%b  d%S'    S%S    S%S   │
│       S&S       S&S       S&S  S&S    S&S  S&S  SSS%S  S&S   .S*S  S&S     S&S  SSS&S   │
│       S&S       S&S       S&S  S&S    S&S  S&S    S&S  S&S_sdSSS   S&S     S&S    S&S   │
│       S*S       S*S.     .S*S  S*S    S*S  S*S    S*S  S*S    S%S  S*S.    S*S    S*S   │
│       S*S        SSSbs_sdSSS   S*S    S*S  S*S    S*S  S*S    S&S   SSSbs  S*S    S*S   │
│       S*S         YSSP~YSSY    S*S    SSS  SSS    S*S  S*S    SSS    YSSP  SSS    S*S   │
│       SP                       SP                 SP   SP                         SP    │
│       Y                        Y                  Y    Y                          Y     │
│                                                                                         │
│                                                                                         │
└─────────────────────────────────────────────────────────────────────────────────────────┘
EOF
)

RICE="tunarch"
LOG_HEADER="${RICE} installer"
REPO="alldo-dev/tunarch"
USER="$(whoami)"
RICE_DIR="/home/$USER/.local/share/$RICE"
SCRIPTS_DIR="$RICE_DIR/dotfiles/$RICE/scripts"

#terminal colors
BLACK="\u001b[30m"
RED="\u001b[31m"
GREEN="\u001b[32m"
YELLOW="\u001b[33m"
BLUE="\u001b[34m"
MAGENTA="\u001b[35m"
CYAN="\u001b[36m"
WHITE="\u001b[37m"


#------------------------------------------------------------------------------
# util functions
#------------------------------------------------------------------------------

_logColor() {
    if [ $# -ne 3 ]; then
        echo "Usage: _logColor <header_color> <header> <header_message>"
        echo "Example: _logColor '\u001b[32m' '[_logColor]' 'my message'"
    else
        HEADER_COLOR="$1"
        HEADER="$2"
        HEADER_MSG="$3"
        echo -e "${HEADER_COLOR}[${HEADER}]${WHITE} ${HEADER_MSG}"
    fi
}

# Check if package is installed
_isInstalled() {
    if [ $# -ne 2 ]; then
        echo "Usage: _isInstalled <package manager> <package>"
        echo "Example: _isInstalled 'pacman' 'grep'" 
    else
	case $1 in
	    pacman)
	        PACKAGE="$2"
                CHECK="$(sudo pacman -Qs --color always "${PACKAGE}" | grep "local" | grep "${PACKAGE} ")"
                if [ -n "${CHECK}" ]; then
                    echo 0 #'0' means 'true' in Bash
                    return #true
                fi
                echo 1 #'1' means 'false' in Bash
                return #false
	        ;;
	    yay)
		;;
	    *)
		;;
	esac
    fi
}

# Check if command exists
_checkCommandExists() {
    if [ $# -ne 1 ]; then
        echo "Usage: _checkCommandExists <command>"
        echo "Example: _checkCommandExists 'grep'" 
        return 2
    fi

    if command -v "$1" >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# TRAP helper function
catch_errors() {
    _logColor "$RED" "$LOG_HEADER" "SOMETHING WENT WRONG WHILE INSTALLING TUNARCHY"
    _logColor "$RED" "" "You can retry the installation by running 'sh ~/.local/share/tunarchy/install.sh'"
}


#------------------------------------------------------------------------------
# Script Start
#------------------------------------------------------------------------------
trap catch_errors ERR

echo -e "\n$ASCII_ART\n"
echo -e "Thank you for using aColdRice(ACR) - ArchLinux"
echo -e "In order to set-up the customized desktop environment"
echo -e "we need to make sure specific software is installed"
echo -e "the installer needs super-user (sudo) permission to"
echo -e "install it.\n"

while true; do
    read -p "DO YOU WANT TO START THE INSTALLATION NOW? (y/N): " yn
    case $yn in
        [Yy]* ) echo "STARTING INSTALLATION"; break;;
        [Nn]* ) echo "INSTALLATION CANCELLED";exit;;
        * ) echo "Please answer yes or no.";;
    esac
done


# GIT
_logColor "$CYAN" "$LOG_HEADER" "checking if git is already installed..."
if [[ $(_isInstalled "pacman" "git") == 0 ]]; then
    _logColor "$CYAN" "$LOG_HEADER" "git is already installed"
else
    _logColor "$CYAN" "$LOG_HEADER" "git is not installed, installing..."
    sudo pacman -Sy --noconfirm --needed git
fi

# REMOVE EXISTING DIR
_logColor "$CYAN" "$LOG_HEADER" "removing ${RICE_DIR}"
rm -rf $RICE_DIR

# CLONE REPO
_logColor "$CYAN" "$LOG_HEADER" "cloning ${REPO} to ${RICE_DIR}"
git clone "https://github.com/${REPO}.git" "${RICE_DIR}" >/dev/null


_logColor "$CYAN" "$LOG_HEADER" "Installation starting..."

# CREATE RICE_DIR IF NO EXISTS
if [ ! -d $RICE_DIR ]; then
    _logColor "$CYAN" "$LOG_HEADER" "creating directory in ${RICE_DIR}"
    mkdir -p $RICE_DIR
else
    _logColor "$CYAN" "$LOG_HEADER" "directory ${RICE_DIR} exists, continuing..."
fi


# INSTALL FROM INSTALL DIR
for f in $RICE_DIR/install/*.sh; do
    _logColor "$CYAN" "$LOG_HEADER" "running installation for $f"
    source "$f"
done

# ENABLING TUNARCH SCRIPT HELPERS
for s in $SCRIPTS_DIR/*.sh; do
    _logColor "$CYAN" "$LOG_HEADER" "enabling utility script $s"
    sudo chmod +x $s
done


_logColor "$YELLOW" "$LOG_HEADER" "checking if hyprctl exists"
if _checkCommandExists "hyprctl"; then
    _logColor "$GREEN" "$LOG_HEADER" "reloading hyprland..."
    hyprctl reload
else
    _logColor "$RED" "$LOG_HEADER" "cannot find the hyprctl command"
fi

# add the change sddm background script to the sudoers file
_logColor "$YELLOW" "$LOG_HEADER" "adding specific scripts to sudoers files"

USERNAME=$(whoami)
CUSTOM_SUDOERS="/etc/sudoers.d/tunarch-sddm"
SUDOERS_ENTRY="$USERNAME ALL=(root) NOPASSWD: $RICE_DIR/dotfiles/$RICE/scripts/sddm-wallpaper.sh"

if [ ! -f "$CUSTOM_SUDOERS" ] || ! sudo grep -Fxq "$SUDOERS_ENTRY" "$CUSTOM_SUDOERS"; then
    echo "Adding sudoers rule to $CUSTOM_SUDOERS..."
    echo "$SUDOERS_ENTRY" | sudo tee "$CUSTOM_SUDOERS" > /dev/null
    sudo chmod 0440 "$CUSTOM_SUDOERS"
    echo "Custom sudoers rule added."
else
    echo "Custom sudoers rule already exists."
fi
