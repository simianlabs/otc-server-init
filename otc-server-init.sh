#!/bin/bash -x
echo "*** Formating dist ****"

vgcreate DataGroup /dev/xvdb
lvcreate DataGroup –n VolOpt –L $1G
mkfs –t ext4 /dev/DataGroup/VolOpt
echo “/dev/DataGroup/VolOpt /opt/ ext4 defaults,noatime,nodiratime 0 0” >> /etc/fstab
echo "*** Disk DONE ****"

sleep 5

echo "*** Python fix ***"
apt install -y python2.7
apt-get install -y python2.7-minimal
apt-get install -f -y
apt-get install -y libapache2-mod-wsgi -V
apt-get install -y lsb-release  -V
apt-get install -y python-setuptools  -V
echo "*** Python fix ***"

sleep 5

echo "*** Installing docker ****"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
apt-get update
apt-get -y install docker-ce
systemctl enable docker
systemctl restart docker

sleep 5

echo "*** Installing SaltStack ***"
wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
add-apt-repository "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/2017.7 xenial main"
apt-get update
apt-get -y install salt-minion

set -x
sed -i -e "/hash_type:/c\hash_type: sha256" /etc/salt/minion
echo "id: `hostname`" > /etc/salt/minion.d/minion.conf
echo "master: $2" >> /etc/salt/minion.d/minion.conf
echo "master_port: 4506" >> /etc/salt/minion.d/minion.conf
echo "publish_port: 4505" >> /etc/salt/minion.d/minion.conf
echo "environment: common" >> /etc/salt/minion.d/minion.conf
echo "state_top_saltenv: common" >> /etc/salt/minion.d/minion.conf
echo "default_top: common" >> /etc/salt/minion.d/minion.conf
echo "test: false" >> /etc/salt/minion.d/minion.conf
echo "master_type: str" >> /etc/salt/minion.d/minion.conf
set +x

systemctl enable salt-minion
systemctl restart salt-minion

