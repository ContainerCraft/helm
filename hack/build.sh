helm package konductor --destination ./charts
helm repo index --url https://containercraft.io/helm .
cp index.yaml charts/index.yaml -f
