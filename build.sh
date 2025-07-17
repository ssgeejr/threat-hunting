#!/bin/bash
#for netbox: docker compose exec netbox /opt/netbox/netbox/manage.py createsuperuser


cd netbox-docker/netbox-docker/
docker pull netboxcommunity/netbox:v4.3-3.3.0
docker tag netboxcommunity/netbox:v4.3-3.3.0 netbox:prod
cd ../../

