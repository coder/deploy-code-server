FROM bencdr/dev-env-base:latest

USER root

RUN apt-get update
RUN apt-get install -y apt-transport-https gnupg

# Install kubectl
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && apt-get install -y kubectl

# Install helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install gcloud
RUN curl -fsSLo /usr/share/keyrings/cloud.google.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" |   tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    apt-get update && apt-get install -y google-cloud-sdk

# Install AWS CLI
RUN pip3 install awscli

USER coder

# Install terraform
RUN brew tap hashicorp/tap && \
    brew install hashicorp/tap/terraform

# Install kubectx
RUN brew install kubectl

# Install Docker
RUN sudo apt-get install -y docker.io systemd systemd-sysv
RUN systemctl enable docker

USER coder