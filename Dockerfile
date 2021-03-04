# Start with our deploy-container image (Debian)
FROM bencdr/deploy-container:latest 

USER coder

# You can add custom software and dependencies for your environment here. Some examples:

# RUN code-server --install-extension esbenp.prettier-vscode
# RUN sudo apt-get install -y build-essential
# RUN COPY myTool /home/coder/myTool
