#!/bin/bash
helm repo add jenkinsci https://charts.jenkins.io && \
  helm repo update && \
  kubectl apply -f jenkins-ns.yaml && \
  kubectl apply -f jenkins-pv.yaml && \
  # kubectl apply -f jenkins-sa.yaml && \
  helm upgrade --install jenkins -n jenkins jenkinsci/jenkins
