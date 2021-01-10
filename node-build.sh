#!/bin/bash
# return failing exit code if any command fails
set -e

# enable nullglob - allows filename patterns which match no files to expand to a null string, rather than themselves
shopt -s nullglob

# parse flags
while getopts ":vt" opt; do
  case $opt in
    v) VERBOSE=true;;
    t) WITH_TESTING=true;;
  esac
done

DIST="./dist"

# show input environment args
if [ $VERBOSE ]
then
    echo "env: BITBUCKET_CLONE_DIR=$BITBUCKET_CLONE_DIR"
    echo "env: MYGET_ACCESS_TOKEN=$MYGET_ACCESS_TOKEN" | sed -e 's/=.\+/=******/g'
    echo "env: PROJECT_NAME=$PROJECT_NAME"
    echo "env: PROJECT_FILE=$PROJECT_FILE"
    echo "env: WITH_TESTING=$WITH_TESTING"
    echo ""
fi

# go to the workdir
if [ -n "$BITBUCKET_CLONE_DIR" ]
then
    cd "$BITBUCKET_CLONE_DIR" || return
else
    cd /code || return
fi

# Add myget npm source if access token is set
if [ -n "$MYGET_ACCESS_TOKEN" ]
then
    # check whether inforit scope exists, if not add it
    if [[ $(cat ~/.npmrc | grep @inforit | wc -l) -eq "0" ]]; then
        echo -e "\n@inforit:registry=https://www.myget.org/F/inforit/npm/\n//www.myget.org/F/inforit/npm/:_authToken=$MYGET_ACCESS_TOKEN" >> ~/.npmrc
        echo "@inforit scope sucesfully registered"
    else
        echo "@inforit scope already registered"
    fi
fi

rm -rf "$DIST"

npm install
if [ $WITH_TESTING ]
then
    npm run test:prod
fi
npm run build:prod
npm run zipdist