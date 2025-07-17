#!/bin/bash
git clone -b release https://github.com/netbox-community/netbox-docker.git
cp docker-compose.override.yml netbox-docker/
cd netbox-docker
docker compose pull
#docker compose up
