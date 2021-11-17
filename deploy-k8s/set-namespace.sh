#!/bin/sh

# Pretty lame, but helpful command :)
# kubens is cool too.

# ex: ./set-namespace.sh dev-envs

kubectl config set-context --current --namespace=$1