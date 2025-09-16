FROM alpine@sha256:b6a6be0ff92ab6db8acd94f5d1b7a6c2f0f5d10ce3c24af348d333ac6da80685

RUN apk add --update --no-cache \
    findutils \
    curl \
    php83-cli \
    php83-phar \
    php83-fpm \
    php83-mysqli \
    php83-json \
    php83-curl \
    php83-gd \
    php83-xml \
    php83-mbstring \
    php83-zip \
    php83-opcache \
    mariadb-client

COPY ./conf/www.conf /etc/php83/php-fpm.d/www.conf
COPY ./tools/entrypoint-wp.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint-wp.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/entrypoint-wp.sh"]