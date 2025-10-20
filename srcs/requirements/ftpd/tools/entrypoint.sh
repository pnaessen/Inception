#!/bin/sh

set -e

FTP_PWD=$FTP_PWD

HOST_IP=$(ip route | awk '/default/ { print $3 }')
echo "pasv_address=${HOST_IP}" >> /etc/vsftpd/vsftpd.conf

if ! id "$FTP_USER" &>/dev/null; then
    adduser -D -G www-data $FTP_USER
fi

echo "$FTP_USER:$FTP_PWD" | chpasswd

chown -R "$FTP_USER:www-data" /home/$FTP_USER
chmod -R 775 /var/www/html

exec $@