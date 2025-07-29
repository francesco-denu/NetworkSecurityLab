#!/bin/bash
#set -e

# this script will start all the containers and set them up

if [ "$EUID" -ne 0 ]; then
  echo "You must run this script as root. Exiting."
  exit 1
fi

# uncomment following line if you want to build your image locally, insturctions in router1/vyos/note.txt
tar -C ./router1/vyos/unsquashfs -c . | docker import - vyos
#docker pull francescodenu/vyos:latest
#docker tag francescodenu/vyos:latest vyos:latest

docker compose up -d

./host_setup.sh

docker exec server1 /root/setup.sh
docker exec server2 /root/setup.sh
docker exec host1 /root/setup.sh
docker exec switch1 /root/setup.sh
docker exec router1 chmod +x /root/setup.sh
docker exec router1 chmod +x /home/vyos/config.sh
docker exec router1 /root/setup.sh
docker exec db /root/setup.sh 

sleep 10 # it is needed to wait for the router to run setup script before running the actual vyos configuration
docker exec router1 sg vyattacfg -c /home/vyos/config.sh # you need to run the config script with the group vyattacfg

docker exec gateway /root/setup.sh
docker exec switch2 /root/setup.sh
docker exec server3 /root/setup1.sh
docker exec server4 /root/setup2.sh 
docker exec dns /root/setup.sh 


