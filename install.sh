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

RICE="acr"
LOG_HEADER="${rice} installer"
REPO="alldo-dev/acr"
USER=$whoami
DOWNLOAD_DIR="/home/$USER/.local/share/acrarch"
ACR_SCRIPTS_DIR="$DOWNLOAD_DIR/dotfiles/acrarch/scripts"

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
        echo -e "${HEADER_COLOR}[${HEADER}] ${WHITE}${HEADER_MSG}"
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



#------------------------------------------------------------------------------
# Script Start
#------------------------------------------------------------------------------
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
_logColor "$cyan" "$log_header" "checking if git is already installed..."
if [[ $(_isInstalled "pacman" "git") == 0 ]]; then
    _logColor "$cyan" "$log_header" "git is already installed"
else
    _logColor "$cyan" "$log_header" "git is not installed, installing..."
    sudo pacman -Sy --noconfirm --needed git
fi

# REMOVE EXISTING DIR
_logColor "$cyan" "$log_header" "removing ${download_dir}"
rm -rf $download_dir

# CLONE REPO
_logColor "$cyan" "$log_header" "cloning ${repo} to ${download_dir}"
git clone "https://github.com/${repo}.git" "${download_dir}" >/dev/null


_logColor "$cyan" "$log_header" "Installation starting..."

# CREATE DOWNLOAD_DIR IF NO EXISTS
if [ ! -d $download_dir ]; then
    _logColor "$cyan" "$log_header" "creating directory in ${download_dir}"
    mkdir -p $download_dir
else
    _logColor "$cyan" "$log_header" "directory ${download_dir} exists, continuing..."
fi


# INSTALL FROM INSTALL DIR
for f in $download_dir/install/*.sh; do
    _logColor "$cyan" "$log_header" "running installation for $f"
    source "$f"
done

# ENABLING ACR SCRIPT HELPERS
for s in $acr_scripts_dir/*.sh; do
    _logColor "$cyan" "$log_header" "enabling utility script $s"
    sudo chmod +x $s
done


_logColor "$yellow" "$log_header" "checking if hyprctl exists"
if _checkCommandExists "hyprctl"; then
    _logColor "$green" "$log_header" "reloading hyprland..."
    hyprctl reload
else
    _logColor "$red" "$log_header" "cannot find the hyprctl command"
fi

# add the change sddm background script to the sudoers file
_logColor "$yellow" "$log_header" "adding specific scripts to sudoers files"

username=$(whoami)
custom_sudoers="/etc/sudoers.d/acr-sddm"
sudoers_entry="$username ALL=(ALL) NOPASSWD: /home/$username/.acr/dotfiles/acr/scripts/sddm-wallpaper.sh"

if [ ! -f "$custom_sudoers" ] || ! sudo grep -Fxq "$sudoers_entry" "$custom_sudoers"; then
    echo "Adding sudoers rule to $custom_sudoers..."
    echo "$sudoers_entry" | sudo tee "$custom_sudoers" > /dev/null
    sudo chmod 0440 "$custom_sudoers"
    echo "Custom sudoers rule added."
else
    echo "Custom sudoers rule already exists."
fi
