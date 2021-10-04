# CCIO Kargo Kubevirt VPC Helm Chart
Features:
  - Ubuntu Bastion    
    - SSH    
    - RDP    
  - VyOS Firewall & Gateway
  - Private NAT Network (vlan)
  - customer username:password mapping
  - live ssh key provisioning and rotation from secret via qemu-guest-agent

### How To:
  - Add CCIO Helm Chart Repo
```sh
helm repo add ccio https://containercraft.io/helm/
helm repo update
```
  - Create ssh key secret
```sh
export VMUSERNAME=$(whoami)
kubectl create secret generic kubespray-${VMUSERNAME}-sshpubkey \
    --namespace kargo --dry-run=client -oyaml \
    --from-file=key1=$HOME/.ssh/id_rsa.pub \
  | kubectl apply -f -
```
  - Create instance user login password 
```sh
export VMUSERNAME=$(whoami)
kubectl create secret generic kubespray-${VMUSERNAME}-password \
    --namespace kargo --dry-run=client -oyaml \
    --from-literal=password='changeme' \
  | kubectl apply -f -
```
  - Deploy vpc
```sh
export NEW_VPC_NAME=voyager
helm install $NEW_VPC_NAME . --namespace kargo --values ./values.yaml --set user.pass="secretpassword"
```
  - Connect to vm consoles
```sh
virtctl console -nkargo vyos-gateway-voyager-kubespray 
virtctl console -nkargo bastion-voyager-kubespray 
```
  - you can now ssh & rdp to bastion through gateway's public IP
```sh
kubectl get vmi -nkargo -owide
```
