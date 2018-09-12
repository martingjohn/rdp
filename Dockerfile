FROM ubuntu:18.04

ENV RDP_USER=ubuntu \
    RDP_GROUP=ubuntu \
    RDP_UID=1000 \
    RDP_GID=1000 \
    RDP_PASSWORD=ubuntu

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
            --no-install-recommends \
            dbus-x11 \
            ffmpeg \
            firefox \
            less \
            libcanberra-gtk3-0 \
            sudo \
            vim \
            xfce4 \
            xfce4-terminal \
            xrdp \
            xorgxrdp \
 && apt-get install -y \
            gnome-core \
 && rm -rf /var/lib/apt/lists/*

ADD docker-entrypoint.sh /bin

EXPOSE 3389

ENTRYPOINT ["/bin/docker-entrypoint.sh"]
