#!/bin/bash
echo "*** Formating dist ****"

vgcreate DataGroup /dev/xvdb
lvcreate DataGroup –n VolOpt –L $1G
mkfs –t ext4 /dev/DataGroup/VolOpt
echo “/dev/DataGroup/VolOpt /opt/ ext4 defaults,noatime,nodiratime 0 0” >> /etc/fstab
echo "*** Disk DONE ****"

