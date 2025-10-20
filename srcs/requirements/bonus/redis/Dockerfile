FROM alpine@sha256:b6a6be0ff92ab6db8acd94f5d1b7a6c2f0f5d10ce3c24af348d333ac6da80685

RUN apk update && apk add --no-cache redis

EXPOSE 6379

ENTRYPOINT ["redis-server", "--protected-mode no"]