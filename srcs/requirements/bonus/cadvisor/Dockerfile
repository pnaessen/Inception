FROM alpine:latest

RUN apk add --no-cache wget ca-certificates libc6-compat libcap

RUN wget -q https://github.com/google/cadvisor/releases/download/v0.53.0/cadvisor-v0.53.0-linux-amd64 \
    -O /usr/local/bin/cadvisor && \
    chmod +x /usr/local/bin/cadvisor

EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/cadvisor"]