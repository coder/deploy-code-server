# Start from the code-server Debian base image
FROM codercom/code-server:latest 

USER coder

# Apply VS Code settings
COPY settings.json .local/share/code-server/User/settings.json

# Use bash shell
ENV SHELL=/bin/bash

# Install unzip + rclone (support for remote filesystem)
RUN sudo apt-get update && sudo apt-get install unzip -y
RUN curl https://rclone.org/install.sh | sudo bash

# You can add custom software and dependencies for your environment here
# RUN code-server --install-extension esbenp.prettier-vscode
# RUN sudo apt-get install -y build-essential
# RUN COPY myTool /home/coder/myTool

# Fix permissions
RUN sudo chown -R coder:coder /home/coder/.local

# Port for railway
ENV export PORT=80

# Use our custom entrypoint script first
COPY railway-entrypoint.sh /usr/bin/railway-entrypoint.sh
ENTRYPOINT ["/usr/bin/railway-entrypoint.sh"]
