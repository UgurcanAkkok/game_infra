#!/bin/bash

kind create cluster --config ./kind_config.yaml && \
  kubectl create ns metallb-system && \
  kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml && \
  kubectl apply -f ./metallb_config.yaml
