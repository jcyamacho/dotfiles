current_date=$(date +"%d_%m_%Y_%H_%M")

# copy .zshrc while saving old one
zshrc_path="$HOME/.zshrc"
if [ -f "$zshrc_path" ]; then
    mv $zshrc_path "${zshrc_path}.backup_${current_date}"
fi
cp .zshrc $zshrc_path

# copy ..zshmac while saving old one
zshmac_path="$HOME/.zshmac"
if [ -f "$zshmac_path" ]; then
    mv $zshmac_path "${zshmac_path}.backup_${current_date}"
fi
cp .zshmac $zshmac_path

# copy starship config
config_dir="$HOME/.config"
starship_config_path="$config_dir/starship.toml"
if [ -f "$starship_config_path" ]; then
    mv $starship_config_path "${starship_config_path}.backup_${current_date}"
else
    mkdir -p $config_dir
fi
cp starship.toml $starship_config_path
