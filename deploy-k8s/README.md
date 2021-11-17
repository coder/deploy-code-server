# deploy-k8s

Some helper scripts and example images for deploying to Kubernetes. These are still a work in progress and the images do not have CI/CD set up.

Note: This is a quick way to get up and running with code-server Helm charts. We recommend managing these workspaces with something other than bash scripts 😂

1. Ensure you have kubectl, helm, installed and your kube context is pointed at an active cluster.
1. Clone this repo and run `init.sh` to clone code-server 
1. Build the images with `build-images.sh`.
1. Edit the examples in `workspaces/` to use your images
1. Run `provision-workspaces.sh` and then `get-deployments.sh`