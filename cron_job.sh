#!/bin/bash
# cleanup exited docker containers
EXITED_CONTAINERS=$(docker ps -a | grep Exited | awk '{ print $1 }')
if [ -z "$EXITED_CONTAINERS" ]
then
        echo "No exited containers to clean"
else
        docker rm $EXITED_CONTAINERS
fi

# renew certbot certificate
readonly SCRIPT_NAME=$(basename $0)
DOCKER_CERTBOT_OUTPUT="$(docker-compose -f /root/matomo/docker-compose.yaml run --rm certbot)"
printf "$DOCKER_CERTBOT_OUTPUT" 
docker-compose -f /root/matomo/docker-compose.yaml exec nginx nginx -s reload
printf "$DOCKER_CERTBOT_OUTPUT" | tr -d '\r' | logger -p user.notice -t $SCRIPT_NAME
