# ----------------------------------
# Environment: debian
# Minimum Panel Version: 0.7.X
# ----------------------------------
FROM    quay.io/parkervcp/pterodactyl-images:base_debian

LABEL   author="klugemonkey" maintainer="klugemonkey@spawnchunk.com"

ENV     DEBIAN_FRONTEND noninteractive

RUN     apt update -y \
        && apt upgrade -y \
        && apt install -y apt-transport-https wget curl screen iproute2 \
        && wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
        && dpkg -i packages-microsoft-prod.deb \
        && rm packages-microsoft-prod.deb \
        && apt update -y \
        && apt install -y dotnet-sdk-6.0 aspnetcore-runtime-6.0


USER    container
ENV     USER=container HOME=/home/container
WORKDIR /home/container

COPY    ./entrypoint.sh /entrypoint.sh
CMD     ["/bin/bash", "/entrypoint.sh"]
