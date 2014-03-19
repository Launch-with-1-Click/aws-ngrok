#!/usr/bin/env bash

set -ex

WORK_DIR=`pwd`

apt-get update -y

apt-get install git make mercurial gcc -y

if [ ! -d $WORK_DIR/go ]; then
    hg clone -u release https://code.google.com/p/go
    cd go/src
    ./all.bash
fi

export PATH=$WORK_DIR/go/bin:$PATH

cd $WORK_DIR

if [ ! -d $WORK_DIR/ngrok ]; then
    git clone https://github.com/inconshreveable/ngrok.git
    cd $WORK_DIR/ngrok && make server
    mv $WORK_DIR/ngrok/bin/ngrokd /usr/local/bin/
    export GOOS=windows; export GOARCH=amd64; make client
    export GOOS=darwin; export GOARCH=amd64; make client
    export GOOS=linux; export GOARCH=amd64; make client
fi
