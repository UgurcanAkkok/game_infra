#!/bin/bash

set -e -o pipefail

# By default use the existing variable from environment
REPOSITORY="${REPOSITORY:-goodblast}"
IMAGE="${IMAGE:-goodblast-be}"
VERSION="${VERSION:-0.1.0}"
COMMIT_ID="$(git show -s --format=%ct HEAD)"

FULL_IMAGE_NAME="${REPOSITORY}/${IMAGE}:${VERSION}-c${COMMIT_ID}"

# You need to be in the source directory, which has the Dockerfile
docker build -t $FULL_IMAGE_NAME .

echo "------------------------------"
echo "The image is ready: $FULL_IMAGE_NAME"
echo "------------------------------"
