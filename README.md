# Superset-Trino
A collection of Dockerfiles, config, Docker Composer, and scripts to set up a Superset + Trino environment.

## Disclaimer
This repo is meant to be a starting point for a local development environment, testing, and tinkering. It is NOT meant to be used in production.

## Prerequisites
- Docker
- Docker Compose
- AWS Account with Glue tables (optional- remark out Trino Hive setup in Makefile if not using)

## Setup
1. Clone this repo.
2. Copy `makefile.secrets.DIST` to `makefile.secrets` and fill in the values.
3. Run `make build` to build the Docker images.
4. Run `make up` to start the containers. Make note of the superset container name (e.g. superset_trino_superset_1).
4. Edit and then run `setup.bash` to configure Superset.
5. Browser to `http://${HOST}:8088` to access Superset (${HOOST} is the hostname of the server exposing the Superset web server).
6. Log into Superset and set up a Trino database connection (e.g. `trino://user@trino:8080/hive`).
7. Add a custom column to the rtl table to fix up the timestamp. SQL: `FROM_UNIXTIME(CAST (timestamp AS DOUBLE))`.
7. Have fun!
