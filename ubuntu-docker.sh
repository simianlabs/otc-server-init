#!/bin/bash -x
echo "*** Installing docker ****"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
apt-get update
apt-get -y install docker-ce
systemctl enable docker
systemctl restart docker
