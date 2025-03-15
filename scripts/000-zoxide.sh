# ZOXIDE (smarter cd command): https://github.com/ajeetdsouza/zoxide
update-zoxide() {
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh -s -- --bin-dir "$CUSTOM_TOOLS_DIR"
}

if ! exists zoxide; then
    update-zoxide
fi

eval "$(zoxide init zsh)"