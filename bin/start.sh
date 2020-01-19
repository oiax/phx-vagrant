#!/bin/bash
set -eu

docker-compose up -d db
docker-compose run --rm --service-ports web /bin/bash
