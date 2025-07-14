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
