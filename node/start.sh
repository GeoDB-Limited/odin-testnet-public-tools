# make sure the previous run is down
docker-compose -f ./docker-compose.yaml down -v --remove-orphans

# pull the latest repos
docker-compose -f ./docker-compose.yaml pull

# start the node
docker-compose -f ./docker-compose.yaml up -d

if [ "$1" == "r" ]; then
  echo "Running yoda"
  # pull the latest repos
  docker-compose -f ./docker-compose-reporter.yaml pull

  docker-compose -f ./docker-compose-reporter.yaml up -d
fi