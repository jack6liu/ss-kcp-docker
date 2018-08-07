#
# Dockerfile for shadowsocks-libev on alpine
#
FROM        alpine:latest
ARG         SS_LIBEV_VER="3.1.2"
ENV         SSL_VER=${SS_LIBEV_VER}
COPY        ./start-ssl.sh /start-ssl.sh
RUN         apk update &&                           \
            apk upgrade &&                          \
            apk add bash curl                       \
                autoconf automake libtool           \
                gettext mbedtls-dev libsodium-dev   \
                pcre-dev libev-dev udns-dev         \
                asciidoc xmlto c-ares-dev           \
                build-base linux-headers git &&     \
            cd / &&                                 \
            curl -k -L -O https://github.com/shadowsocks/shadowsocks-libev/releases/download/v${SSL_VER}/shadowsocks-libev-${SSL_VER}.tar.gz &&  \
            tar -zxf shadowsocks-libev-${SSL_VER}.tar.gz && \
            rm -f shadowsocks-libev-${SSL_VER}.tar.gz &&    \
            cd shadowsocks-libev-${SSL_VER} &&      \
            ./configure && make && make install &&  \
            cd / &&                                 \
            git clone https://github.com/shadowsocks/simple-obfs.git && \
            cd simple-obfs &&                       \
            git submodule update --init --recursive &&     \
            ./autogen.sh && ./configure &&          \
            make && make install &&                 \
            cd / &&                                 \
            chmod +x /start-ssl.sh &&               \
            rm -rf /shadowsocks-libev-${SSL_VER}.tar.gz &&  \
            rm -rf /shadowsocks-libev-${SSL_VER} &&         \
            rm -rf /simple-obfs &&                  \
            rm -rf /var/cache/apk/*
ENTRYPOINT  ["/start-ssl.sh"]
