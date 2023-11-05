
## Knative Operator

The file is taken from these links:
https://github.com/knative/operator/releases/download/knative-v1.12.0/operator.yaml
https://knative.dev/docs/install/operator/knative-with-operators/#create-the-knative-serving-custom-resource

```bash
kubectl apply -f knative_operator.yaml
```

Kind image unauthorized fix:
```bash
kubectl patch configmap/config-deployment --namespace knative-serving --type merge --patch '{"data":{"registries-skipping-tag-resolving":"kind.local,ko.local,dev.local,docker.io,index.docker.io"}}'
```

## Istio installation

```bash
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update
helm install istio-base istio/base --namespace istio-system --create-namespace --wait
helm install istiod istio/istiod --namespace istio-system --wait
helm install istio-ingress istio/gateway --namespace istio-ingress --create-namespace --wait
```

## DNS (for kind based installations)

```bash
kubectl patch configmap/config-domain \
      --namespace knative-serving \
      --type merge \
      --patch '{"data":{"uakkok.io":""}}'
```
