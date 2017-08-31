#!/bin/bash
#
# start shadowsocks-libev and kcptun-server

ss-server -c /etc/ss-server-config.json 2>&1 &

kcp-server -c /etc/kcp-server-config.json 2>&1