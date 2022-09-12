#!bin/sh

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
service ssh restart && \
cd /var/www/html && \
rm -f wp-config.php && \
wget https://raw.githubusercontent.com/fernandolop/vansur/main/wp-config.php
echo "root:12345" | chpasswd

cd /var/www/html && wp core install --url=45.55.105.164 --title=Bitobee --admin_user=test --admin_password=12345 --admin_email=test@test.com  --allow-root
wp plugin install https://raw.githubusercontent.com/fernandolop/vansur/main/all-in-one-wp-migration.6.76.zip --activate --allow-root
cd /var/www/html/wp-content && \
mkdir ai1wm-backups && \
cd ai1wm-backups && \
wget https://bitobee.com/instalador/bitobee1.2.zip &&\
unzip bitobee1.2.zip && \
echo  Permisos
find /var/www/html -type d -exec chmod 0777 {} \;

echo cambiando user
su test
echo instalando core wp
wp ai1wm restore dev.bitobee.com-20220907-105958-699.wpress --alow-root && \
wp core update-db --alow-root
exit

