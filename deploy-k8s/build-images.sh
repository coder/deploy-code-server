#!/bin/sh

# This will build and push public images in the images/ folder to
# DockerHub based on your Docker username with the
# format: $username/dev-env-$folder:latest

set -e

docker_username=$(docker-credential-$(jq -r .credsStore ~/.docker/config.json) list | jq -r '. | to_entries[] | select(.key | contains("docker.io")) | last(.value)')

build_and_push() {
    folder=$1
    basename=$(basename -- "$folder")
    name=${basename%.*}
    docker build $folder -t bencdr/dev-env-$name:latest
    docker push $docker_username/dev-env-$name:latest
}

build_and_push "images/base"

# Build all other images in the images/ folder
# note: if you have multiple base images or heirchal images
# you'll want to build them in a controlled order above and
# exclude them. can be comma or space seperated :)
exclude="images/base"

for folder in images/*; do
    if [[ ! "$exclude" == *"$folder"* ]]; then
        build_and_push $folder
    fi
done