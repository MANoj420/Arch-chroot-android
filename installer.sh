#!/bin/sh
clear
echo -e "\x1b[32m\033[1m   #############################################"
echo -e "\x1b[32m #    [ arch Installation Script by Manoj ]    #"
echo -e "\x1b[32m   #############################################"
sleep 1
folder="/data/local/tmp/arch"
file="$folder/ArchLinuxARM-aarch64-latest.tar.gz"


if [ -d "$folder" ];
then
        first=1
        echo -e "\x1b[32m [ $folder already exist ]" && sleep 0.5
else
        sleep 1 && echo -e " [ Creating $folder ]"
        mkdir $folder
fi


if [ -f "$file" ] ; then
    sleep 1
    echo -e "\x1b[32m [ rootfs file exists ! ] " && sleep 1
    echo -e "\x1b[32m [ Deleting file ... ] "
    rm "$file" && sleep 1
    echo -e "\x1b[32m [ Done ! ]"
fi


cd $folder
arch=`uname -m`
case "$arch" in
    aarch64|armv8l) arch="arm64" ;;
    armv7l|arm|armhf) arch="armhf" ;;
		*)
			echo -e "\x1b[33m [ Unknown architecture ]"; exit 1 ;;
		esac
		
		
echo " [ Device architecture is $arch ]"
sleep 1
echo -e "\x1b[33m [ Downloading arch lateset ($arch)... ]"
wget http://archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz
echo -e "\x1b[33m [ Downloaded ! ]"

sleep 1

echo -e "\x1b[33m [ Now Unpacking File... ]"
tar xzf ArchLinuxARM-aarch64-latest.tar.gz
echo -e "\x1b[32m [ Unpacked ! ]"
mkdir $folder/storage
mv rootfs-$arch.tar.gz /storage

echo -e "\x1b[33m [ Fixing Internet ... ]"

busybox chroot $folder /bin/su - root -c '
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf
pacman -Rns lvm2 linux-firmware linux-aarch64 systemd systemd-sysvcompat libusb netctl dhcpcd device-mapper usbutils libpcap iptables cryptsetup iproute2 xfsprogs s-nail reiserfsprogs pciutils licenses gettext man-db jfsutils procps-ng mdadm haveged inetutils psmisc logrotate sysfsutils iputils texinfo diffutils net-tools 
echo "127.0.0.1 localhost" > /etc/hosts
'

sleep 1 && echo -e "\x1b[33m [ Done ! ]"
sleep 1
echo -e "\x1b[33m [ Downloaded arch File has been moved to Internal storage. You can unpack for clean Installation without Downloading ]"
echo -e "\x1b[33m [ To unpack it : go to $folder ]"
echo -e "\x1b[33m [ and type : tar xzf /storage/ArchLinuxARM-aarch64-latest.tar.gz ]"
echo -e "\x1b[32m [ Installation Completed,You can start arch system ]"
echo -e " [ arch is installed at $folder ]\e[0m"

sleep 1
