#!/bin/sh

cd ../dev
docker-compose down
find ./db/init -type d -exec chmod o+rx {} \;
find ./db/init -type f -exec chmod o+r {} \;
echo -e "LOCAL_USER_ID=$(id -u)\nLOCAL_GROUP_ID=$(id -g)" > docker-compose.env
docker-compose build
sudo ./make_init_and_rights.sh
docker-compose up -d