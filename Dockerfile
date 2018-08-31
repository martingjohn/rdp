FROM alpine:edge

ENV RDP_USER=alpine \
    RDP_GROUP=alpine \
    RDP_UID=1000 \
    RDP_GID=1000 \
    RDP_PASSWORD=alpine

# add packages
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk --update \
        --no-cache \
        add \
        alpine-desktop \
        dbus \
        faenza-icon-theme \
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
        wireshark \
        x11vnc \
        xauth \
        xf86-input-mouse \
        xf86-input-keyboard \
        xf86-input-synaptics \
        xfce4 \
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
