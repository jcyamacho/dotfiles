# NVM (node version manager): https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"
if [ ! -d $NVM_DIR ]; then
    info "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | sh
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# BUN (javascript runtime): https://bun.sh/
export BUN_DIR="$HOME/.bun"
if [ ! -d $BUN_DIR ]; then
    info "Installing bun..."
    curl -fsSL https://bun.sh/install | sh
fi
[ -s "$BUN_DIR/_bun" ] && source "$BUN_DIR/_bun"
export PATH="$BUN_DIR/bin:$PATH"

# DENO (javascript runtime): https://deno.land/
export DENO_INSTALL="$HOME/.deno"
if [ ! -d $DENO_INSTALL ]; then
    info "Installing deno..."
    curl -fsSL https://deno.land/install.sh | sh -s -- --no-modify-path -y
fi
export PATH="$DENO_INSTALL/bin:$PATH"
