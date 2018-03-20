#!/bin/bash
echo "*** Formating dist ****\n"

vgcreate DataGroup /dev/xvdb
echo "\n"
lvcreate DataGroup –n VolOpt –L $1G
echo "\n"
mkfs –t ext4 /dev/DataGroup/VolOpt
echo "\n"
echo "/dev/DataGroup/VolOpt /opt/ ext4 defaults,noatime,nodiratime 0 0" >> /etc/fstab

echo "\n"
echo "*** Disk DONE ****\n"

