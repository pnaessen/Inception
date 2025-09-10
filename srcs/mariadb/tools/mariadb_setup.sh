#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --rpm
fi

# mkdir -p /run/mysqld
# chown mysql:mysql /run/mysqld

mysqld_safe --user=mysql &

sleep 5

mariadb -u root -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -u root -e "ALTER USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -u root -p"$MYSQL_PASSWORD" -e "FLUSH PRIVILEGES;"
# mysql -u root -e << EOF
# CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
# CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY PASSWORD '$MYSQL_PASSWORD';
# ALTER USER '$MYSQL_USER'@'%' IDENTIFIED BY PASSWORD '$MYSQL_PASSWORD';
# GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
# FLUSH PRIVILEGES;
# EOF

mysqladmin -u root -p"$MYSQL_PASSWORD" shutdown

exec mysqld_safe 
# --user=mysql