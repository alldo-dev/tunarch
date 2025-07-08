for f in ~/.acr/dotfiles/bashrc/*; do 
    echo -e "\nsourcing: ${f}"
    source $f
done
