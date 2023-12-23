# Guide: Launching `code-server` on Fly.io

Fly.io is a platform for deploying applications to the edge. It's a great fit for Coder because it's easy to deploy, scale, and manage. In this guide, we'll walk through deploying Coder on Fly.io and creating remote workspaces as Fly.io (firecracker) machines.


## Prerequisites

- A Fly.io account. See: https://fly.io/docs/hands-on/sign-up/
- flyctl installed on your local machine. See: https://fly.io/docs/hands-on/install-flyctl

There is a Makefile that does all the steps, but first you need to copy the fly-template.toml to fly.toml and then change the variables in the Makefile and fly.toml yourself. For example:
```sh
FLY_APP_NAME=joeblow-code-server
FLY_APP_REGION=lhr
```

If oyu dont want to use the Makefile, then just do it manaully on a terminal.

## Step 0: Install the flyctl tool

Install the flyctl tool locally...

Windows:
```sh
pwsh -Command "iwr https://fly.io/install.ps1 -useb | iex"
```
Macos:
```sh
brew install flyctl
```
Linux:
```sh
brew install flyctl
```

## Step 1: Signup or login with Fly.io.

```sh
flyctl auth signup
```

## Step 2: List your deployments

```sh
flyctl apps list
flyctl postgres list
```

## Step 3: Create the deployment

```sh
flyctl postgres create --name $(APP_NAME_DB)
flyctl apps create --name $(APP_NAME)
flyctl postgres attach --app $(APP_NAME) $(APP_NAME_DB)
# copy PG_CONNECTION_URL to Makefile...
```

## Step 4: Create the secrets

```sh
flyctl secrets set CODER_PG_CONNECTION_URL=$(PG_CONNECTION_URL) --app $(APP_NAME)
```

## Step 5: Run it 

```sh
flyctl deploy --app $(APP_NAME)
```






