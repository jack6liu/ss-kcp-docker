#
# Dockerfile for shadowsocks-libev on alpine
#
FROM        alpine:3.6
LABEL       shadowsocks-libev="3.0.6"               \
            kcptun="20170525"
ENV         SS_PORT=${SS_PORT:-"8388"}              \
            KCP_PORT=${KCP_PORT:-"28388"}
COPY        ./kcp-ss-libev/ /kcp-ss-libev/
RUN         apk update &&                           \
            apk --no-cache add bash wget vim        \
            autoconf automake libtool               \
            gettext mbedtls-dev libsodium-dev       \
            pcre-dev libev-dev udns-dev             \
            asciidoc xmlto                          \
            build-base linux-headers git &&         \
            cd / &&                                 \
            wget --no-check-certificate -c https://github.com/shadowsocks/shadowsocks-libev/releases/download/v3.0.6/shadowsocks-libev-3.0.6.tar.gz && \
            tar -zxf shadowsocks-libev-3.0.6.tar.gz && \
            rm -f shadowsocks-libev-3.0.6.tar.gz && \
            cd shadowsocks-libev-3.0.6 &&           \
            ./configure && make && make install &&  \
            cd / &&                                 \
            git clone https://github.com/shadowsocks/simple-obfs.git && \
            cd simple-obfs &&                       \
            git submodule update --init --recursive && \
            ./autogen.sh && ./configure &&          \
            make && make install &&                 \
            cd / &&                                 \
            wget --no-check-certificate  -c https://github.com/xtaci/kcptun/releases/download/v20170525/kcptun-linux-amd64-20170525.tar.gz && \
            tar -zxf kcptun-linux-amd64-20170525.tar.gz &&     \
            mv server_linux_amd64 /usr/local/bin/kcp-server && \
            mv client_linux_amd64 /usr/local/bin/kcp-client && \
            rm -f kcptun-linux-amd64-20170525.tar.gz && \
            chmod +x /kcp-ss-libev/*.sh &&  \
            bash /kcp-ss-libev/config.sh && \
            rm -rf /var/cache/apk/*
EXPOSE      ${SS_PORT}/tcp ${SS_PORT}/udp ${KCP_PORT}/udp
ENTRYPOINT  ["/kcp-ss-libev/entrypoint.sh"]
