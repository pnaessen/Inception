#!/bin/sh

if [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_USER_PWD" ] || [ -z "$MYSQL_DATABASE" ]; then
    echo "Error .env need (MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE)"
    exit 1
fi

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld
chown mysql:mysql /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --basedir=/usr
fi

mariadbd-safe --user=mysql --datadir=/var/lib/mysql &
MARIADB_PID=$!

for i in {1..30}; do
    if mariadb -u root -e "SELECT 1;" > /dev/null 2>&1; then
        break
    fi
    sleep 1
done

mariadb -u root <<EOF
CREATE USER IF NOT EXISTS '${MYSQL_ROOT_USER}'@'%' IDENTIFIED BY '${MYSQL_ROOT_PWD}';
GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_ROOT_USER}'@'%' WITH GRANT OPTION;

ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('${MYSQL_ROOT_PWD}');
ALTER USER '${MYSQL_ROOT_USER}'@'%' IDENTIFIED BY '${MYSQL_ROOT_PWD}';


CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PWD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db LIKE 'test_%';

FLUSH PRIVILEGES;
EOF

mariadb-admin -u root -p"$MYSQL_ROOT_PWD" shutdown
wait $MARIADB_PID

exec mariadbd-safe --user=mysql --datadir=/var/lib/mysql