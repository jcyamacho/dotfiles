if ! exists docker; then
  return
fi

docker-run-it() {
  docker run -it $(docker build -q .)
}
