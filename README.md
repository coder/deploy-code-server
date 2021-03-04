# deploy-code-server 🚀

A collection of one-click buttons and scripts for deploying code-server to various cloud hosting platforms. The fastest way to get a code-server environment! ☁️

| Platform          | Type             | Cheapest Plan                         | Deploy                                                   |
| ----------------- | ---------------- | ------------------------------------- | -------------------------------------------------------- |
| DigitalOcean      | VM               | $5/mo, 1 CPU, 1 GB RAM                | [see guide](guides/digitalocean.md)                      |
| Vultr             | VM               | $5/mo, 1 CPU, 1 GB RAM                | coming soon                                              |
| Linode            | VM               | $3.50/mo, 1 CPU, 512 MB RAM           | [see guide](guides/linode.md)                            |
| Railway           | Deploy Container | Free, specs unknown, but very fast 🚀 | [see guide](guides/railway.md)                           |
| Heroku            | Deploy Container | Free, 1 CPU, 512 MB RAM               | [see guide](guides/heroku.md)                            |
| Azure App Service | Deploy Container | Free, 1 CPU, 1 GB RAM                 | [see guide](https://github.com/bencdr/code-server-azure) |

---

## Using a VM vs. Deploying a Container

- VMs are deployed once, and then can be modified to install new software
  - You need to save "snapshots" to use your latest images
  - Storage is always persistent, and you can usually add extra volumes
  - VMs can support many workloads, such as running Docker or Kubernetes clusters
  - [👀 Docs for the VM install script](vm-script/)
- App Platforms deploy code-server containers, and are often rebuilt
  - App platforms can shut down when you are not using it, saving you money
  - All software and dependencies need to be defined in the `Dockerfile` or install script so they aren't destroyed on a rebuild
  - Storage may not be redundant. You may have to use [rclone](https://rclone.org/) to store your filesystem on a cloud service, for info:
  - [📄 Docs for code-server-deploy-container](deploy-container/)
