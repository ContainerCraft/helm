# CCIO Kargo Kubevirt VPC Helm Chart
Features:
  - Ubuntu Bastion    
    - SSH    
    - RDP    
  - VyOS Firewall & Gateway
  - Private NAT Network (vlan)
  - customer username:password mapping
  - live ssh key provisioning and rotation from secret via qemu-guest-agent

Requires:
  - kubevirt & multus enabled kubernetes cluster

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
helm install $NEW_VPC_NAME . --namespace kargo --values ./values.yaml --set user.pass="changeme"
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
  - install kubespray
```sh
touch /tmp/kubeconfig
docker run -it --rm \
    --volume /tmp/kubeconfig:/config:z \
    --environment  KUBE_API_DNS="api.kubespray.home.arpa" \
    --environment HOSTS="192.168.16.61 192.168.16.62 192.168.16.63" \
    --environment VRRP_IP="192.168.16.60" \
  quay.io/containercraft/konductor:kubespray \
    --user usrbinkat \
    -e ansible_ssh_pass=changeme \
    -e ansible_sudo_pass=changeme
```
  - Add hostpath provisioner for storage
```sh
helm install hostpath-provisioner ccio/hostpath-provisioner --namespace hostpath-provisioner --create-namespace
kubectl patch storageclass hostpath-provisioner -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}' 
```
