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

  mv ./$project_name/manage.py ./
  mv ./$project_name/$project_name/* ./$project_name/
  rm -r ./$project_name/$project_name

  cat > README.md <<EOF
# $project_name

A Django web application.

## Setup

\`\`\`bash
poetry install
\`\`\`

## Development

### Run development server

\`\`\`bash
poetry run ./manage.py runserver
\`\`\`

### Create migrations

\`\`\`bash
poetry run ./manage.py makemigrations
\`\`\`

### Apply migrations

\`\`\`bash
poetry run ./manage.py migrate
\`\`\`

### Create a superuser

\`\`\`bash
poetry run ./manage.py createsuperuser
\`\`\`

## Testing

\`\`\`bash
poetry run ./manage.py test
\`\`\`

## Code Quality

### Format code

\`\`\`bash
poetry run autopep8 -i -r .
\`\`\`
EOF

  poetry install

  curl https://www.toptal.com/developers/gitignore/api/python,django,vscode,pycharm,windows,linux,macos --output .gitignore
  curl https://raw.githubusercontent.com/django/django/main/.editorconfig --output .editorconfig

  git init
  git add --all
  git commit -m "chore: initial commit"
}
