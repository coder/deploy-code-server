#!/bin/bash

# Allow user to aupply a start dir, default to /home/coder/project
START_DIR=${1:-/home/coder/project}

# Clone the git repo, if it exists
[ -z "${GIT_REPO}" ] && echo "No GIT_REPO specified"; git clone $GIT_REPO $START_DIR

# Now we can run code-server with the default entrypoint
/usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8080 $START_DIR