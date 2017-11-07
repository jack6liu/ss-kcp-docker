#
# Dockerfile for shadowsocks-libev on alpine
#
FROM        alpine:3.6
ENV         SS_VERSION="3.1.0"
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
            curl -k -L -O https://github.com/shadowsocks/shadowsocks-libev/releases/download/v${SS_VERSION}/shadowsocks-libev-${SS_VERSION}.tar.gz && \
            tar -zxf shadowsocks-libev-${SS_VERSION}.tar.gz && \
            rm -f shadowsocks-libev-${SS_VERSION}.tar.gz &&    \
            cd shadowsocks-libev-${SS_VERSION} &&   \
            ./configure && make && make install &&  \
            cd / &&                                 \
            git clone https://github.com/shadowsocks/simple-obfs.git && \
            cd simple-obfs &&                       \
            git submodule update --init --recursive && \
            ./autogen.sh && ./configure &&          \
            make && make install &&                 \
            chmod +x /start-ssl.sh &&               \
            rm -rf shadowsocks-libev-${SS_VERSION}.tar.gz && \
            rm -rf shadowsocks-libev-${SS_VERSION} &&        \
            rm -rf simple-obfs &&                   \
            rm -rf /var/cache/apk/*
ENTRYPOINT  ["/start-ssl.sh"]