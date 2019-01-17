#!/usr/bin/env bash

set -euo pipefail

DID_FAIL=0
TAG_PREFIX="php-"

PROJECT_DIR=$(dirname $(readlink -f $0))/../

for IMAGE in ${IMAGES}; do
    IMAGE_TAG=${VERSION}
    if [[ "php" != "$IMAGE" && "node" != "$IMAGE" ]]; then
        IMAGE_TAG=${TAG_PREFIX}${VERSION}
    fi

    docker inspect akeneo/${IMAGE}:${IMAGE_TAG} > /dev/null

    echo "Run tests for akeneo/$IMAGE:$IMAGE_TAG image"

    bash ${PROJECT_DIR}/tests/${IMAGE}/run_image_tests.sh ${IMAGE_TAG} || DID_FAIL=1
done

test "0" -ne "$DID_FAIL" && exit 1

exit 0
