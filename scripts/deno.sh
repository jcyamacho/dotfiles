# DENO (javascript runtime): https://deno.land/
export DENO_INSTALL="$HOME/.deno"
if [ ! -d $DENO_INSTALL ]; then
    info "Installing deno..."
    curl -fsSL https://deno.land/install.sh | sh -s -- --no-modify-path -y
fi

export PATH="$DENO_INSTALL/bin:$PATH"
