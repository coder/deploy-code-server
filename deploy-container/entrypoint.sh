#!/bin/bash

START_DIR=/home/coder/project

# add rclone config and start rclone, if supplied
if [[ -z "${RCLONE_DATA}" ]]; then
    echo "RCLONE_DATA is not specified. Files will not persist"

    # Clone the git repo, if it exists
    [ -z "${GIT_REPO}" ] && echo "No GIT_REPO specified"; git clone $GIT_REPO $START_DIR

else
    echo "Copying rclone config..."
    mkdir -p /home/coder/.config/rclone/
    touch /home/coder/.config/rclone/rclone.conf
    echo $RCLONE_DATA | base64 -d > /home/coder/.config/rclone/rclone.conf

    # Full path to the remote filesystem
    RCLONE_REMOTE_PATH=${RCLONE_REMOTE_NAME:-code-server-remote}:${RCLONE_DESTINATION:-code-server-files}
    RCLONE_SOURCE_PATH=${RCLONE_SOURCE:-$START_DIR}
    echo "rclone sync $RCLONE_SOURCE_PATH $RCLONE_REMOTE_PATH -vv" > /home/coder/push_remote.sh
    echo "rclone sync $RCLONE_REMOTE_PATH $RCLONE_SOURCE_PATH -vv" > /home/coder/pull_remote.sh
    chmod +x push_remote.sh pull_remote.sh

    if rclone ls $RCLONE_REMOTE_PATH; then
        # grab the files from the remote instead of re-cloning the git repo
        echo "Pulling existing files from remote..."
        /home/coder/pull_remote.sh&
    else
        # we need to clone the git repo and sync
        echo "Pushing initial files to remote..."
        [ -z "${GIT_REPO}" ] && echo "No GIT_REPO specified" && mkdir -p $START_DIR && echo "intial file" > $START_DIR/file.txt; git clone $GIT_REPO $START_DIR
        /home/coder/push_remote.sh&
    fi

fi

# Now we can run code-server with the default entrypoint
/usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8080 $START_DIR