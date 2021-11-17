#!/bin/sh

# This will look in your workspaces/ folder and
# look up the helm deployments in a basic manner

get_deployment() {
    name=$1
    ip=$(kubectl get svc $name-dev-code-server -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
    port=$(kubectl get svc $name-dev-code-server -o jsonpath='{.spec.ports[0].port}')
    image=$(helm get values $name-dev -o json | jq .image.repository)
    echo "$name (image: $image)"
    echo "http://$ip:$port"
    echo $(kubectl get secret $name-dev-code-server -o jsonpath="{.data.password}" | base64 --decode)
    echo "---"
}


for file in workspaces/*.yaml; do
    basename=$(basename -- "$file")
    name=${basename%.*}
    get_deployment $name
done