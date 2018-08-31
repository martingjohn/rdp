#!/bin/sh

# Create user
addgroup -g $RDP_GID $RDP_GROUP
adduser -G $RDP_GROUP -u $RDP_UID -s /bin/sh -D $RDP_USER -h /home
echo "$RDP_USER:$RDP_PASSWORD" | /usr/sbin/chpasswd
echo "$RDP_USER    ALL=(ALL) ALL" >> /etc/sudoers
cp -a /tmp/home /home
chown -R $RDP_USER:$RDP_GROUP /home

# Change user in supervisor file
SED_CMD="s/USER/$RDP_USER/g" && sed -i.bak $SED_CMD /etc/supervisord.conf
SED_CMD="s/SCREEN/$RDP_SCREEN/g" && sed -i.bak2 $SED_CMD /etc/supervisord.conf

# Add the ssh config if needed

if [ ! -f "/etc/ssh/sshd_config" ];
	then
		cp /ssh_orig/sshd_config /etc/ssh
fi

if [ ! -f "/etc/ssh/ssh_config" ];
	then
		cp /ssh_orig/ssh_config /etc/ssh
fi

if [ ! -f "/etc/ssh/moduli" ];
	then
		cp /ssh_orig/moduli /etc/ssh
fi

# generate fresh rsa key if needed
if [ ! -f "/etc/ssh/ssh_host_rsa_key" ];
	then 
		ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
fi

# generate fresh dsa key if needed
if [ ! -f "/etc/ssh/ssh_host_dsa_key" ];
	then 
		ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
fi

#prepare run dir
mkdir -p /var/run/sshd

#prepare xauth
touch /home/.Xauthority
chown $RDP_USER:$RDP_GROUP /home/.Xauthority

# generate machine-id
uuidgen > /etc/machine-id

# set keyboard for all sh users
echo "export QT_XKB_CONFIG_ROOT=/usr/share/X11/locale" >> /etc/profile


source /etc/profile

exec "$@"
