#!/bin/sh
clear

ascii_art='                                                           █████     
                                                          ░░███      
  ██████    ██████  ████████   ██████   ████████   ██████  ░███████  
 ░░░░░███  ███░░███░░███░░███ ░░░░░███ ░░███░░███ ███░░███ ░███░░███ 
  ███████ ░███ ░░░  ░███ ░░░   ███████  ░███ ░░░ ░███ ░░░  ░███ ░███ 
 ███░░███ ░███  ███ ░███      ███░░███  ░███     ░███  ███ ░███ ░███ 
░░████████░░██████  █████    ░░████████ █████    ░░██████  ████ █████
 ░░░░░░░░  ░░░░░░  ░░░░░      ░░░░░░░░ ░░░░░      ░░░░░░  ░░░░ ░░░░░ '

echo -e "\n$ascii_art\n"

#------------------------------------------------------------------------------
# variable declaration
#------------------------------------------------------------------------------
rice="acr"
log_header="${rice} installer"
repo="alldo-dev/acr"
download_dir="$HOME/.acr"

echo -e "\n[${log_header}] installing git..."

# check if git is installed or install if no install
pacman -Q git &>/dev/null || sudo pacman -Sy --noconfirm --needed git


echo -e "\n[${log_header}] attempting to remove ${download_dir}"
rm -rf $download_dir


echo -e "\n[${log_header}] cloning ${repo} to ${download_dir}"
git clone "https://github.com/${repo}.git" "${download_dir}" >/dev/null

echo -e "[${log_header}] Installation starting..."

# Exit immediately if a command exits with a non-zero status
set -e

# Create download_dir if not exists
if [ ! -d $download_dir ]; then
    echo "[${log_header}] creating directory in ${download_dir}"
    mkdir -p $download_dir
else
    echo "[${log_header}] directory ${download_dir} exists, continuing..."
fi

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
