#!/bin/bash
if [[ $# != 1 ]]; then
   echo "Must specify the shadowsocks-libev [and] KCPTUN [and] UDPSpeeder version"
   echo "format: bash $0 [SS_VER] [KCPTUN_VER] [UDPSPEEDER_VER]"
   echo "like: bash $0 3.1.2 20171201 20171125.0"
   echo "OR, can only specify shadowsocks-libev version"
   echo "like: bash $0 3.1.2"
   exit 1
fi
SS_VER=$1
KCP_VER=${KCP_VER:="20171201"}
USP_VER=${USP_VER:="20171125.0"}

if [[ $# = 3 ]]; then
    SS_VER=$1
    KCP_VER=$2
    USP_VER=$3
fi

echo "Shadowsocks-libev version is ${SS_VER}"
docker build . --build-arg SS_LIBEV_VER=${SS_VER}   \
               --build-arg KCPTUN_VER=${KCP_VER}    \
               --build-arg UDPSPEEER_VER=${USP_VER} \
               -t jack6liu/ss-libev:us-kcp-${SS_VER}

docker push jack6liu/ss-libev:us-kcp-${SS_VER}

docker rmi -f jack6liu/ss-libev:us-kcp-${SS_VER}

docker pull jack6liu/ss-libev:us-kcp-${SS_VER}
