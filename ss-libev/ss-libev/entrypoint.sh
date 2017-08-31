#!/bin/bash
#
# start shadowsocks-libev and kcptun-server

ss-server -c /etc/ss-config.json 2>&1 &
