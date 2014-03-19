#!/usr/bin/env bash

set -ex

WORK_DIR=`pwd`

apt-get update -y

apt-get install git make mercurial gcc -y

if [ ! -d $WORK_DIR/go ]; then
    hg clone -u release https://code.google.com/p/go
    cd go/src
    ./all.bash
    GOOS=windows GOARCH=amd64 CGO_ENABLED=0 ./make.bash --no-clean
    GOOS=darwin GOARCH=amd64 CGO_ENABLED=0 ./make.bash --no-clean
    GOOS=linux GOARCH=amd64 CGO_ENABLED=0 ./make.bash --no-clean
fi

export PATH=$WORK_DIR/go/bin:$PATH

cd $WORK_DIR

if [ ! -d $WORK_DIR/ngrok ]; then
    git clone https://github.com/inconshreveable/ngrok.git
    cd $WORK_DIR/ngrok && make server
    mv $WORK_DIR/ngrok/bin/ngrokd /usr/local/bin/
    GOOS=windows GOARCH=amd64 make client
    GOOS=darwin GOARCH=amd64 make client
    GOOS=linux GOARCH=amd64 make client
fi

