# Konductor Helm Chart
![screenshot1](./pages/vscode-server.png)

## Quickstart
    
1. Create Namespace
```sh
kubectl create namespace konductor
```

1. Add helm repo
```sh
helm repo add ccio https://containercraft.io/charts/charts && helm repo update
```

1. Deploy Konductor chart
```sh
helm install konductor --namespace konductor ccio/konductor 
```

1. Exec into Konductor
```sh
kubectl exec -n konductor -it $(kubectl get po -n konductor -ojsonpath='{.items[*].metadata.name}') -- connect
```

1. Review and setup Ingress 
```sh
kubectl get -n konductor svc
kubectl get -n konductor ingress
```

1. Access the Konductor container via SSH or VSCode in browser
