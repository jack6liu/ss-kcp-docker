#
# Dockerfile for shadowsocks-libev on alpine
#
FROM        alpine:3.6
COPY        ./go-shadowsocks2 /usr/bin/go-shadowsocks2
COPY        ./start-go-ss.sh /start-go-ss.sh
RUN         apk update &&                           \
            apk upgrade &&                          \
            apk add curl bash &&                    \
            chmod +x /usr/bin/go-shadowsocks2 &&    \
            chmod +x /start-go-ss.sh &&             \
            rm -rf /var/cache/apk/*
ENTRYPOINT  ["/start-go-ss.sh"]