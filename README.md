# code-server-railway

An image built for deploying code-server to [railway.app](https://railway.app).

To launch your code-server environment, click the button below and log in with GitHub.

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new?template=https%3A%2F%2Fgithub.com%2Fbpmct%2Fcode-server-railway&envs=PASSWORD%2CGIT_REPO&PASSWORDDesc=Your+password+to+log+in+to+code-server+with&GIT_REPODesc=A+git+repo+to+clone+and+open+in+code-server+%28ex.+https%3A%2F%2Fgithub.com%2Fcdr%2Fdocs.git%29)

It will ask you to make a new repo to store this image, so you can add additional software to your repo's `Dockerfile` in the future.

![code-server running inside railway.app](img/code-server-railway.png)

## 💾 Persist your filesystem with `rclone`

This image has built-in support for [rclone](https://rclone.org/) so that your files don't get lost when code-server is re-deployed.

You can do this on any machine, but it works great on the code-server environment itself, or Google Cloud Shell :)

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

Now, you canadd the following the environment variables in the code-server cloud app:

| Environment Variable | Description                                                                                                                                           | Default Value                             | Required |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------- | -------- |
| RCLONE_DATA          | the encoded rclone config you copied in step 3                                                                                                        | n/a                                       | ✅       |
| RCLONE_REMOTE_NAME   | the name of the remote you added in step 2.<br />check with `$ rclone listremotes`                                                                    | code-server-remote                        |          |
| RCLONE_SOURCE        | source directory to sync files in the code-server container                                                                                           | the entire home directory: `/home/coder/` |          |
| RCLONE_DESTINATION   | the path in the remote that rclone syncs to. change this if you have multiple code-server environments, or if you want to better organize your files. | code-server-files                         |          |

---

## Todo:

- [ ] Make rclone logs visible in environment for debugging
