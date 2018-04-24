#!/bin/bash
echo "*** Formating dist ****\n"

if [ -d /dev/xvdb ]
vgcreate DataGroup /dev/xvdb
fi
if [ -d /dev/vdb ]
vgcreate DataGroup /dev/vdb
fi
echo "\n"
lvcreate DataGroup -n VolOpt -L $1G
echo "\n"
echo "n" | mkfs -t ext4 /dev/DataGroup/VolOpt
echo "\n"
set -x
echo "/dev/DataGroup/VolOpt /opt/ ext4 defaults,noatime,nodiratime 0 0" >> /etc/fstab
set +x
echo "\n"
echo "*** Disk DONE ****\n"

