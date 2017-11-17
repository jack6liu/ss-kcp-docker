#!/bin/bash
#
# get configuration environment
SS_PORT=${SS_PORT:="12511"}
SS_CIPHER=${SS_CIPHER:="AEAD_CHACHA20_POLY1305"}
SS_PASS=${SS_PASS:="secret"}

# start go-shadowsocks2
/usr/bin/go-shadowsocks2 -s :${SS_PORT} -cipher ${SS_CIPHER} -password ${SS_PASS} -verbose