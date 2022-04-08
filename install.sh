#!/bin/bash

./create_dot_env.sh $1

docker-compose -f ./docker-compose-first.yaml up nginx -d
docker-compose -f ./docker-compose-first.yaml up certbot
docker-compose -f ./docker-compose-first.yaml down

./create_cron_job.sh

docker-compose -f ./docker-compose.yaml up -d
