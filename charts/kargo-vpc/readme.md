```sh
kubectl create secret generic user1-kargo-sshpubkey -n kargo --from-file=sshpubkey=$HOME/.ssh/id_rsa.pub --dry-run=client -oyaml | kubectl apply -f -
helm install user1-kargo-vpc . --namespace kargo --values ./values.yaml
virtctl console -nkargo vyos-gateway-user1-kargo-vpc 
```
