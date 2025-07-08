#!/bin/sh
clear

source $HOME/.acr/utils.sh


#------------------------------------------------------------------------------
# Script Start
#------------------------------------------------------------------------------

echo -e "\n$ascii_art\n"

_logColor "$cyan" "$log_header" "checking if git is already installed..."
if [[ $(_isInstalled "git") == 0 ]]; then
    _logColor "$cyan" "$log_header" "git is already installed"
    continue
else
    _logColor "$cyan" "$log_header" "git is not installed, installing..."
    sudo pacman -Sy --noconfirm --needed git
fi

_logColor "$cyan" "$log_header" "removing ${download_dir}"
rm -rf $download_dir


_logColor "$cyan" "$log_header" "cloning ${repo} to ${download_dir}"
git clone "https://github.com/${repo}.git" "${download_dir}" >/dev/null

_logColor "$cyan" "$log_header" "Installation starting..."

# Create download_dir if not exists
if [ ! -d $download_dir ]; then
    _logColor "$cyan" "$log_header" "creating directory in ${download_dir}"
    mkdir -p $download_dir
else
    _logColor "$cyan" "$log_header" "directory ${download_dir} exists, continuing..."
fi


# Install everything
for f in $download_dir/install/*.sh; do
    _logColor "$cyan" "$log_header" "running installation for $f"
    source "$f"
done

