# Guide: Launching `code-server` on railway.app

[Railway](https://railway.app) is a new cloud development platform! ☁️

Use Railway + code-server to get a dev environment that you can access from any device.

![code-server and railway.app](../img/code-server-railway.png)

## Step 1: Click button to deploy

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template?template=https%3A%2F%2Fgithub.com%2Fcdr%2Fdeploy-code-server&envs=PASSWORD%2CGIT_REPO&PASSWORDDesc=Your+password+to+log+in+to+code-server+with&GIT_REPODesc=A+git+repo+to+clone+and+open+in+code-server+%28ex.+https%3A%2F%2Fgithub.com%2Fcdr%2Fdocs.git%29)

## Step 2: Configure & launch your environment

You'll need to make a new repository which will contain your code-server configuration. If you push changes to this repo (to install NodeJS, for example), it will re-deploy code-server.

<img src="../img/launch-railway.gif" alt="Connected git repo" width="650" />

You also need to specity a `PASSWORD` and a `GIT_REPO` to clone in your environment :)

## Step 3: Modify your environment to add additional tools

1. Open your code server app and open Terminal
2. Type `sudo -i` for get root permission
3. You can modify your environment to add additional tools like you're using VPS

![image.png](https://i.loli.net/2021/09/30/41NQAlSOvKWXair.png)

# WARN: Don't use Railway for mining or do something against their TOS

To update your code-server version, modify the version number on line 2 in your Dockerfile. See the [list of tags](https://hub.docker.com/r/codercom/code-server/tags?page=1&ordering=last_updated) for the latest version.
