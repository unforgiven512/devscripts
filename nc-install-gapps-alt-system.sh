#!/bin/bash

# install-gapps-nookcolor.sh

echo -e "\033[1m* Mounting alternate system partition...\033[0m"
adb shell 'umount /system'
adb shell 'mount /dev/block/mmcblk0p9 /system'

echo -e "\033[1m* Preparing to install Google Apps...\033[0m"


echo -e "\033[1m* Done.\033[0m"
