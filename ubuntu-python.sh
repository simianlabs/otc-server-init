#!/bin/bash -x
echo "*** Python fix ***"
apt install -y python2.7
apt-get install -y python2.7-minimal
apt-get install -f -y
apt-get install -y libapache2-mod-wsgi -V
apt-get install -y lsb-release  -V
apt-get install -y python-setuptools  -V
echo "*** Python fix ***"
