DEFAULT_EDITOR="zed"

# CUSTOM_TOOLS_DIR
export CUSTOM_TOOLS_DIR="$HOME/.local/bin"
if [ ! -d $CUSTOM_TOOLS_DIR ]; then
  mkdir -p $CUSTOM_TOOLS_DIR
fi
export PATH="$CUSTOM_TOOLS_DIR:$PATH"
# CUSTOM_TOOLS_DIR end

updates=()

############################# FUNCTIONS #############################
# create a folder (if it does not exist) and cd to it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# check if a command exists
exists() {
  command -v "$1" >/dev/null 2>&1
}

# reload zsh
reload() {
  exec zsh
}

# used by this script to notify what is being installed
info() {
  local BLUE='\033[1;36m'
  local NO_COLOR='\033[0m'
  echo
  echo "${BLUE}${1}${NO_COLOR}"
  echo
}

# used by this script to warn the user
warn() {
  local YELLOW='\033[1;33m'
  local NO_COLOR='\033[0m'
  echo
  echo "${YELLOW}${1}${NO_COLOR}"
  echo
}

############################## OH-MY-ZSH ##############################

export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"
export ZSH_COMPLETIONS="$ZSH/completions"

# Install oh-my-zsh if not installed (preserving .zshrc file)
if [ ! -d $ZSH ]; then
  info "Installing oh-my-zsh..."
  curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh -s -- --keep-zshrc
fi

setup_custom_plugin() {
  local plugin_path=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$1
  local plugin_url=$2

  if [ ! -d $plugin_path ]; then
      info "Installing $plugin_url..."
      git clone $plugin_url $plugin_path
  fi
}

# Install custom plugins
setup_custom_plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions
setup_custom_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting

# Configure oh-my-zsh plugins
plugins=(
  gh
  git
  gitignore
  # order below is important
  zsh-navigation-tools
  zsh-syntax-highlighting
  zsh-autosuggestions
)

# Disable zsh_theme as we use starship
ZSH_THEME=""

source $ZSH/oh-my-zsh.sh

############################## ALIAS ##############################
# alias should be defined after sourcing oh-my-zsh

alias cls="clear"
alias rmf="rm -rf"

zshconfig() {
  $DEFAULT_EDITOR ~/.zshrc
}

update-dotfiles() {
  _update_dotfiles
  reload
}

_update_dotfiles() {
  info "Updating dotfiles..."
  curl -sL https://raw.githubusercontent.com/jcyamacho/dotfiles/main/install.sh | sh
}

updates+=(_update_dotfiles)

############################## PROMPT ##############################
export STARSHIP_CONFIG_FILE="$HOME/.config/starship.toml"

# Starship prompt
update-starship() {
  _update_starship
  reload
}

_update_starship() {
  info "Updating starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir "$CUSTOM_TOOLS_DIR" > /dev/null
}

updates+=(_update_starship)

if ! exists starship; then
  _update_starship
fi

eval "$(starship init zsh)"

alias starship-preset-nerd-fonts="starship preset nerd-font-symbols > $STARSHIP_CONFIG_FILE"
alias starship-preset-no-nerd-font="starship preset no-nerd-font > $STARSHIP_CONFIG_FILE"
alias starship-preset-plain-text="starship preset plain-text-symbols > $STARSHIP_CONFIG_FILE"
alias starship-preset-custom="cp $HOME/.dotfiles/starship.toml $STARSHIP_CONFIG_FILE"

starshipconfig() {
  $DEFAULT_EDITOR $STARSHIP_CONFIG_FILE
}

############################## CUSTOM ##############################
# Put your personal configurations in ~/.zcustom file and they will
# be sourced at the end
ZCUSTOM_FILE="$HOME/.zcustom"

# Source custom configuration
if [ -f $ZCUSTOM_FILE ]; then
  source $ZCUSTOM_FILE
fi

zcustomconfig() {
  $DEFAULT_EDITOR $ZCUSTOM_FILE
}

############################### TOOLS ###############################
if [[ "$OSTYPE" == "darwin"* ]]; then
  source $ZSHDOTFILES_DIR/dotfiles-mac.sh
else
  source $ZSHDOTFILES_DIR/dotfiles-linux.sh
fi

############################## SCRIPTS ##############################
# SOURCE SCRIPTS
# Determine OS-specific suffix to skip
if [[ "$OSTYPE" == "darwin"* ]]; then
  skip_suffix=".linux.sh"
else
  skip_suffix=".mac.sh"
fi

# Use shell globbing
for script in $(find "$ZSHDOTFILES_DIR/scripts" -name "*.sh" | sort); do
  # Skip platform-specific scripts that don't match current OS
  if [[ "$script" != *"$skip_suffix" ]]; then
    source "$script"
  fi
done
# SOURCE SCRIPTS end

# UPDATES
update-all() {
  for update in "${updates[@]}"; do
    $update
  done
  reload
}
# UPDATES end
