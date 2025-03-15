# HOMEBREW (package manager for OSX): https://brew.sh/
export HOMEBREW_NO_ENV_HINTS=1

local brew_file="/opt/homebrew/bin/brew"
if [ ! -f $brew_file ]; then
    info "Installing brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$($brew_file shellenv)"

alias brewup="brew update && brew upgrade && brew cleanup --prune=all"
