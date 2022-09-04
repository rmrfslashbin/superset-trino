#!/usr/bin/env bash

SUPERSET_CONTAINER_NAME=superset-trino-superset-1
ADMIN_USERNAME=admin
ADMIN_PASSWORD=admin
ADMIN_FIRST_NAME=admin
ADMIN_LAST_NAME=admin
ADMIN_EMAIL_ADDRESS=admin@superset.com

docker exec -it $SUPERSET_CONTAINER_NAME superset fab create-admin \
    --username $ADMIN_USERNAME \
    --firstname $ADMIN_FIRST_NAME \
    --lastname $ADMIN_LAST_NAME \
    --email $ADMIN_EMAIL_ADDRESS \
    --password $ADMIN_PASSWORD

docker exec -it $SUPERSET_CONTAINER_NAME superset db upgrade

# Uncomment to set up example data
#docker exec -it $SUPERSET_CONTAINER_NAME superset load_examples

docker exec -it $SUPERSET_CONTAINER_NAME superset init
