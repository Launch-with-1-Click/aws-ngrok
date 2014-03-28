#!/usr/bin/env bash

set -ex

WORK_DIR=`pwd`
PLATFORMS=('windows' 'darwin' 'linux')

apt-get update -y
apt-get install git make mercurial gcc apache2 chkconfig zip -y


# setup apache2

cat > /etc/apache2/sites-enabled/000-default <<'EOL'
<VirtualHost *:8080>
    ServerAdmin webmaster@localhost

    DocumentRoot /var/www
    <Directory />
        Options FollowSymLinks
        AllowOverride None
    </Directory>
    <Directory /var/www/>
        Options Indexes
        AllowOverride All
        Order allow,deny
        allow from all
    </Directory>
</VirtualHost>
EOL

cat > /etc/apache2/ports.conf <<'EOL'
Listen 8080
EOL

chkconfig apache2 on
service apache2 restart
rm -f /var/www/index.html


# install golang

if [ ! -d $WORK_DIR/go ]; then
    hg clone -u release https://code.google.com/p/go
else
    cd $WORK_DIR/go
    hg pull -u
fi

cd $WORK_DIR/go/src
./all.bash
for os in ${PLATFORMS[@]}; do
    GOOS=$os GOARCH=amd64 CGO_ENABLED=0 ./make.bash --no-clean
done

export PATH=$WORK_DIR/go/bin:$PATH


# install ngrok

cd $WORK_DIR

if [ -d $WORK_DIR/ngrok ]; then
    cd $WORK_DIR/ngrok
    git pull
else
    git clone https://github.com/inconshreveable/ngrok.git
    cd $WORK_DIR/ngrok
fi

make server
mv $WORK_DIR/ngrok/bin/ngrokd /usr/local/bin/

for os in ${PLATFORMS[@]}; do
    GOOS=$os GOARCH=amd64 make client
done

cd $WORK_DIR/ngrok/bin
for os in ${PLATFORMS[@]}; do
    if [ -d $os\_amd64 ]; then
        zip -r $os\_amd64.zip $os\_amd64
        mv $os\_amd64.zip /var/www/
    fi
done

