#!/bin/sh
VERSION="1.0.0-SNAPSHOT"
AUTHOR="Zak Hassan <zak.hassan@redhat.com>"


echo '   __  ___          _ __             ___ '
echo '  /  |/  /__  ___  (_) /____  ____  / _ \'
echo ' / /|_/ / _ \/ _ \/ / __/ _ \/ __/ / // /'
echo '/_/  /_/\___/_//_/_/\__/\___/_/   /____/ '

echo   " Building Zookeeper Coordination Server in Docker "
docker   build  --rm -t  bzcareer/docker-zookeeper  ../
echo "Pushing containers up to docker hub"
 docker push bzcareer/docker-zookeeper
