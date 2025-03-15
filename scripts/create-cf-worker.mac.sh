create-cf-worker() {
    local project_name="$1"

    if [ -z "$project_name" ]; then
        echo "❌ Project name required"
        return 1
    fi

    # Scaffold new Hono Cloudflare Workers project
    bun create hono@latest --pm bun --template cloudflare-workers --install "$project_name"

    cd "$project_name" || return 1

    # Setup Biome
    bun add -D @biomejs/biome
    bunx biome init

    # Configure Biome settings
    jq '.formatter |= (del(.indentStyle) | .useEditorconfig=true) | .vcs |= {enabled:true,clientKind:"git",useIgnoreFile:true}' biome.json > tmp.json && mv tmp.json biome.json

    # Add scripts to package.json
    jq '.scripts += {
        "typegen": "wrangler types --env-interface CloudflareBindings",
        "lint": "biome check --write"
    }' package.json > tmp.json && mv tmp.json package.json

    # Create standard README
    echo "# $project_name" > README.md

    # Setup .gitignore
    curl -fsSL "https://www.toptal.com/developers/gitignore/api/macos,linux,windows,visualstudiocode,node" > .gitignore
    cat >> .gitignore <<EOF

# Wrangler
.wrangler
.dev.vars
EOF

    # Configure .editorconfig
    curl https://raw.githubusercontent.com/JS-DevTools/template-node-typescript/refs/heads/master/.editorconfig > .editorconfig

    # Configure VSCode settings
    mkdir -p .vscode

    cat > .vscode/settings.json <<EOF
{
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
        "source.organizeImports.biome": "explicit",
        "quickfix.biome": "explicit"
    },
    "editor.defaultFormatter": "biomejs.biome"
}
EOF

    cat > .vscode/extensions.json <<EOF
{
    "recommendations": [
        "biomejs.biome"
    ]
}
EOF

    # Format the project
    bunx biome format --write

    # Initialize Git repo and make initial commit
    git init
    git add --all
    git commit --message "chore: initial commit"
}
