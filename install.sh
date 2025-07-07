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
    header_color="$1"
    header="$2"
    header_msg="$3"
    echo -e "\n${header_color}[${header}]${white}${header_msg}"
}

# Check if package is installed
_isInstalled() {
    package="$1"
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")"
    if [ -n "${check}" ]; then
        echo 0 #'0' means 'true' in Bash
        return #true
    fi
    echo 1 #'1' means 'false' in Bash
    return #false
}

# Check if command exists
_checkCommandExists() {
    package="$1"
    if ! command -v $package >/dev/null; then
        return 1
    else
        return 0
    fi
}

# pretty print




#------------------------------------------------------------------------------
# Script Start
#------------------------------------------------------------------------------

echo -e "\n$ascii_art\n"
# echo -e "\n[${log_header}] checking if git is already installed..."
_logColor "$magenta" "$log_header" "checking if git is already installed..."

# check if git is installed or install if no install
# pacman -Q git &>/dev/null || sudo pacman -Sy --noconfirm --needed git

if [[ $(_isInstalled "git") == 0 ]]; then
    echo -e "\n[${log_header}] git is already installed."
    continue
else
    echo -e "\n[${log_header}] git is not installed, installing..."
    sudo pacman -Sy --noconfirm --needed git
fi


# echo -e "\n[${log_header}] attempting to remove ${download_dir}"
# rm -rf $download_dir
#
#
# echo -e "\n[${log_header}] cloning ${repo} to ${download_dir}"
# git clone "https://github.com/${repo}.git" "${download_dir}" >/dev/null
#
# echo -e "\n[${log_header}] Installation starting..."
#
# # Exit immediately if a command exits with a non-zero status
#
# # Create download_dir if not exists
# if [ ! -d $download_dir ]; then
#     echo -e "\n[${log_header}] creating directory in ${download_dir}"
#     mkdir -p $download_dir
# else
#     echo -e "\n[${log_header}] directory ${download_dir} exists, continuing..."
# fi
#

