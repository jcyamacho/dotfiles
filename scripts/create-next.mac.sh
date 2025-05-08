create-next() {
  local project_name="$1"

  if [ -z "$project_name" ]; then
      echo "❌ Project name required"
      return 1
  fi

  bunx create-next-app@latest --ts --tailwind --app --turbopack --use-bun --yes "$project_name"

  cd "$project_name"

  bun add -D @biomejs/biome
  bunx biome init

  jq '.formatter |= (del(.indentStyle) | .useEditorconfig=true) | .vcs |= {enabled:true,clientKind:"git",useIgnoreFile:true}' biome.json > tmp.json && mv tmp.json biome.json

  cat > .editorconfig <<EOF
root = true

[*]
charset = utf-8
end_of_line = lf
indent_style = space
indent_size = 2
insert_final_newline = true
trim_trailing_whitespace = true
EOF

  jq '.scripts.lint = "biome check --write"' package.json > tmp.json && mv tmp.json package.json

  mkdir -p .vscode

  cat > .vscode/settings.json <<EOF
{
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
        "source.organizeImports.biome": "explicit",
        "quickfix.biome": "explicit"
    },
    "editor.defaultFormatter": "biomejs.biome",
        "files.associations": {
        "*.css": "tailwindcss"
    }
}
EOF

  cat > .vscode/extensions.json <<EOF
{
  "recommendations": [
    "biomejs.biome",
    "bradlc.vscode-tailwindcss"
  ]
}
EOF

  bun add -D @biomejs/biome
  bunx biome format --write

  git init
  git add --all
  git commit --amend -m "chore: initial commit"
}
