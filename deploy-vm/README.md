# Deploying `code-server` on a VM

A simple startup script to run code-server with --link on a VM, designed to run on Ubuntu 20.10.

**Coming soon:** One-click templates in popular marketplaces.

## In this repo

- [launch-code-server.sh](./launch-code-server.sh) - Command tested on Ubuntu machines (uses --link)
- [launch-linode.sh](./launch-linode.sh) - launch-code-server.sh adapted for Linode

## Troubleshooting

- Ensure you have port 80 open on your server's firewall

- SSH or use the built-in console to connect to your machine

  1. Check the code-server status

     ```console
     systemctl status code-server@coder

     # if not working:
     systemctl restart code-server@coder
     ```

  1. Ensure journalctl is capturing logs

     ```console
     journalctl -u code-server@coder
     ```

  1. Ensure the HTTP redirect server is working

     ```console
     systemctl status coder-cloud-redirect

     # systemctl restart coder-cloud-redirect
     ```

## Other scripts

- [code-server, CloudFlare, and Caddy](https://github.com/alec-hs/coder-cloudflare-setup): Sets up code-server and configures CloudFlare DNS
