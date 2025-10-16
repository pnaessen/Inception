FROM alpine@sha256:b6a6be0ff92ab6db8acd94f5d1b7a6c2f0f5d10ce3c24af348d333ac6da80685

RUN apk update && apk add --no-cache \
    php82 \
    php82-fpm \
    php82-mysqli \
    php82-phar \
    php82-mbstring \
    php82-curl \
    php82-xml \
    php82-zip \
    php82-gd \
    php82-openssl \
    php82-json \
    php82-iconv \
    php82-tokenizer \
    php82-redis \
    php82-ctype \
    redis \
    wget \
    curl \
    mariadb-client \
    netcat-openbsd \
    wget

RUN ln -s /usr/bin/php82 /usr/bin/php


RUN sed -i 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php82/php.ini

RUN cd /usr/local/bin && \
    curl -o wp -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp
RUN cd -


COPY ./conf/www.conf /etc/php82/php-fpm.d/www.conf


COPY ./tools/entrypoint-wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint-wp.sh

WORKDIR /var/www/html

EXPOSE 9000

RUN adduser -S -D -G www-data www

ENTRYPOINT ["/usr/local/bin/entrypoint-wp.sh"]