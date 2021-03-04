#!/bin/bash

# Allow user to aupply a start dir, default to /home/coder/project
START_DIR=${1:-/home/coder/project}

# Clone the git repo, if it exists
[ -z "${GIT_REPO}" ] && echo "No GIT_REPO specified"; git clone $GIT_REPO $START_DIR

# add rclone config and start rclone, if supplied
if [[ -z "${RCLONE_DATA}" ]]; then
    echo "RCLONE_DATA is not specified. Files will not persist"
else
    echo "Copying rclone config..."
    mkdir -p /home/coder/.config/rclone/
    touch /home/coder/.config/rclone/rclone.conf
    echo $RCLONE_DATA | base64 -d > /home/coder/.config/rclone/rclone.conf

    # serve remote files on the first item in the rclone config
    # rclone serve sftp code-server-files:/home/coder/ --no-auth --vfs-cache-mode full&
fi

# Now we can run code-server with the default entrypoint
/usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8080 $START_DIR