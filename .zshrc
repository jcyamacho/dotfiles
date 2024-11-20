# .zshrc

# Put your personal configurations in ~/.zcustom file and they will
# be sourced at the end
ZCUSTOM_FILE="$HOME/.zcustom"

############################# FUNCTIONS #############################

# create a folder (if it does not exist) and cd to it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# check if a command exists
exists() {
    command -v "$1" >/dev/null 2>&1
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
export STARSHIP_CONFIG_FILE="$HOME/.config/starship.toml"

alias cls="clear"
alias zshconfig="code ~/.zshrc"
alias starshipconfig="code $STARSHIP_CONFIG_FILE"
alias zcustomconfig="code $ZCUSTOM_FILE"

alias starship-preset-nerd-fonts="starship preset nerd-font-symbols > $STARSHIP_CONFIG_FILE"
alias starship-preset-no-nerd-font="starship preset no-nerd-font > $STARSHIP_CONFIG_FILE"
alias starship-preset-plain-text="starship preset plain-text-symbols > $STARSHIP_CONFIG_FILE"
alias starship-preset-custom="cp $HOME/.dotfiles/starship.toml $STARSHIP_CONFIG_FILE"

if [[ "$OSTYPE" == "darwin"* ]]; then
    alias ll="ls -laG"
else
    alias ll="ls -la --color=auto"
fi

alias update-dotfiles="curl -sL https://raw.githubusercontent.com/jcyamacho/dotfiles/main/install.sh | sh"

############################## DEV TOOLS ##############################

# CUSTOM_TOOLS_DIR
export CUSTOM_TOOLS_DIR="$HOME/.local/bin"
if [ ! -d $CUSTOM_TOOLS_DIR ]; then
    mkdir -p $CUSTOM_TOOLS_DIR
fi
export PATH="$CUSTOM_TOOLS_DIR:$PATH"
# CUSTOM_TOOLS_DIR end

# DIRENV (per directory env vars via .envrc): https://direnv.net/
update-direnv() {
    export bin_path=$CUSTOM_TOOLS_DIR
    info "Installing direnv..."
    curl -sfL https://direnv.net/install.sh | bash
    unset bin_path
}
if ! exists direnv; then
    update-direnv
fi
eval "$(direnv hook zsh)"

# ZOXIDE (smarter cd command): https://github.com/ajeetdsouza/zoxide
update-zoxide() {
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh -s -- --bin-dir "$CUSTOM_TOOLS_DIR"
}
if ! exists zoxide; then
    update-zoxide
fi
eval "$(zoxide init zsh)"

# NVM (node version manager): https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"
if [ ! -d $NVM_DIR ]; then
    info "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | sh
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# RUST (programming language): https://www.rust-lang.org/
export CARGO_DIR="$HOME/.cargo"
if [ ! -d $CARGO_DIR ]; then
    info "Installing rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
[ -s "$CARGO_DIR/env" ] && \. "$CARGO_DIR/env"

# BUN (javascript runtime): https://bun.sh/
export BUN_DIR="$HOME/.bun"
if [ ! -d $BUN_DIR ]; then
    info "Installing bun..."
    curl -fsSL https://bun.sh/install | sh
fi
[ -s "$BUN_DIR/_bun" ] && source "$BUN_DIR/_bun"
export PATH="$BUN_DIR/bin:$PATH"

# HOMEBREW (package manager for OSX): https://brew.sh/
if [[ "$OSTYPE" == "darwin"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"

    if ! exists brew; then
        info "Installing brew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    alias brewup="brew update && brew upgrade && brew cleanup --prune=all"

    install-fonts() {
        info "Installing fonts..."
        brew install --cask font-monaspace
        brew install --cask font-hack-nerd-font
        brew install --cask font-jetbrains-mono
        brew install --cask font-jetbrains-mono-nerd-font
    }
fi

# GITHUB_CLI (GitHub on the command line): https://github.com/cli/cli
if ! exists gh; then
    warn "GitHub CLI is not installed: https://github.com/cli/cli#installation"
fi

############################## PROMPT ##############################

# Starship prompt
update-starship() {
    info "Installing starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir "$CUSTOM_TOOLS_DIR"
}
if ! exists starship; then
    update-starship
fi
eval "$(starship init zsh)"

############################## CUSTOM ##############################

# Source custom configuration
if [ -f $ZCUSTOM_FILE ]; then
    source $ZCUSTOM_FILE
fi
