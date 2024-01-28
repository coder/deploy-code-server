RUN pkg update
RUN pkg upgrade
RUN pkg install proot-distro
RUN proot-distro list
RUN proot-distro install ubuntu
RUN proot-distro login ubuntu
RUN apt update
RUN apt upgrade
RUN apt install wget
RUN wget https://github.com/coder/code-server/releases/download/v4.16.1/code-server-4.16.1-linux-arm64.tar.gz
RUN tar -xvf ./code-server-4.16.1-linux-arm64.tar.gz
RUN cd code-server-4.16.1-linux-arm64
RUN cd bin
RUN export PASSWORD="password"
RUN ./code-server
