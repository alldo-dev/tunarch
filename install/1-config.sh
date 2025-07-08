# Copy the config files
cp -R ~/.acr/dotfiles/* ~/.config/

# Use default bashrc from Omarchy
echo "source ~/.acr/dotfiles/bashrc" >~/.bashrc
