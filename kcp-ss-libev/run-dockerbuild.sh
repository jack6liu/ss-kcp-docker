#!/bin/bash
if [[ $# != 1 ]]; then
   echo "Must specify the shadowsocks-libev version"
   echo "like: bash $0 3.1.2"
   exit 1
fi

SS_VER=$1
echo "Shadowsocks-libev version is ${SS_VER}"
docker build . -t jack6liu/ss-libev:us-kcp-${SS_VER}

docker push jack6liu/ss-libev:us-kcp-${SS_VER}

docker rmi -f jack6liu/ss-libev:us-kcp-${SS_VER}

docker pull jack6liu/ss-libev:us-kcp-${SS_VER}
