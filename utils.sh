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
    echo -e "${header_color}[${header}]${white}${header_msg}"
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
