# Kargo Kubevirt VPC
  - (optional) upload ssh key
```sh
kubectl create secret generic user1-kargo-sshpubkey \
    --from-file=sshpubkey=$HOME/.ssh/id_rsa.pub \
    --namespace kargo --dry-run=client -oyaml \
  | kubectl apply -f -
```
  - Deploy vpc
```sh
helm install user1-kargo-vpc . --namespace kargo --values ./values.yaml
```
  - Connect to vm consoles
```sh
virtctl console -nkargo vyos-gateway-user1-kargo-vpc 
virtctl console -nkargo bastion-user1-kargo-vpc 
```
  - you can now ssh & rdp to bastion through gateway's public IP    
