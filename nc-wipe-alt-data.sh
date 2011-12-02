#!/bin/bash

# nc-wipe-alt-data.sh

echo -e "\033[1m* Mounting alternate data partition...\033[0m"
adb shell 'umount /data'
adb shell 'mount /dev/block/mmcblk0p10 /data'

echo -e "\033[1m* Deleting userdata...\033[0m"
adb shell 'rm -rf /data/*'

echo -e "\033[1m* Done.\033[0m"
