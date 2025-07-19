if exists docker; then
  docker-run-it() {
    docker run -it $(docker build -q .)
  }
fi
