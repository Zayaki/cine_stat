#!/bin/sh
set -e

# Source env file
SCRIPT=`readlink -f $0`
SCRIPTDIR=`dirname $SCRIPT`
SCRIPTNAME=`basename $SCRIPT`
ROOTDIR="$SCRIPTDIR/../.."
#COMMIT=`git rev-parse --short=8 HEAD`
#DATE="`date '+%Y%m%dT%H%M'`"
. $SCRIPTDIR/env.sh

# Make release
rm -rf $ROOTDIR/jenkins_release/
mkdir -p $ROOTDIR/jenkins_release/${PROJECT_NAME}

cp -r $ROOTDIR/app $ROOTDIR/jenkins_release/${PROJECT_NAME}/app
cp -r $ROOTDIR/.gitignore $ROOTDIR/jenkins_release/${PROJECT_NAME}/.gitignore
cp -r $ROOTDIR/requirements.txt $ROOTDIR/jenkins_release/${PROJECT_NAME}/requirements.txt
cp -r $ROOTDIR/run.py $ROOTDIR/jenkins_release/${PROJECT_NAME}/run.py
cp -r $ROOTDIR/wsgi.py $ROOTDIR/jenkins_release/${PROJECT_NAME}/wsgi.py
