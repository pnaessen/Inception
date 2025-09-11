FROM alpine@sha256:b6a6be0ff92ab6db8acd94f5d1b7a6c2f0f5d10ce3c24af348d333ac6da80685


RUN apk update && apk add --no-cache \
    mariadb \
    mariadb-client

COPY ./conf/my.cnf /etc/my.cnf.d/
COPY ./tools/entrypoint-db.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint-db.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/entrypoint-db.sh"]