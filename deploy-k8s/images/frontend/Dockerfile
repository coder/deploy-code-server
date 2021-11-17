FROM bencdr/dev-env-base:latest

USER root

# Install Node.js
ARG NODE_VERSION=14
RUN curl -sL "https://deb.nodesource.com/setup_$NODE_VERSION.x" | bash -
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y nodejs

# Install yarn
RUN npm install -g yarn

USER coder
