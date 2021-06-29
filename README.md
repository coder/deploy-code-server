# deploy-code-server 🚀

A collection of one-click buttons and scripts for deploying [code-server](https://github.com/cdr/code-server) to various cloud hosting platforms. The fastest way to get a code-server environment! ☁️

|                                                                                                                 | Name              | Type          | Lowest-Price Plan             | Deploy                                                  |
| --------------------------------------------------------------------------------------------------------------- | ----------------- | ------------- | ----------------------------- | ------------------------------------------------------- |
| [![AWS EC2](img/logo/aws-ec2.png)](https://aws.amazon.com/ec2)                                                  | AWS EC2           | VM            | Free Tier, 1 CPU, 1 GB RAM    | [see guide](guides/aws-ec2.md)                          |
| [![DigitalOcean](img/logo/digitalocean.png)](https://digitalocean.com)                                          | DigitalOcean      | VM            | $5/mo, 1 CPU, 1 GB RAM        | [see guide](guides/digitalocean.md)                     |
| [![Vultr](img/logo/vultr.png)](https://vultr.com)                                                               | Vultr             | VM            | $3.50/mo, 1 CPU, 512 MB RAM   | coming soon                                             |
| [![Linode](img/logo/linode.png)](https://linode.com)                                                            | Linode            | VM            | $5/mo, 1 CPU, 1 GB RAM        | [see guide](guides/linode.md)                           |
| [![Railway](img/logo/railway.png)](https://railway.app)                                                         | Railway           | Container     | Free, Shared CPU, 1 GB RAM 🚀 | [see guide](guides/railway.md)                          |
| [![Heroku](img/logo/heroku.png)](https://heroku.com)                                                            | Heroku            | Container     | Free, 1 CPU, 512 MB RAM       | [see guide](guides/heroku.md)                           |
| [![Azure App Service](img/logo/azure-app-service.png)](https://azure.microsoft.com/en-us/services/app-service/) | Azure App Service | Container     | Free, 1 CPU, 1 GB RAM         | [see guide](https://github.com/bpmct/code-server-azure) |
| [![Coder](img/logo/coder.png)](https://coder.com/docs)                                                          | Coder             | Dev Workspace | For developer teams 👨🏼‍💻        | [read the docs](https://coder.com/docs)                 |

---

## code-server on a VM vs. a Container

- VMs are deployed once, and then can be modified to install new software
  - You need to save "snapshots" to use your latest images
  - Storage is always persistent, and you can usually add extra volumes
  - VMs can support many workloads, such as running Docker or Kubernetes clusters
  - [👀 Docs for the VM install script](deploy-vm/)
- Deployed containers do not persist, and are often rebuilt
  - Containers can shut down when you are not using them, saving you money
  - All software and dependencies need to be defined in the `Dockerfile` or install script so they aren't destroyed on a rebuild. This is great if you want to have a new, clean environment every time you code
  - Storage may not be redundant. You may have to use [rclone](https://rclone.org/) to store your filesystem on a cloud service, for info:
- [📄 Docs for code-server-deploy-container](deploy-container/)
