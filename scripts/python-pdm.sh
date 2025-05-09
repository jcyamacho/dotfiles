# pdm (Python package manager): https://pdm-project.org/
install-pdm() {
  curl -sSL https://pdm-project.org/install-pdm.py | python -
}

uninstall-pdm() {
  curl -sSL https://pdm-project.org/install-pdm.py | python - --uninstall
}

create-django-pdm() {
  local project_name="$1"

  if [ -z "$project_name" ]; then
    echo "❌ Project name required"
    return 1
  fi

  mkdir $project_name
  cd $project_name

  local python_version=$(which python)

  pdm init -n --python $python_version --license UNLICENSED minimal
  pdm add django
  pdm add -dG dev autopep8

  rm .gitignore
  curl https://www.toptal.com/developers/gitignore/api/python,django,vscode,pycharm,windows,linux,macos --output .gitignore
  echo ".pdm-python" >> .gitignore

  curl https://raw.githubusercontent.com/django/django/main/.editorconfig --output .editorconfig

  pdm run django-admin startproject $project_name .

  cat >> pyproject.toml<<EOF

[tool.pdm.scripts]
migrate = "python manage.py migrate"
start = "python manage.py runserver"
test = "python manage.py test"
format = "autopep8 -i -r ."
EOF

  cat > README.md <<EOF
# $project_name

A Django web application.

## Scripts

- `pdm start` - Run the development server
- `pdm migrate` - Apply migrations
- `pdm test` - Run tests
- `pdm format` - Format code
EOF

  git add --all
  git commit -m "chore: initial commit"
}
