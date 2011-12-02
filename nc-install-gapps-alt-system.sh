#!/bin/bash

# install-gapps-nookcolor.sh

# DEFINE SOME SHIT
AP="adb push"
AS="adb shell"
SA="/system/app"
SE="/system/etc"
SEP="/system/etc/permissions"
SF="/system/framework"
SL="/system/lib"

echo -e "\033[1m* Mounting alternate system partition...\033[0m"
$AS "umount /system"
$AS "mount /dev/block/mmcblk0p9 /system"

echo -e "\033[1m* Preparing to install Google Apps...\033[0m"
$AS "rm -f $SA/SetupWizard.apk"
$AS "rm -f $SA/Provision.apk"
$AS "rm -f $SA/Gallery2.apk"
$AS "rm -f $SA/LatinIME.apk"
$AS "rm -f $SA/Browser.apk"
$AS "rm -f $SA/Calendar.apk"
$AS "rm -f $SA/CalendarProvider.apk"
$AS "rm -f $SA/DeskClock.apk"
$AS "rm -f $SA/Email.apk"
$AS "rm -f $SA/Exchange.apk"
$AS "rm -f $SA/OpenWnn.apk"
$AS "rm -f $SA/PinyinIME.apk"
$AS "rm -f $SA/QuickSearchBox.apk"
$AS "rm -f $SA/VideoEditor.apk"
$AS "rm -f $SA/VoiceDialer.apk"

echo -e "\033[1m* Installing Google Apps...\033[0m"
# Apps
$AP .$SA/BrowserGoogle.apk $SA
$AP .$SA/CalendarGoogle.apk $SA
$AP .$SA/CalendarProvider.apk $SA
$AP .$SA/ChromeBookmarksSyncAdapter.apk $SA
$AP .$SA/DeskClockGoogle.apk $SA
$AP .$SA/EmailGoogle.apk $SA
$AP .$SA/ExchangeGoogle.apk $SA
$AP .$SA/GalleryGoogle.apk $SA
$AP .$SA/GenieWidget.apk $SA
$AP .$SA/Gmail.apk $SA
$AP .$SA/GoogleBackupTransport.apk $SA
$AP .$SA/GoogleContactsSyncAdapter.apk $SA
$AP .$SA/GoogleFeedback.apk $SA
$AP .$SA/GoogleLoginService.apk $SA
$AP .$SA/GooglePackageVerifier.apk $SA
$AP .$SA/GooglePackageVerifierUpdater.apk $SA
$AP .$SA/GooglePartnerSetup.apk $SA
$AP .$SA/GoogleQuickSearchBox.apk $SA
$AP .$SA/GoogleServicesFramework.apk $SA
$AP .$SA/GoogleTTS.apk $SA
$AP .$SA/LatinImeGoogle.apk $SA
$AP .$SA/MarketUpdater.apk $SA
$AP .$SA/MediaUploader.apk $SA
$AP .$SA/NetworkLocation.apk $SA
$AP .$SA/OneTimeInitializer.apk $SA
$AP .$SA/SetupWizard.apk $SA
$AP .$SA/Talk.apk $SA
$AP .$SA/Vending.apk $SA
$AP .$SA/VideoEditorGoogle.apk $SA
$AP .$SA/VoiceDialer.apk $SA
$AP .$SA/VoiceSearch.apk $SA
$AP .$SA/YouTube.apk $SA

# Etc
$AP .$SEP/com.google.android.maps.xml $SEP
$AP .$SEP/com.google.android.media.effects.xml $SEP
$AP .$SEP/com.google.widevine.software.drm.xml $SEP
$AP .$SEP/features.xml $SEP

# Framework
$AP .$SF/com.google.android.maps.jar $SF
$AP .$SF/com.google.android.media.effects.jar $SF
$AP .$SF/com.google.widevine.software.drm.jar $SF

# Lib
$AP .$SL/libfrsdk.so $SL
$AP .$SL/libvoicesearch.so $SL

echo -e "\033[1m* Fixing permissions...\033[0m"
$AS "chmod 644 $SA/*.apk"
$AS "chmod 644 $SEP/*.xml"
$AS "chmod 644 $SF/*.jar"
$AS "chmod 644 $SL/*.so"

echo -e "\033[1m* Wiping Dalvik-Cache...\033[0m"
$AS "umount /data"
$AS "mount /dev/block/mmcblk0p10 /data"
$AS "rm -rf /data/dalvik-cache/*"

echo -e "\033[1m* Finishing up...\033[0m"
$AS "sync"
$AS "umount /dev/block/mmcblk0p9"
$AS "umount /dev/block/mmcblk0p10"

echo -e "\033[1m* Done.\033[0m"
