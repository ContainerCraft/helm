#!/bin/bash -x
source ./hack/userdata.yml.tmpl
kubectl create secret generic -nkargo vyos-dmz-cloudconfig --dry-run=client -oyaml --from-file=userdata=./hack/userdata.yml | tee cloudinit.yml 
