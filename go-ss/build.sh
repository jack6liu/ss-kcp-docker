#!/bin/bash

# start builder container
docker run -itd --name go-ss-builder alpine:3.6

# install golang
docker exec go-ss-builder sh -c "apk update; apk upgrade; apk add go musl-dev git"

# get go-shadowsocks2
docker exec go-ss-builder sh -c "go get -u -v github.com/shadowsocks/go-shadowsocks2; cd /root/go/src/github.com/shadowsocks/go-shadowsocks2/; go build; cp ./go-shadowsocks2 /"

# get binary newly build
docker cp go-ss-builder:/go-shadowsocks2 ./