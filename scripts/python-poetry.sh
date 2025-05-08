install-poetry() {
  curl -sSL https://install.python-poetry.org | python3 -
}

# https://python-poetry.org/docs/configuration/#virtualenvsin-project
export POETRY_VIRTUALENVS_IN_PROJECT="true"