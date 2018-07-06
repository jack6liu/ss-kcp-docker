#!/bin/bash
if [[ -f ./version ]]; then
   source ./version
   echo "./version is found and read."
else
   echo "./version is not found!!!"
   exit 1
fi

if [[ -z ${SSL_VER} ]]; then
   echo "Must specify the shadowsocks-libev [and] KCPTUN [and] UDPSpeeder version"
   echo "Sample of ./version:"
   echo "SSL_VER=3.2.0"
   echo "KCP_VER=20180316"
   echo "USP_VER=20180522.0"
   exit 1
fi

SSL_VER=${SSL_VER:=3.1.3}
KCP_VER=${KCP_VER:=20180316}
USP_VER=${USP_VER:=20180522.0}

echo "SSL_VER is ${SSL_VER}"
echo "KCP_VER is ${KCP_VER}"
echo "USP_VER is ${USP_VER}"

#exit 0

echo "++++++++ STARTED ++++++++"
echo ""
echo "---> Building docker image for SSL+KCP+USP <---"
echo ""
docker build . --build-arg SS_LIBEV_VER=${SSL_VER}  \
               --build-arg KCPTUN_VER=${KCP_VER}    \
               --build-arg UDPSPEEER_VER=${USP_VER} \
               -t jack6liu/ss-libev:kcp-usp-${SSL_VER}

echo "---> Pushing docker image to docker hub <---"
docker push jack6liu/ss-libev:kcp-usp-${SSL_VER}

echo "---> Cleaning local docker images <---"
docker rmi -f jack6liu/ss-libev:kcp-usp-${SSL_VER}

echo "---> Getting the new built docker image <---"
docker pull jack6liu/ss-libev:kcp-usp-${SSL_VER}

echo "++++++++ FINISHED ++++++++"
