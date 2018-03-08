#!/bin/bash
if [[ $# < 1 ]]; then
   echo "Must specify the shadowsocks-libev version"
   echo "like: bash $0 3.1.2"
   exit 1
fi

SS_VER=$1
echo "Shadowsocks-libev version is ${SS_VER}"
docker build . --build-arg SS_LIBEV_VER=${SS_VER} \
               -t jack6liu/ss-libev:${SS_VER}
#docker tag jack6liu/ss-libev:kcp-${SS_VER} jack6liu/ss-libev:${SS_VER}

#docker push jack6liu/ss-libev:kcp-${SS_VER}
docker push jack6liu/ss-libev:${SS_VER}

#docker rmi -f jack6liu/ss-libev:kcp-${SS_VER}
docker rmi -f jack6liu/ss-libev:${SS_VER}

#docker pull jack6liu/ss-libev:kcp-${SS_VER}
docker pull jack6liu/ss-libev:${SS_VER}
