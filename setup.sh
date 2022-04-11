#!/bin/bash

#!/bin/bash
echo MARIADB_USER=matomo > .env
echo MARIADB_PASSWORD=`openssl rand 30 | base64 -w 0` >> .env
echo MARIADB_ROOT_PASSWORD=`openssl rand 30 | base64 -w 0` >> .env
echo DOMAIN=$1 >> .env
echo EMAIL=$2 >> .env

docker-compose -f ./docker-compose-first.yaml up nginx -d
docker-compose -f ./docker-compose-first.yaml up certbot
docker-compose -f ./docker-compose-first.yaml down

crontab ./etc/crontab

docker-compose -f ./docker-compose.yaml up -d

cat .env
