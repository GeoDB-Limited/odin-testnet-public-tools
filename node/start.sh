#!/bin/bash

# make sure the previous run is down
docker-compose -f ./docker-compose.yaml down -v --remove-orphans

# pull the latest repos
#docker-compose -f ./docker-compose.yaml pull

# start the node
docker-compose -f ./docker-compose.yaml up -d