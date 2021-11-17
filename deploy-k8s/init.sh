#!/bin/sh

# This will create a namespace on your cluster
# and ensure you have the proper commands.

# It will also clone code server so that you
# can use the helmchart :)

NAMESPACE=${NAMESPACE:-dev-envs}

git clone https://github.com/cdr/code-server
kubectl create namespace $NAMESPACE

./set-namespace.sh $NAMESPACE

if ! command -v helm &> /dev/null; then
    echo "! Please install the helm: https://helm.sh/docs/intro/install/"
    exit
fi

if ! command -v jq &> /dev/null; then
    echo "! Please install the yq command: https://stedolan.github.io/jq/"
    exit
fi