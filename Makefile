org := rmrf
supersetTag := latest
trinoTag := latest

# Config makefile.secrets as needed
include makefile.secrets
export

# Superset: https://hub.docker.com/r/apache/superset
# Trino-Server: https://hub.docker.com/r/trinodb/trino

# See superset URL above for post-installation steps

build:
# Remark out the following line if you don't want to include AWS Glue support
	rm -f trino-server/etc/trino/catalog.hive.properties
	sed \
	  -e "s/TRINO_GLUE_REGION/$(trino_glue_region)/" \
	  -e "s/TRINO_GLUE_ACCESS_KEY/$(trino_glue_access_key)/" \
	  -e "s/TRINO_GLUE_SECRET_KEY/$(trino_glue_secret_key)/" \
	  templates/hive.TEMPLATE.properties > trino-server/etc/trino/catalog/hive.properties

	docker build -t $(org)/superset:$(supersetTag) superset
	docker build -t $(org)/trino:$(trinoTag) trino-server
	rm -f docker-compose.yml
	sed \
	  -e "s/ORG/$(org)/" \
	  -e "s/TRINO_TAG/$(trinoTag)/" \
	  -e "s/SUPERSET_TAG/$(supersetTag)/" \
	  templates/docker-compose.TEMPLATE.yml > docker-compose.yml

up:
	docker compose up -d
	docker ps |grep superset

crawler: crawler-run crawler-status

crawler-run:
	# Run the crawler
	aws --no-cli-pager glue start-crawler --name $(aws_glue_crawler)

crawler-status:
	# Status the crawler
	aws --no-cli-pager glue get-crawler --name $(aws_glue_crawler)
