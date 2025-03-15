# JQ (command-line JSON processor): https://jqlang.github.io/jq/
if ! exists jq; then
    info "Installing jq..."
    brew install jq
fi
