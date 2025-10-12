#!/bin/sh
set -e

# Wait for MariaDB to be reachable to improve first UX
i=1
while [ $i -le 60 ]; do
  if nc -z mariadb 3306; then
    break
  fi
  sleep 1
  i=$((i+1))
done

mkdir -p /run/php
chown -R nobody:nobody /var/www/html

exec /usr/sbin/php-fpm82 -F -R
