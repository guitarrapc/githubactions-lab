## k8s

```shell
kubectl kustomize ./src/k8s/common/overlays/development
kubectl kustomize ./src/k8s/common/overlays/development | kubeval
kubectl kustomize ./src/k8s/common/overlays/development | kubectl apply -f -
```


## REF

> https://github.com/kubernetes/examples/tree/master/guestbook
