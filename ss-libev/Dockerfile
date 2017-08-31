#
# Dockerfile for shadowsocks-libev on alpine
#
FROM        alpine:3.6
LABEL       shadowsocks-libev="3.0.8"
ENV         SS_PORT=${SS_PORT:-"8388"}
COPY        ./ss-libev/ /ss-libev/
RUN         apk update &&                           \
            apk --no-cache add bash wget            \
            autoconf automake libtool               \
            gettext mbedtls-dev libsodium-dev       \
            pcre-dev libev-dev udns-dev             \
            asciidoc xmlto                          \
            build-base linux-headers git &&         \
            cd / &&                                 \
            wget --no-check-certificate -c https://github.com/shadowsocks/shadowsocks-libev/releases/download/v3.0.8/shadowsocks-libev-3.0.8.tar.gz && \
            tar -zxf shadowsocks-libev-3.0.8.tar.gz && \
            rm -f shadowsocks-libev-3.0.8.tar.gz && \
            cd shadowsocks-libev-3.0.8 &&           \
            ./configure && make && make install &&  \
            cd / &&                                 \
            git clone https://github.com/shadowsocks/simple-obfs.git && \
            cd simple-obfs &&                       \
            git submodule update --init --recursive && \
            ./autogen.sh && ./configure &&          \
            make && make install &&                 \
            chmod +x /ss-libev/*.sh &&              \
            bash /ss-libev/config.sh &&             \
            rm -rf /var/cache/apk/*
EXPOSE      ${SS_PORT}/tcp ${SS_PORT}/udp
ENTRYPOINT  ["/ss-libev/config.sh"]
