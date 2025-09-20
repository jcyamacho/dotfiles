if exists docker; then
  docker-run-it() {
    docker run -it $(docker build -q .)
  }

  docker-completions() {
    mkdir -p $ZSH_COMPLETIONS
    docker completion zsh > $ZSH_COMPLETIONS/_docker
  }
fi
