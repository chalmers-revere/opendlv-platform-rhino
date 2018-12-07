#!/bin/bash

echo Root password?
read root_password

echo Revere user password?
read user_password

hdd=/dev/`lsblk | grep disk | grep 111.8G | cut -d ' ' -f1`

wget https://raw.github.com/chalmers-revere/opendlv.os/master/x86/get.sh
sh get.sh

cp setup-available/setup-chroot-01-rtkernel.sh \
   setup-available/setup-chroot-02-ptpd.sh \
   setup-available/setup-post-01-router.sh \
   setup-available/setup-post-05-docker.sh \
   setup-available/setup-post-09-socketcan.sh \
   .

sed_arg="s/hostname=.*/hostname=revere-rhino-x86_64-1/; \
  s/root_password=.*/root_password=${root_password}/; \
  s/user_password=.*/user_password=( ${user_password} )/; \
  s/lan_dev=.*/lan_dev=eno1/; \
  s/eth_dhcp_client_dev=.*/eth_dhcp_client_dev=( enp2s0 enp0s20u1 )/; \
  s%hdd=.*%hdd=${hdd}%; \
  s/  uefi=true/  uefi=false/"
sed -i "$sed_arg" install-conf.sh

sed_arg="s/subnet=.*/subnet=10.40.40.0/; \
	s/dhcp_clients=.*/dhcp_clients=( \
	  'revere-rhino-x86_64-2,00:24:9b:15:4a:ea,40",
	  'axis-m1124-0,ac:cc:8e:23:6e:8d,50', \
	  'velodyne-vlp32c-0,60:76:88:34:34:4d,70', \
	  'cisco-ie2000_16p-0,00:5d:73:67:a5:40,100', \
	  'cisco-ie2000_16p-1,6c:dd:30:b9:a2:c0,101', \
	  'cisco-ie2000_8p-0,ec:bd:1d:c1:93:40,102', \
	  'meinberg-m500-0_0,ec:46:70:00:7f:86,105', \
	  'meinberg-m500-0_1,00:13:95:19:ea:a6,106', \
	  'oxts-gps,70:b3:d5:af:03:73,80', )/"
sed -i "$sed_arg" setup-post-01-router.sh

sed_arg="s/dev=.*/dev=( can0 )/; \
       	s/bitrate=.*/bitrate=( 250000 )/"
sed -i "$sed_arg" setup-post-09-socketcan.sh

chmod +x *.sh

su -c ./install.sh -s /bin/bash root
