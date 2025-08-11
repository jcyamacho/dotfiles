export ZSHDOTFILES_DIR="$HOME/.dotfiles"

if [ ! -d "$ZSHDOTFILES_DIR" ]; then
  git clone https://github.com/jcyamacho/dotfiles $ZSHDOTFILES_DIR
  cd $ZSHDOTFILES_DIR
else
  cd $ZSHDOTFILES_DIR
  git pull --all
fi

current_date=$(date +"%d_%m_%Y_%H_%M")

# copy .zshrc while saving old one
zshrc_path="$HOME/.zshrc"
if [ -f "$zshrc_path" ]; then
  mv $zshrc_path "${zshrc_path}.backup_${current_date}"
fi
cp $ZSHDOTFILES_DIR/.zshrc $zshrc_path

# copy starship config only if not already present
config_dir="$HOME/.config"
starship_config_path="$config_dir/starship.toml"
if [ ! -f "$starship_config_path" ]; then
  mkdir -p $config_dir
  cp $ZSHDOTFILES_DIR/starship.toml $starship_config_path
fi
