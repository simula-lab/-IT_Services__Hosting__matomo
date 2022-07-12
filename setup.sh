#!/bin/bash

#!/bin/bash
echo MARIADB_USER=matomo > .env
echo MARIADB_PASSWORD=`openssl rand 30 | base64 -w 0` >> .env
echo MARIADB_ROOT_PASSWORD=`openssl rand 30 | base64 -w 0` >> .env
echo DOMAIN=$1 >> .env
echo EMAIL=$2 >> .env

docker-compose -f ./docker-compose-first.yaml up -d nginx
docker-compose -f ./docker-compose-first.yaml up certbot
docker-compose -f ./docker-compose-first.yaml down

# some configurations for let's encrypt
curl -L --create-dirs -o etc/letsencrypt/options-ssl-nginx.conf https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf
openssl dhparam -out etc/letsencrypt/ssl-dhparams.pem 2048

crontab ./etc/crontab

docker-compose -f ./docker-compose.yaml up -d

cat .env
