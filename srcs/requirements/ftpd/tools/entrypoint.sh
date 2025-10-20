#!/bin/sh

set -e

HOST_IP=$(ip route | awk '/default/ { print $3 }')
echo "pasv_address=${HOST_IP}" >> /etc/vsftpd/vsftpd.conf

mkdir -p /home/$FTP_USER/ftp
mkdir -p /var/www/html

if ! id "$FTP_USER" &>/dev/null; then
    adduser -D -G www-data $FTP_USER
fi

echo "$FTP_USER:$FTP_PWD" | chpasswd

chown -R "$FTP_USER:www-data" /home/$FTP_USER/ftp
chmod -R 755 /home/$FTP_USER
chmod -R 755 /home/$FTP_USER/ftp

exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf