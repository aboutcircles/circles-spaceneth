#git submodule update --init --recursive

cd circles-nethermind-plugin

if [ "$(uname -m)" == "x86_64" ]; then
  docker build --no-cache -f x64.debug.Dockerfile -t circles-nethermind .
else
  docker build -f arm64.Dockerfile -t circles-nethermind .
fi

cd ..
docker compose build
