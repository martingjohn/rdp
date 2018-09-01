FROM ubuntu:18.04

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
            --no-install-recommends \
            dbus-x11 \
            ffmpeg \
            firefox \
            libcanberra-gtk3-0 \
            xfce4 \
            xfce4-terminal \
            xrdp \
            xorgxrdp \
 && apt-get install -y \
            gnome-core \
 && rm -rf /var/lib/apt/lists/*

CMD bash
