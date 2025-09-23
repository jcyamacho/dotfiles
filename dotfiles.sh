# sets the cursor to a blinking vertical bar (beam) style
echo -ne '\e[5 q'

export DEFAULT_EDITOR="zed"

export ZSH_CACHE_DIR="${ZSHDOTFILES_DIR}/.cache/zsh"
if [[ -d "${ZSH_CACHE_DIR}" ]]; then
  mkdir -p "${ZSH_CACHE_DIR}"
fi

updates=()

########################## CUSTOM_TOOLS_DIR ##########################
export CUSTOM_TOOLS_DIR="$HOME/.local/bin"
if [ ! -d "$CUSTOM_TOOLS_DIR" ]; then
  mkdir -p "$CUSTOM_TOOLS_DIR"
fi
export PATH="$CUSTOM_TOOLS_DIR:$PATH"

############################# FUNCTIONS #############################
# create a folder (if it does not exist) and cd to it
mkcd() {
  mkdir -p "$1" && cd "$1" || return 1
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
  echo "${BLUE}${1}${NO_COLOR}"
}

# used by this script to warn the user
warn() {
  local YELLOW='\033[1;33m'
  local NO_COLOR='\033[0m'
  echo "${YELLOW}${1}${NO_COLOR}"
}

# check if the OS is macOS
is-macos() {
  [[ $OSTYPE == darwin* ]]
}

############################## ANTIDOTE ##############################
export ANTIDOTE_DIR="${ZSHDOTFILES_DIR}/.antidote"
export ANTIDOTE_HOME="${ZSHDOTFILES_DIR}/.cache/antidote"

if [[ ! -d "${ANTIDOTE_DIR}" ]]; then
    git clone --depth=1 https://github.com/mattmc3/antidote.git "${ANTIDOTE_DIR}"
fi

# Set the root name of the plugins files (.txt and .zsh) antidote will use.
local zsh_plugins="${ZSHDOTFILES_DIR}/.zsh_plugins"

# Lazy-load antidote from its functions directory.
fpath=("${ANTIDOTE_DIR}/functions" $fpath)
autoload -Uz antidote

# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi

# Source your static plugins file.
source ${zsh_plugins}.zsh

_update_antidote() {
  info "Updating antidote..."
  antidote update
}

update-antidote() {
  _update_antidote
  reload
}

updates+=(_update_antidote)

############################## ALIAS ##############################
# alias should be defined after sourcing oh-my-zsh

alias cls="clear"
alias rmf="rm -rf"

home() {
  cd "$HOME" || return 1
}

zshconfig() {
  $DEFAULT_EDITOR --wait "$HOME/.zshrc"
  reload
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
  reload
fi

eval "$(starship init zsh)"

alias starship-preset-nerd-fonts='starship preset nerd-font-symbols > "$STARSHIP_CONFIG_FILE"'
alias starship-preset-no-nerd-font='starship preset no-nerd-font > "$STARSHIP_CONFIG_FILE"'
alias starship-preset-plain-text='starship preset plain-text-symbols > "$STARSHIP_CONFIG_FILE"'
alias starship-preset-custom='cp "$ZSHDOTFILES_DIR/starship.toml" "$STARSHIP_CONFIG_FILE"'

starshipconfig() {
  $DEFAULT_EDITOR --wait "$STARSHIP_CONFIG_FILE"
  reload
}

############################## CUSTOM ##############################
# Put your personal configurations in ~/.zcustom file and they will
# be sourced at the end
ZCUSTOM_FILE="$HOME/.zcustom"

# Source custom configuration
if [ -f "$ZCUSTOM_FILE" ]; then
  source "$ZCUSTOM_FILE"
fi

zcustomconfig() {
  $DEFAULT_EDITOR --wait "$ZCUSTOM_FILE"
  reload
}

############################### TOOLS ###############################
if is-macos; then
  source "$ZSHDOTFILES_DIR/dotfiles-mac.sh"
else
  source "$ZSHDOTFILES_DIR/dotfiles-linux.sh"
fi

############################## SCRIPTS ##############################
for script in "$ZSHDOTFILES_DIR/scripts"/*.sh; do
  source "$script"
done

############################## UPDATES ##############################
update-all() {
  for update in "${updates[@]}"; do
    $update
    echo
  done

  reload
}
