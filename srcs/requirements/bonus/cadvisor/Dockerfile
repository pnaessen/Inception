FROM alpine@sha256:b6a6be0ff92ab6db8acd94f5d1b7a6c2f0f5d10ce3c24af348d333ac6da80685

RUN apk add --no-cache wget ca-certificates

RUN wget -q https://github.com/google/cadvisor/releases/download/v0.53.0/cadvisor-v0.53.0-linux-amd64 \
    -O /usr/local/bin/cadvisor && \
    chmod +x /usr/local/bin/cadvisor

COPY --from=builder /cadvisor-bin /usr/local/bin/cadvisor

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/cadvisor"]
