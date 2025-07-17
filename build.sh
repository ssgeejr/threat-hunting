#!/bin/bash
#for netbox: docker compose exec netbox /opt/netbox/netbox/manage.py createsuperuser


cd nginx
docker build -t nginx-landing .
cd ..

cd attack-navigator
git clone https://github.com/mitre-attack/attack-navigator.git
cd attack-navigator
docker build -t attnav:prod .
cd ..
pwd
cd ..
pwd

cd netbox-docker/
docker pull netboxcommunity/netbox:v4.3-3.3.0
docker tag netboxcommunity/netbox:v4.3-3.3.0 netbox:prod
cd ../

