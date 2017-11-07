#!/bin/bash
#
# config shadowsocks-libev and kcptun server
#

# for shadowsocks config.json
SS_PORT=${SS_PORT:=8388}
SS_PASS=${SS_PASS:="secret"}
SS_ENCRYPT=${SS_ENCRYPT:="chacha20"}

cat > /etc/ss-config.json <<EOF
{
    "server": "0.0.0.0",
    "server_port" : ${SS_PORT},
    "password": "${SS_PASS}",
    "local_address": "127.0.0.1",
    "local_port": 1080,
    "timeout": 150,
    "method": "${SS_ENCRYPT}",
    "fast_open": true,
    "mode": "tcp_and_udp",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=tls"
}
EOF
