FROM alpine@sha256:b6a6be0ff92ab6db8acd94f5d1b7a6c2f0f5d10ce3c24af348d333ac6da80685

RUN apk add --update --no-cache findutils curl php83-cli php83-phar php-fpm \
	php-mysqli php-json	php-curl php-gd php-xml php-mbstring php-zip \
	php-opcache \

COPY ./conf/www.conf /etc/php83/php-fpm.d/www.conf
COPY ./tools/entrypoint-wp.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint-wp.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/entrypoint-wp.sh"]