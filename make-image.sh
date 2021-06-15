#!/bin/bash

set -a
    . "docker/.env"
set +a

PROJECT_NAME="xss"
REPO_NAME="soulteary/prebuilt-nginx-modules";
REPO_TAG="ngx-$NGINX_VERSION-$PROJECT_NAME-$MODULE_VERSION";

BUILD_ARGS=$(tr '\n' ';' < "docker/.env" | sed 's/;$/\n/' | sed 's/^/ --build-arg /' | sed 's/;/ --build-arg /g')

if [ -f "docker/Dockerfile.alpine" ]; then
    BUILD_NAME="$REPO_NAME:$REPO_TAG-alpine"
    if [[ "$(docker images -q $BUILD_NAME 2> /dev/null)" == "" ]]; then
        echo "Build: $BUILD_NAME";
        docker build $BUILD_ARGS --tag $BUILD_NAME -f docker/Dockerfile.alpine .
    fi
fi

if [ -f "docker/Dockerfile.debian" ]; then
    BUILD_NAME="$REPO_NAME:$REPO_TAG"
    if [[ "$(docker images -q $BUILD_NAME 2> /dev/null)" == "" ]]; then
        echo "Build: $BUILD_NAME";
        docker build $BUILD_ARGS --tag $BUILD_NAME -f docker/Dockerfile.debian .
    fi
fi
