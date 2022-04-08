#!/bin/bash
echo MARIADB_USER=matomo > .env
echo MARIADB_PASSWORD=`openssl rand 30 | base64 -w 0` >> .env
echo MARIADB_ROOT_PASSWORD=`openssl rand 30 | base64 -w 0` >> .env
echo DOMAIN=$1 >> .env
