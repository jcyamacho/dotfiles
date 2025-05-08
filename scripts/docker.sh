docker-run-it() {
  docker run -it $(docker build -q .)
}
