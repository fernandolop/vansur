#!bin/sh

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
service ssh restart && \
rm -f wp-config.php && \
wget https://raw.githubusercontent.com/fernandolop/vansur/main/wp-config.php && \
