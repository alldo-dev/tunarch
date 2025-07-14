#!/bin/sh
clear

#------------------------------------------------------------------------------
# variable declaration
#------------------------------------------------------------------------------
ascii_art='                                                           █████     
                                                          ░░███      
  ██████    ██████  ████████   ██████   ████████   ██████  ░███████  
 ░░░░░███  ███░░███░░███░░███ ░░░░░███ ░░███░░███ ███░░███ ░███░░███ 
  ███████ ░███ ░░░  ░███ ░░░   ███████  ░███ ░░░ ░███ ░░░  ░███ ░███ 
 ███░░███ ░███  ███ ░███      ███░░███  ░███     ░███  ███ ░███ ░███ 
░░████████░░██████  █████    ░░████████ █████    ░░██████  ████ █████
 ░░░░░░░░  ░░░░░░  ░░░░░      ░░░░░░░░ ░░░░░      ░░░░░░  ░░░░ ░░░░░ '


rice="acr"
log_header="${rice} installer"
repo="alldo-dev/acr"
download_dir="$HOME/.acr"

#terminal colors
black="\u001b[30m"
red="\u001b[31m"
green="\u001b[32m"
yellow="\u001b[33m"
blue="\u001b[34m"
magenta="\u001b[35m"
cyan="\u001b[36m"
white="\u001b[37m"


#------------------------------------------------------------------------------
# util functions
#------------------------------------------------------------------------------

_logColor() {
    if [ $# -ne 3 ]; then
        echo "Usage: _logColor <header_color> <header> <header_message>"
        echo "Example: _logColor '\u001b[32m' '[_logColor]' 'my message'"
    else
        header_color="$1"
        header="$2"
        header_msg="$3"
        echo -e "${header_color}[${header}]${white}${header_msg}"
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
	        package="$2"
                check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")"
                if [ -n "${check}" ]; then
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
echo -e "\n$ascii_art\n"
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

_logColor "$yellow" "$log_header" "checking if hyprctl exists"
if _checkCommandExists "hyprctl"; then
    _logColor "$green" "$log_header" "reloading hyprland..."
    hyprctl reload
else
    _logColor "$red" "$log_header" "cannot find the hyprctl command"
fi
