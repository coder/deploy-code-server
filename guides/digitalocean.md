# deploying `code-server` on DigitalOcean

> ⚠️ The deploy script referenced in this guide uses the code-server --link service which is now deprecated. If this solution does not work for you, we recommend following our guide to use [LetsEncrypt with Caddy](https://coder.com/docs/code-server/latest/guide#using-lets-encrypt-with-caddy) to securely connect to code-server on your VM.


[DigitalOcean](https://digitalocean.com) is an developer-friendly platform with cloud servers. Here is the easiest way to launch code-server on DigitalOcean:

---

1. Log into DigitalOcean and create a new Ubuntu 20.10 droplet with any size, in any region
1. Under "Select additional options," check `User data`. This will allow you to specify a script that will run on first boot.
1. Paste in the contents of [launch-code-server.sh](../deploy-vm/launch-code-server.sh) to the textarea.
1. Create your server. Feel free to add SSH keys or other preferences.
1. Once your server starts, you can simply navigate to the IP address and get forwarded to a secure version of code-server, which will be proxied behind your GitHub account. For information on how this works, see [code-server --link](https://github.com/cdr/code-server#cloud-program-%EF%B8%8F).

   <img src="../img/digitalocean-launch-code-server.gif" alt="DigitalOcean launch code-server" width="800" />

See our [troubleshooting guide](../deploy-vm#troubleshooting) if you are unable to connect after some time.
