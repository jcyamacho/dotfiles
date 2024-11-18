export ZSHDOTFILES_DIR="$HOME/.dotfiles"

if [ ! -d "$ZSHDOTFILES_DIR" ]; then
    git clone https://github.com/jcyamacho/dotfiles $ZSHDOTFILES_DIR
    cd $ZSHDOTFILES_DIR
else
    cd $ZSHDOTFILES_DIR
    git pull --all
fi

# execute other script
zsh ./install.local.sh
