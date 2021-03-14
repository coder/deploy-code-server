#!/bin/bash

START_DIR="${START_DIR:-/home/coder/project}"

PREFIX="deploy-code-server"

mkdir -p $START_DIR

# function to clone the git repo or add a user's first file if no repo was specified.
project_init () {
    [ -z "${GIT_REPO}" ] && echo "[$PREFIX] No GIT_REPO specified" && echo "Example file. Have questions? Join us at https://community.coder.com" > $START_DIR/coder.txt || git clone $GIT_REPO $START_DIR
}

# add rclone config and start rclone, if supplied
if [[ -z "${RCLONE_DATA}" ]]; then
    echo "[$PREFIX] RCLONE_DATA is not specified. Files will not persist"

    # start the project
    project_init

else
    echo "[$PREFIX] Copying rclone config..."
    mkdir -p /home/coder/.config/rclone/
    touch /home/coder/.config/rclone/rclone.conf
    echo $RCLONE_DATA | base64 -d > /home/coder/.config/rclone/rclone.conf

    # defasult to true
    RCLONE_VSCODE_TASKS="${RCLONE_VSCODE_TASKS:-true}"

    if [ $RCLONE_VSCODE_TASKS = "true" ]; then
        # copy our tasks config to VS Code
        echo "[$PREFIX] Applying VS Code tasks for rclone"
        cp /tmp/rclone-tasks.json /home/coder/.local/share/code-server/User/tasks.json
        # install the extension to add to menu bar
        code-server --install-extension actboy168.tasks&
    else
        # user specified they don't want to apply the tasks
        echo "[$PREFIX] Skipping VS Code tasks for rclone"
    fi



    # Full path to the remote filesystem
    RCLONE_REMOTE_PATH=${RCLONE_REMOTE_NAME:-code-server-remote}:${RCLONE_DESTINATION:-code-server-files}
    RCLONE_SOURCE_PATH=${RCLONE_SOURCE:-$START_DIR}
    echo "rclone sync $RCLONE_SOURCE_PATH $RCLONE_REMOTE_PATH -vv" > /home/coder/push_remote.sh
    echo "rclone sync $RCLONE_REMOTE_PATH $RCLONE_SOURCE_PATH -vv" > /home/coder/pull_remote.sh
    chmod +x push_remote.sh pull_remote.sh

    if rclone ls $RCLONE_REMOTE_PATH; then
        # grab the files from the remote instead of running project_init()
        echo "[$PREFIX] Pulling existing files from remote..."
        /home/coder/pull_remote.sh&
    else
        # we need to clone the git repo and sync
        echo "[$PREFIX] Pushing initial files to remote..."
        project_init
        /home/coder/push_remote.sh&
    fi

fi

echo "[$PREFIX] Starting code-server..."
# Now we can run code-server with the default entrypoint
/usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8080 $START_DIR