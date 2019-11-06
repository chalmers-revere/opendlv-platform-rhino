#!/bin/bash

echo Root password?
read root_password

echo Revere user password?
read user_password

hdd=/dev/`lsblk | grep disk | grep 119.2G | cut -d ' ' -f1`

wget https://raw.github.com/chalmers-revere/opendlv.os/master/x86/get.sh
sh get.sh

# Disabling rt-kernel due to missing sensor driver to monitor CPU temp.
# cp setup-available/setup-chroot-01-rtkernel.sh \
cp setup-available/setup-chroot-02-ptpd.sh \
   setup-available/setup-post-05-docker.sh \
   setup-available/setup-post-06-desktop.sh \
   .

sed_arg="s/hostname=.*/hostname=revere-rhino-x86_64-2/; \
  s/root_password=.*/root_password=${root_password}/; \
  s/user_password=.*/user_password=( ${user_password} )/; \
  s/lan_dev=.*/lan_dev=enp0s20f0u1u4/; \
  s/eth_dhcp_client_dev=.*/eth_dhcp_client_dev=( enp0s20f0u1u4 )/; \
  s%hdd=.*%hdd=${hdd}%; \

chmod +x *.sh

su -c ./install.sh -s /bin/bash root
