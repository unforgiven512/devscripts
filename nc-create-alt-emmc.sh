#!/bin/bash

# nc-create-alt-emmc.sh

# definitions
AS="adb shell"
EMMC="/dev/block/mmcblk0"

# warn user
echo -e "\033[31m\033[1mWARNING:\033[0m\033[31m This will delete all data on your /emmc partition.\033[0m"
echo -e "\033[31mIn addition, I make no guarantees about the safety of the rest of your data, or even your device.\033[0m"
echo -e "\033[31mPlease use this script with caution. I disclaim all responsibility for your mistakes from myself.\033[0m"
echo -e "\n\n\033[31m\033[1mIF YOU WOULD LIKE TO CANCEL, PLEASE PRESS CTRL+C WITHIN THE NEXT 10 SECONDS\033[0m"

# give user 10 seconds to cancel
sleep 10

# resize /media (/emmc) partition, creating 1500MB of free space
# XXX: We may have to actually format 8 here with:
# $AS parted -s $EMMC mkfs 8 fat32
#      prior to resizing the partition
$AS parted -s $EMMC resize 8 3811 7691

# create system partition (400 MB)
$AS parted -s $EMMC mkpart logical ext2 2311 2711

# create data partition (1000 MB)
$AS parted -s $EMMC mkpart logical ext2 2711 3711

# create cache partition (100 MB)
$AS parted -s $EMMC mkpart logical ext2 3711 3811

# format partitions
$AS mke2fs ${EMMC}p9
$AS mke2fs -j ${EMMC}p10
$AS mke2fs -j ${EMMC}p11

# tune partitions
$AS tune2fs -c0 -i0 ${EMMC}p9
$AS tune2fs -c0 -i0 ${EMMC}p10
$AS tune2fs -c0 -i0 ${EMMC}p11

## convert partitions to ext4
# system
$AS tune2fs -O extents,uninit_bg,dir_index ${EMMC}p9
$AS e2fsck -fpDC0 ${EMMC}p9
# data
$AS tune2fs -O extents,uninit_bg,dir_index ${EMMC}p10
$AS e2fsck -fpDC0 ${EMMC}p10
# cache
$AS tune2fs -O extents,uninit_bg,dir_index ${EMMC}p11
$AS e2fsck -fpDC0 ${EMMC}p11

# inform the user that everything is complete
echo -e "\n\n\033[1mRepartitioning complete, ready to install your alternate-partition ROM.\033[0m"
