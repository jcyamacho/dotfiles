current_date=$(date +"%d_%m_%Y_%H_%M")

# copy .zshrc while saving old one
zshrc_path="$HOME/.zshrc"
if [ -f "$zshrc_path" ]; then
    mv $zshrc_path "${zshrc_path}.backup_${current_date}"
fi
cp .zshrc $zshrc_path

# copy starship config only if not already present
config_dir="$HOME/.config"
starship_config_path="$config_dir/starship.toml"
if [ ! -f "$starship_config_path" ]; then
  mkdir -p $config_dir
  cp starship.toml $starship_config_path
fi
