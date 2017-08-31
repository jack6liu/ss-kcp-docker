#!/bin/bash
#
# config shadowsocks-libev and kcptun server
#

# for shadowsocks config.json
SS_PORT=${SS_PORT:=8388}
SS_PASSWORD=${SS_PASSWORD:="secret"}

cat > /etc/ss-server-config.json <<EOF
{
    "server": "0.0.0.0",
    "server_port" : ${SS_PORT},
    "password": "${SS_PASSWORD}",
    "local_address": "127.0.0.1",
    "local_port": 1080,
    "timeout": 150,
    "method": "chacha20",
    "fast_open": true,
    "mode": "tcp_and_udp",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=tls"
}
EOF

# for kcptun config.json
KCP_PORT=${KCP_PORT:="28388"}
KCP_KEY=${KCP_KEY:="${SS_PASSWORD}"}
KCP_CRYPT=${KCP_CRYPT:="salsa20"}
KCP_MODE=${KCP_MODE:="fast2"}
KCP_MTU=${KCP_MTU:="1350"}
KCP_SNDWND=${KCP_SNDWND:="1024"}
KCP_RCVWND=${KCP_RCVWND:="1024"}
KCP_DATASHARD=${KCP_DATASHARD:="50"}
KCP_PARITYSHARD=${KCP_PARITYSHARD:="30"}
KCP_DSCP=${KCP_DSCP:="0"}
KCP_NOCOMP=${KCP_NOCOMP:="false"}
KCP_ACKNODELAY=${KCP_ACKNODELAY:="false"}
KCP_NODELAY=${KCP_NODELAY:="0"}
KCP_INTERVAL=${KCP_INTERVAL:="30"}
KCP_RESEND=${KCP_RESEND:="0"}
KCP_NC=${KCP_NC:="0"}
KCP_SOCKBUF=${KCP_SOCKBUF:="4194304"}
KCP_KEEPALIVE=${KCP_KEEPALIVE:="10"}

cat > /etc/kcp-server-config.json <<EOF
{
    "listen": "0.0.0.0:${KCP_PORT}",
    "target": "127.0.0.1:${SS_PORT}",
    "key": "${KCP_KEY}",
    "crypt": "${KCP_CRYPT}",
    "mode": "${KCP_MODE}",
    "mtu": ${KCP_MTU},
    "sndwnd": ${KCP_SNDWND},
    "rcvwnd": ${KCP_RCVWND},
    "datashard": ${KCP_DATASHARD},
    "parityshard": ${KCP_PARITYSHARD},
    "dscp": ${KCP_DSCP},
    "nocomp": ${KCP_NOCOMP},
    "acknodelay": ${KCP_ACKNODELAY},
    "nodelay": ${KCP_NODELAY},
    "interval": ${KCP_INTERVAL},
    "resend": ${KCP_RESEND},
    "nc": ${KCP_NC},
    "sockbuf": ${KCP_SOCKBUF},
    "keepalive": ${KCP_KEEPALIVE}
}
EOF