# rdp
Docker rdp

Based on danielguerra/alpine-xfce4-xrdp with some alterations to slim it down and allow username and password to be defined

Environment variables defaults are

RDP_USER=alpine
RDP_GROUP=alpine
RDP_UID=1000
RDP_GID=1000
RDP_PASSWORD=alpine
RDP_SCREEN=1920x1080x24

Run with

docker run -d \
           --rm \
           --shm-size 1g \
           --name rdp \
           -p 3389:3389 \
           -e RDP_USER=user \
           -e RDP_PASSWORD=password \
           -e RDP_SCREEN=1024x768x24 \
           martinjohn/rdp

