FROM alpine:edge

ENV RDP_USER=alpine \
    RDP_GROUP=alpine \
    RDP_UID=1000 \
    RDP_GID=1000 \
    RDP_PASSWORD=alpine \
    RDP_SCREEN=1920x1080x24

# add packages
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk --update \
        --no-cache \
        add \
        adwaita-icon-theme \
        bash \
        ca-certificates \
        dbus \
        faenza-icon-theme \
        ffmpeg-libs \
        firefox-esr \
        libcanberra-gtk3 \
        lxdm \
        mesa-gbm \
        openssh \
        paper-gtk-theme \
        paper-icon-theme \
        setxkbmap \
        slim \
        sudo \
        supervisor \
        thunar-volman \
        ttf-freefont \
        util-linux \
        wayland-libs-server \
        x11vnc \
        xauth \
        xf86-input-mouse \
        xf86-input-keyboard \
        xf86-input-synaptics \
        xf86-video-vesa \
        xfce4 \
        xorg-server \
        xrdp \
        xvfb \
 && rm -rf /tmp/* \
           /var/cache/apk/*

# add scripts/config
ADD etc /etc
ADD docker-entrypoint.sh /bin

ADD home /tmp/home

# prepare xrdp key
RUN xrdp-keygen xrdp auto

EXPOSE 3389 22
VOLUME ["/etc/ssh"]
ENTRYPOINT ["/bin/docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
