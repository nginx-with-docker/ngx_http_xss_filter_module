#!/bin/bash

set -a
    . "docker/.env"
set +a

PROJECT_NAME="xss"
REPO_NAME="soulteary/prebuilt-nginx-modules";
REPO_TAG="ngx-$NGINX_VERSION-$PROJECT_NAME-$MODULE_VERSION";

if [ -f "docker/Dockerfile.alpine" ]; then
    BUILD_NAME="$REPO_NAME:$REPO_TAG-alpine"
    if [[ "$(docker images -q $BUILD_NAME 2> /dev/null)" != "" ]]; then
        echo "Push: $BUILD_NAME";
        docker push $BUILD_NAME;
    fi
fi

if [ -f "docker/Dockerfile.debian" ]; then
    BUILD_NAME="$REPO_NAME:$REPO_TAG"
    if [[ "$(docker images -q $BUILD_NAME 2> /dev/null)" != "" ]]; then
        echo "Push: $BUILD_NAME";
        docker push $BUILD_NAME;
    fi
fi
