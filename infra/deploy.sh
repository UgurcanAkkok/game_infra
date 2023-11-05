#!/bin/bash

## Check the $1 and $2 args
if [ -z "$1" ]; then
  echo "Specify the environment as the first argument: dev|prod"
  exit 1
fi

## TO be used in the .tfvars file name
if [ "$1" == "dev" ];then
  CLUSTER="dev"
elif [ "$1" == "prod" ];then
  CLUSTER="prod"
else
  echo "Wrong parameter.."
  exit 1
fi

## If we want to destroy, set the destroy flag
if [[ "$2" == "-d" || "$2" == "--destroy" ]]; then
  DESTROY_ARG="-destroy"
fi

terraform apply -var-file $CLUSTER.tfvars $DESTROY_ARG
