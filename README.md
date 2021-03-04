# deploy-code-server

A collection of one-click buttons and tutorials for deploying code-server to various cloud hosting platforms. The fastest way to get a code-server environment! ☁️

| Platform          | Type             | Cheapest Plan                         | Deploy                                                                                                                                                                                                                                                                                                                                         |
| ----------------- | ---------------- | ------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| DigitalOcean      | VM               | $5/mo, 1 CPU, 1 GB RAM                | Test                                                                                                                                                                                                                                                                                                                                           |
| Vultr             | VM               | $5/mo, 1 CPU, 1 GB RAM                | Test                                                                                                                                                                                                                                                                                                                                           |
| Linode            | VM               | $3.50/mo, 1 CPU, 512 MB RAM           | Test                                                                                                                                                                                                                                                                                                                                           |
| Railway           | Deploy Container | Free, specs unknown, but very fast 🚀 | [![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new?template=https%3A%2F%2Fgithub.com%2Fbpmct%2Fcode-server-railway&envs=PASSWORD%2CGIT_REPO&PASSWORDDesc=Your+password+to+log+in+to+code-server+with&GIT_REPODesc=A+git+repo+to+clone+and+open+in+code-server+%28ex.+https%3A%2F%2Fgithub.com%2Fcdr%2Fdocs.git%29) |
|  |
| Heroku            | Deploy Container | Free, 1 CPU, 512 MB RAM               | [![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)                                                                                                                                                                                                                                                            |
|                   |
| Azure App Service | Deploy Container | Free, 1 CPU, 1 GB RAM                 | Test                                                                                                                                                                                                                                                                                                                                           |

---

## Using a VM vs. Deploying a Container

- VMs are deployed once, and then can be modified to install new software
  - You need to save "snapshots" to use your latest images
  - Storage is always persistent, and you can usually add extra volumes
  - VMs can support many workloads, such as running Docker or Kubernetes clusters
- App Platforms deploy code-server containers, and are often rebuilt
  - App platforms can shut down when you are not using it, saving you money
  - All software and dependencies need to be defined in the `Dockerfile` or install script so they aren't destroyed on a rebuild
  - Storage may not be redundant. You may have to use [rclone](https://rclone.org/) to store your filesystem on a cloud service
