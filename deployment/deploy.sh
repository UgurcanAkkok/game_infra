#!/bin/bash

if [ -z "$1" ]; then
  echo "Specify the environment as the first argument: dev|prod"
  exit 1
fi

if [ "$1" == "dev" ];then
  CLUSTER="dev"
elif [ "$1" == "prod" ];then
  CLUSTER="prod"
else
  echo "Wrong parameter.."
  exit 1
fi

ORIG_PWD=$PWD

echo "Deploying to $CLUSTER ..."

### First set the image
FULL_IMAGE_NAME="$(cat ../source/.full_image_name)"

cd $ORIG_PWD/kustomize/$CLUSTER
kustomize edit set image $FULL_IMAGE_NAME

### Apply the kustomize

cd $ORIG_PWD/kustomize

kubectl apply -k prod
