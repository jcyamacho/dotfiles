# rbenv (Ruby version manager): https://github.com/rbenv/rbenv
if ! exists rbenv; then
    info "Installing rbenv..."
    brew install rbenv
fi

eval "$(rbenv init - --no-rehash zsh)"
