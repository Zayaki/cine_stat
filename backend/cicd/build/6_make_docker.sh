#!/bin/sh
set -e

# Source env file
SCRIPT=`readlink -f $0`
SCRIPTDIR=`dirname $SCRIPT`
SCRIPTNAME=`basename $SCRIPT`
ROOTDIR="$SCRIPTDIR/../.."
COMMIT=`git rev-parse --short=8 HEAD`
DATE="`date '+%Y%m%dT%H%M'`"
. $SCRIPTDIR/env.sh

# Build docker
cd $SCRIPTDIR/docker-prod/db
docker build -t ${PROJECT_NAME}_db:${COMMIT} .
cd $ROOTDIR
docker build -t ${PROJECT_NAME}_api:${COMMIT} -f ./cicd/build/docker-prod/api/Dockerfile .

# Tag to latest
docker tag  ${PROJECT_NAME}_db:${COMMIT} ${PROJECT_NAME}_db
docker tag  ${PROJECT_NAME}_api:${COMMIT} ${PROJECT_NAME}_api

# Remove previous docker if exist
if [ -f $ROOTDIR/jenkins_release/*.docker ]; then
  rm $ROOTDIR/jenkins_release/*.docker
fi

# Save image
#docker save ${PROJECT_NAME}_db:${COMMIT} | gzip > jenkins_release/${PROJECT_NAME}_db_${COMMIT}_${DATE}.docker
#docker save ${PROJECT_NAME}_api:${COMMIT} | gzip > jenkins_release/${PROJECT_NAME}_api_${COMMIT}_${DATE}.docker
