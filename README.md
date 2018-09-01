# rdp
Docker rdp on Ubuntu 18.04

Switched from alpine image as it wasn't really working and I think I prefer a more complete distro for a desktop (albeit larger image)

I think there's probably quite a bit of unnecessary stuff in here at the moment

Environment variables defaults are

RDP_USER=ubuntu
RDP_GROUP=ubuntu
RDP_UID=1000
RDP_GID=1000
RDP_PASSWORD=ubuntu

Run with

docker run -d \
           --rm \
           --name rdp \
           -p 3389:3389 \
           -e RDP_USER=user \
           -e RDP_PASSWORD=password \
           martinjohn/rdp

