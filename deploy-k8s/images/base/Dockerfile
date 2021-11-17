FROM codercom/code-server:3.12.0

# Install Homebrew, must be as a non-root user
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV PATH /home/linuxbrew/.linuxbrew/bin:${PATH}

USER root

RUN apt-get update && \
    apt-get install -y python3 python3-pip

USER coder
