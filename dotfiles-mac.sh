alias ll="ls -laG"
alias cd.="cd .."

# HOMEBREW (package manager for OSX): https://brew.sh/
export HOMEBREW_NO_ENV_HINTS=1

local brew_file="/opt/homebrew/bin/brew"
if [ ! -f $brew_file ]; then
  info "Installing brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$($brew_file shellenv)"

update-brew() {
  info "Updating brew..."
  brew update
  info "Upgrading brew packages..."
  brew upgrade
  info "Cleaning up brew..."
  brew cleanup --prune=all
}

updates+=(update-brew)
