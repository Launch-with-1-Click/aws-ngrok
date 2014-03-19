#!/usr/env/bin bash

set -ex

rm -rf /tmp/*
rm -rf /vagrant
rm -f /etc/ssh/ssh_host_*
cd /var/log
find /var/log/ -type f -name '*.log' -exec cp /dev/null {} \;
cp /dev/null /var/log/syslog


yes | cp /dev/null /root/.ssh/authorized_keys
yes | cp /dev/null /root/.bash_history
if [ -d /home/ubuntu ]; then
  yes | cp /dev/null /home/ubuntu/.ssh/authorized_keys
  yes | cp /dev/null /home/ubuntu/.bash_history
fi
history -c

