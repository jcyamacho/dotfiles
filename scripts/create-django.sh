create-django() {
  local project_name="$1"

  if [ -z "$project_name" ]; then
    echo "❌ Project name required"
    return 1
  fi

  mkdir $project_name
  cd $project_name

  poetry init --no-interaction --dependency django
  poetry add -D autopep8

  poetry run django-admin startproject "$project_name"

  cat > README.md <<EOF
# $project_name

## Setup

```bash
poetry install
```

## Run

```bash
poetry run $project_name/manage.py runserver
```

## Format

```bash
poetry run autopep8 -i -r $project_name
```

EOF

  poetry install

  curl https://www.toptal.com/developers/gitignore/api/python,django,vscode,pycharm,windows,linux,macos --output .gitignore
  curl https://raw.githubusercontent.com/django/django/main/.editorconfig --output .editorconfig
  git init
  git add -A
}
