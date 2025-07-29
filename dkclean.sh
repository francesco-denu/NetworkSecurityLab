#!/bin/bash

# Stop and remove all containers
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)

# Remove all images
docker rmi $(docker images -aq)

# Remove all networks
docker network prune --force

# Remove all volumes
docker volume prune --force

docker system prune -a --volumes --force
