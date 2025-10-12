FROM alpine@sha256:b6a6be0ff92ab6db8acd94f5d1b7a6c2f0f5d10ce3c24af348d333ac6da80685

RUN apk update && apk add --no-cache \
    php82 \
    php82-fpm \
    php82-session \
    php82-mysqli \
    php82-pdo \
    php82-pdo_mysql \
    php82-mbstring \
    php82-curl \
    php82-json \
    php82-openssl \
    netcat-openbsd \
    wget

# Symlink php
RUN ln -s /usr/bin/php82 /usr/bin/php

# Download Adminer
RUN mkdir -p /var/www/html && \
    wget -O /var/www/html/index.php https://www.adminer.org/latest.php

# PHP-FPM tune
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php82/php-fpm.d/www.conf && \
    sed -i 's/;clear_env = no/clear_env = no/g' /etc/php82/php-fpm.d/www.conf

COPY ./tools/entrypoint-adminer.sh /usr/local/bin/entrypoint-adminer.sh
RUN chmod +x /usr/local/bin/entrypoint-adminer.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/entrypoint-adminer.sh"]
