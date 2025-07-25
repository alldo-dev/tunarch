#------------------------------------------------------------------------------
# variable declaration
#------------------------------------------------------------------------------

RICE="tunarch"
LOG_HEADER="${RICE} installer"
REPO="alldo-dev/tunarch"
USER="$(whoami)"
RICE_DIR="/home/$USER/.local/share/$RICE"
SCRIPTS_DIR="$RICE_DIR/dotfiles/$RICE/scripts"
CACHE_DIR="/home/$(whoami)/.cache/$RICE" 

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

# Creates cache folder
_createCacheDir(){
    if [ ! -d $CACHE_DIR ]; then
	mkdir -p $CACHE_DIR
	notify-send "Created tunarch cache directory at $CACHE_DIR"
	echo $CACHE_DIR
    fi
    echo $CACHE_DIR
}
