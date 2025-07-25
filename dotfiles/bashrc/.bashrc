#------------------------------------------------------------------------------
# BASH CONFIGURATION
#------------------------------------------------------------------------------
for f in /home/$(whoami)/.local/share/tunarch/dotfiles/bashrc/*;do
    source $f
done
