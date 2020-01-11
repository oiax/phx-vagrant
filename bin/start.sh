#!/bin/bash
set -eu

docker-compose up -d db
docker-compose up web
