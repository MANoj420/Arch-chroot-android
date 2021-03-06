#!/bin/sh
echo -e ""
echo -e "\x1b[32m\033[1m#################################"
echo -e "\x1b[32m#      Script by Manoj     #"
echo -e "\x1b[32m#################################"
export PATH=/sbin:/usr/bin:/usr/sbin:/system/bin:/system/xbin:$PATH
export USER=root
export HOME=/root
export LANGUAGE=C
export LANG=C
folder=/data/local/tmp/arch
echo -e "\x1b[33m [ Mounting system folders ]"
echo "   [ Mounting /dev ... ]"
busybox mount --bind /dev $folder/dev
echo "   [ Mounting /sys ... ]"
busybox mount --bind /sys $folder/sys
echo "   [ Mounting /proc ... ]"
busybox mount --bind /proc $folder/proc
echo "   [ Mounting /dev/pts ... ]"
busybox mount --bind /dev/pts $folder/dev/pts
echo "   [ Mounting /storage ... ]"
busybox mount --bind /storage $folder/storage
echo -e "\x1b[32m [ Mounting Done ! ]"

echo -e "\x1b[32m [ Chrooting ... ]\e[0m"
busybox chroot $folder /bin/su - root

echo -e "\033[1m\x1b[33m [ Unmounting dev/pts ... ]"
busybox umount $folder/dev/pts
echo -e " [ Unmounting /dev ... ]"
busybox umount $folder/dev
echo -e " [ Unmounting /proc ... ]"
busybox umount $folder/proc
echo -e " [ Unmounting storage ... ]"
busybox umount $folder/storage
echo -e " [ Unmounting /sys ... ]"
busybox umount $folder/sys
echo -e " \x1b[32m[ Unmounted ]\e[0m"