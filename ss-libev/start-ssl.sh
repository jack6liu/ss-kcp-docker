#!/bin/bash
#
# config shadowsocks-libev and kcptun server
#

# for shadowsocks config.json
SS_PORT=${SS_PORT:=12311}
SS_PASS=${SS_PASS:="secret"}
SS_ENCRYPT=${SS_ENCRYPT:="chacha20"}
LOCAL_PORT=${LOCAL_PORT:=12312}
cat > /etc/ssl-config.json <<EOF
{
    "server": "0.0.0.0",
    "server_port" : ${SS_PORT},
    "password": "${SS_PASS}",
    "local_address": "0.0.0.0",
    "local_port": "${LOCAL_PORT}",
    "timeout": 150,
    "method": "${SS_ENCRYPT}",
    "fast_open": true,
    "mode": "tcp_and_udp",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=tls"
}
EOF

ss-server -c /etc/ssl-config.json
