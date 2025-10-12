#!/bin/sh

cd /var/www/html

if [ ! -f wp-config.php ]; then

    wp core download --allow-root

    sleep 10

    i=1
    while [ $i -le 30 ]; do
        if nc -z mariadb 3306; then
            sleep 2
            break
        fi
        sleep 2
        i=$((i + 1))
    done

    wp config create --allow-root \
        --dbname=$DB_NAME \
        --dbuser=$DB_USER \
        --dbpass=$DB_PASSWORD \
        --dbhost=$DB_HOST

    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title="$WP_TITLE" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL

    wp user create --allow-root \
        --role=author \
        $WP_USER \
        $WP_USER_EMAIL \
        --user_pass=$WP_USER_PASSWORD

    i=1
    while [ $i -le 60 ]; do
        if nc -z ${REDIS_HOST:-redis} ${REDIS_PORT:-6379}; then
            break
        fi
        sleep 1
        i=$((i + 1))
    done

    wp config set --allow-root WP_CACHE true --raw
    wp config set --allow-root WP_REDIS_HOST ${REDIS_HOST:-redis}
    wp config set --allow-root WP_REDIS_PORT ${REDIS_PORT:-6379} --raw
    wp config set --allow-root WP_REDIS_TIMEOUT 1 --raw
    wp config set --allow-root WP_REDIS_READ_TIMEOUT 1 --raw
    wp config set --allow-root WP_REDIS_DATABASE 0 --raw

    wp plugin install --allow-root redis-cache --activate
    wp redis enable --allow-root || true
fi

mkdir -p /run/php
chown -R nobody:nobody /var/www/html

exec /usr/sbin/php-fpm82 -F -R