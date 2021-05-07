#!/bin/sh
clear
echo -e "\x1b[32m\033[1m   #############################################"
echo -e "\x1b[32m #    [ Arch Installation Script by Manoj]    #"
echo -e "\x1b[32m   #############################################"
sleep 1
folder="/data/local/tmp/arch"

if [ -d "$folder" ];
then
        first=1
        echo -e "\x1b[32m [ $folder already exist ]" && sleep 0.5
else
        sleep 1 && echo -e " [ Creating $folder ]"
        mkdir $folder
fi

cd $folder
arch="aarch64"

wget http://archlinuxarm.org/os/ArchLinuxARM-$arch-latest.tar.gz

echo -e "\x1b[33m [ Downloaded ! ]"

sleep 1


echo -e "\x1b[33m [ Now Unpacking File... ]"
tar xzf ArchLinuxARM-$arch-latest.tar.gz
echo -e "\x1b[32m [ Unpacked ! ]"
mkdir $folder/sdcard
mv ArchLinuxARM-$arch-latest.tar.gz /sdcard

echo -e "\x1b[33m [ Fixing Internet ... ]"

busybox chroot $folder /bin/su - root -c '
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf
groupadd -g 3003 aid_inet
groupadd -g 3004 aid_net_raw
groupadd -g 1003 aid_graphics
usermod -g 3003 -G 3003,3004 -a _apt
usermod -G 3003 -a root
pacman -Rns lvm2 linux-firmware linux-aarch64 systemd systemd-sysvcompat libusb netctl dhcpcd device-mapper usbutils libpcap iptables cryptsetup iproute2 xfsprogs s-nail reiserfsprogs pciutils licenses gettext man-db jfsutils procps-ng mdadm haveged inetutils psmisc logrotate sysfsutils iputils texinfo diffutils net-tools 
echo "127.0.0.1 localhost" > /etc/hosts
chmod 755 -R /etc /usr /var /boot /home /mnt /opt /run /srv
'
sleep 1 && echo -e "\x1b[33m [ Done ! ]"
sleep 1
echo -e "\x1b[33m [ Downloaded Arch File has been moved to Internal storage. You can unpack for clean Installation without Downloading ]"
echo -e "\x1b[33m [ To unpack it : go to $folder ]"
echo -e "\x1b[33m [ and type : tar xzf /sdcard/ArchLinuxARM-$arch-latest.tar.gz ]"
echo -e "\x1b[32m [ Installation Completed,You can start Arch system ]"
echo -e " [ Arch is installed at $folder ]\e[0m"

sleep 1
