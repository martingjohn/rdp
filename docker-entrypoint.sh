#!/bin/sh

# Create user
groupadd -g $RDP_GID $RDP_GROUP
useradd -g $RDP_GID -u $RDP_UID -s /bin/bash -d /home $RDP_USER 
echo "$RDP_USER:$RDP_PASSWORD" | /usr/sbin/chpasswd
echo "$RDP_USER    ALL=(ALL) ALL" >> /etc/sudoers
chown -R $RDP_USER:$RDP_GROUP /home

/etc/init.d/xrdp start

sleep infinity
