#!/bin/bash

echo Root password?
read root_password

echo Revere user password?
read user_password

echo Revere 2.4 GHz Pwd?
read wifi_24GHz_password

echo Revere 5 GHz Pwd?
read wifi_5GHz_password

hdd=/dev/`lsblk | grep disk | grep 119.2G | cut -d ' ' -f1`

wget https://raw.github.com/chalmers-revere/opendlv.os/master/x86/get.sh
sh get.sh

# Disabling rt-kernel due to missing sensor driver to monitor CPU temp.
# cp setup-available/setup-chroot-01-rtkernel.sh \
cp setup-available/setup-chroot-02-ptpd.sh \
   setup-available/setup-post-03-wan_wifi.sh \
   setup-available/setup-post-05-docker.sh \
   setup-available/setup-post-06-desktop.sh \
   .

sed_arg="s/hostname=.*/hostname=revere-rhino-x86_64-2/; \
  s/root_password=.*/root_password=${root_password}/; \
  s/user_password=.*/user_password=( ${user_password} )/; \
  s/lan_dev=.*/lan_dev=enp0s20f0u1u4/; \
  s/eth_dhcp_client_dev=.*/eth_dhcp_client_dev=( enp0s20f0u1u4 )/; \
  s%hdd=.*%hdd=${hdd}%; \
sed -i "$sed_arg" install-conf.sh

sed_arg="s/dev=.*/dev=( wlp58s0 )/; \
  s/essid=.*/essid=( "REVERE 2.4GHz" "REVERE 5GHz" "ASTA2" )/; \
  s/wpa2=.*/wpa2=( ${wifi_24GHz_password} ${wifi_5GHz_password} "pass3" )/; \
sed -i "$sed_arg" setup-post-03-wan_wifi.sh

chmod +x *.sh

su -c ./install.sh -s /bin/bash root
