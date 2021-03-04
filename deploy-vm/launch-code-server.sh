#!/bin/sh

# install code-server service system-wide
export HOME=/root
curl -fsSL https://code-server.dev/install.sh | sh

# add our helper server to redirect to the proper URL for --link
git clone https://github.com/bpmct/coder-cloud-redirect-server
cd coder-cloud-redirect-server
cp coder-cloud-redirect.service /etc/systemd/system/
cp coder-cloud-redirect.py /usr/bin/

# create a code-server user
adduser --disabled-password --gecos "" coder
echo "coder ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/coder
usermod -aG sudo coder

# copy ssh keys from root
cp -r /root/.ssh /home/coder/.ssh
chown -R coder:coder /home/coder/.ssh

# configure code-server to use --link with the "coder" user
mkdir -p /home/coder/.config/code-server
touch /home/coder/.config/code-server/config.yaml
echo "link: true" > /home/coder/.config/code-server/config.yaml
chown -R coder:coder /home/coder/.config

# start and enable code-server and our helper service
systemctl enable --now code-server@coder
systemctl enable --now coder-cloud-redirect