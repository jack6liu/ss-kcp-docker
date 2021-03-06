#
# Dockerfile for shadowsocks-libev on alpine
#
FROM        alpine:latest
ARG         SS_LIBEV_VER="3.1.3"
ARG         KCPTUN_VER="20180316"
ARG         UDPSPEEER_VER="20180522.0"
ENV         SSL_VER=${SS_LIBEV_VER}                 \
            KCP_VER=${KCPTUN_VER}                   \
            USP_VER=${UDPSPEEER_VER} 
COPY        ./start-ssl-kcp.sh /start-ssl-kcp.sh
RUN         apk update &&                           \
            apk upgrade &&                          \
            apk add bash curl tar gzip              \
                autoconf automake libtool           \
                gettext mbedtls-dev libsodium-dev   \
                pcre-dev libev-dev udns-dev         \
                asciidoc xmlto c-ares-dev           \
                build-base linux-headers git &&     \
            cd / &&                                 \
            curl -k -L -O https://github.com/shadowsocks/shadowsocks-libev/releases/download/v${SSL_VER}/shadowsocks-libev-${SSL_VER}.tar.gz &&  \
            tar -zxf shadowsocks-libev-${SSL_VER}.tar.gz &&     \
            cd shadowsocks-libev-${SSL_VER} &&      \
            ./configure && make && make install &&  \
            cd / &&                                 \
            git clone https://github.com/shadowsocks/simple-obfs.git && \
            cd simple-obfs &&                       \
            git submodule update --init --recursive &&         \
            ./autogen.sh && ./configure &&          \
            make && make install &&                 \
            cd / &&                                 \
            curl -k -L -O https://github.com/xtaci/kcptun/releases/download/v${KCP_VER}/kcptun-linux-amd64-${KCP_VER}.tar.gz &&    \
            tar -xvf kcptun-linux-amd64-${KCP_VER}.tar.gz &&   \
            mv server_linux_amd64 /usr/local/bin/kcp-server && \
            mv client_linux_amd64 /usr/local/bin/kcp-client && \
            cd / &&                                 \
            curl -k -L -O https://github.com/wangyu-/UDPspeeder/releases/download/${USP_VER}/speederv2_linux.tar.gz &&             \
            tar -xvf speederv2_linux.tar.gz    &&   \
            mv speederv2_amd64 /usr/local/bin/speederv2 &&     \
            chmod +x /usr/local/bin/kcp-server &&   \
            chmod +x /usr/local/bin/kcp-client &&   \
            chmod +x /usr/local/bin/speederv2 &&    \
            chmod +x /start-ssl-kcp.sh &&           \
            rm -rf /shadowsocks-libev-${SSL_VER}.tar.gz &&     \
            rm -rf /shadowsocks-libev-${SSL_VER} &&            \
            rm -rf /simple-obfs &&                             \
            rm -rf /kcptun-linux-amd64-${KCP_VER}.tar.gz &&    \
            rm -rf /speederv2_* &&                             \
            rm -rf /version.txt &&                             \
            rm -rf /var/cache/apk/*
ENTRYPOINT  ["/start-ssl-kcp.sh"]
