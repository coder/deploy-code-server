# code-server-deploy-container

An container image built for deploying code-server.

## Guides:

- [Deploy on Railway](guides/railway.md)
- [Deploy on Heroku](guides/heroku.md)

Docker Hub: `bencdr/code-server-deploy-container`

---

## Environment variables:

| Variable Name | Description                                                | Default Value |
| ------------- | ---------------------------------------------------------- | ------------- |
| `PASSWORD`    | Password for code-server                                   |
| `USE_LINK`    | Use code-server --link instead of a password (coming soon) | false         |
| `GIT_REPO`    | A git repository to clone                                  |               |

---

## 💾 Persist your filesystem with `rclone`

This image has built-in support for [rclone](https://rclone.org/) so that your files don't get lost when code-server is re-deployed.

You can generate the rclone config on any machine, but it works great on the code-server environment itself, or Google Cloud Shell :)

```sh
# 1. install rclone
# see https://rclone.org/install/ for other install options
$ curl https://rclone.org/install.sh | sudo bash

# 2. create a new rclone remote with your favorite storage provider ☁️
$ rclone config

# 3. Encode your rclone config and copy to your clipboard
$ cat $(rclone config file | sed -n 2p) | base64 --wrap=0 # Linux
$ cat $(rclone config file | sed -n 2p) | base64 --b 0 # MacOS
```

Now, you can add the following the environment variables in the code-server cloud app:

| Environment Variable | Description                                                                                                                                           | Default Value                                | Required |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------- | -------- |
| RCLONE_DATA          | the encoded rclone config you copied in step 3                                                                                                        | n/a                                          | ✅       |
| RCLONE_REMOTE_NAME   | the name of the remote you added in step 2.<br />check with `$ rclone listremotes`                                                                    | code-server-remote                           |          |
| RCLONE_SOURCE        | source directory to sync files in the code-server container                                                                                           | the project directory: `/home/coder/project` |          |
| RCLONE_DESTINATION   | the path in the remote that rclone syncs to. change this if you have multiple code-server environments, or if you want to better organize your files. | code-server-files                            |          |

```sh

# How to use:

$ sh /home/coder/push_remote.sh # save your uncomitted files to the remote

$ sh /home/coder/pull_remote.sh # get latest files from the remote
```

---

## Todo:

- [ ] Make `push_remote` and `pull_remote` commands in path
- [ ] Impliment file watcher or auto file sync in VS Code
- [ ] Attach a "push" on a git stash??
- [ ] Add support for SSH / VS Code remote access
- [ ] Make rclone logs visible in environment for debugging
