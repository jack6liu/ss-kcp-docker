#
# Dockerfile for shadowsocks-libev on alpine
#
FROM        alpine:3.6
ENV         SS_VER="3.1.0"                          \
            KCP_VER="20171021"
COPY        ./start-ssl-kcp.sh /start-ssl-kcp.sh
RUN         apk update &&                           \
            apk upgrade &&                          \
            apk add bash curl                       \
                autoconf automake libtool           \
                gettext mbedtls-dev libsodium-dev   \
                pcre-dev libev-dev udns-dev         \
                asciidoc xmlto c-ares-dev           \
                build-base linux-headers git &&     \
            cd / &&                                 \
            curl -k -L -O https://github.com/shadowsocks/shadowsocks-libev/releases/download/v${SS_VER}/shadowsocks-libev-${SS_VER}.tar.gz &&  \
            tar -zxf shadowsocks-libev-${SS_VER}.tar.gz &&     \
            cd shadowsocks-libev-${SS_VER} &&       \
            ./configure && make && make install &&  \
            cd / &&                                 \
            git clone https://github.com/shadowsocks/simple-obfs.git && \
            cd simple-obfs &&                       \
            git submodule update --init --recursive &&         \
            ./autogen.sh && ./configure &&          \
            make && make install &&                 \
            cd / &&                                 \
            curl -k -L -O https://github.com/xtaci/kcptun/releases/download/v${KCP_VER}/kcptun-linux-amd64-${KCP_VER}.tar.gz &&   \
            tar -zxf kcptun-linux-amd64-${KCP_VER}.tar.gz &&   \
            mv server_linux_amd64 /usr/local/bin/kcp-server && \
            mv client_linux_amd64 /usr/local/bin/kcp-client && \
            chmod +x /usr/local/bin/kcp-server &&   \
            chmod +x /usr/local/bin/kcp-client &&   \
            chmod +x /start-ssl-kcp.sh &&           \
            rm -rf /shadowsocks-libev-${SS_VER}.tar.gz &&      \
            rm -rf /shadowsocks-libev-${SS_VER} &&             \
            rm -rf /simple-obfs &&                             \
            rm -f kcptun-linux-amd64-${KCP_VER}.tar.gz &&      \
            rm -rf /var/cache/apk/*
ENTRYPOINT  ["/start-ssl-kcp.sh"]
