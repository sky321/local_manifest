#!/bin/bash

BUILD_ROOT=/usr/local/src/los16
LOCAL_MANIFEST=my_tmp/local_manifest

export BUILD_ROOT LOCAL_MANIFEST

cd ${BUILD_ROOT}

source build/envsetup.sh

# safer repopick:
# checks for the return value of repopick and waits for
# user input to continue.

safer-repopick() {
    repopick $*
    if [ "$?" -gt "0" ] ; then
      read -p "$0 $*: ENTER to continue"
    fi
}

# Crash app on foreground service notification error
safer-repopick 235128 -P frameworks/base -f

# pie linked volume
safer-repopick 235978 236184 -P packages/apps/Settings
safer-repopick 235986 -P frameworks/base

# pie-qcom-sepolicy
safer-repopick -t pie-qcom-sepolicy

# pie-battery-styles
safer-repopick 221756 227930 -P packages/apps/LineageParts/
safer-repopick 232663 -P vendor/lineage
safer-repopick 221716 -P frameworks/base/
safer-repopick 227931 -P lineage-sdk/

# SystemUI: Remove unused resources
safer-repopick 242684 -P frameworks/base

# Add ChargingStarted + InCallNotif to AudioPackage
safer-repopick 242893 -P frameworks/base

# Include InCallNotification.ogg in AllAudio.mk file
safer-repopick 242894 -P frameworks/base

# Sounds: Squashed cleanup of sound files
safer-repopick 236765 -P frameworks/base

# SDCLANG-6: fix declaration
safer-repopick 219760 -P system/nfc/

# SystemUI: allow devices override audio panel location
safer-repopick 236982 -P frameworks/base -f

# pie-msim-ringtones
safer-repopick -t pie-msim-ringtones -e 233633,233634,237209
safer-repopick 233633 -P frameworks/base/
safer-repopick 233634 -P packages/apps/Settings/
safer-repopick 237209 -P vendor/lineage/

# lineagehw-hidl
safer-repopick 241116
safer-repopick -t lineagehw-hidl -e 241116,241004
safer-repopick 241004 -P lineage-sdk/

# lineage-sepolicy-fix & op3: Rewrite livedisplay HAL sepolicy
safer-repopick -t lineage-sepolicy-fix
safer-repopick 241763 -P device/oneplus/oneplus3/

# pie-caf-imports
safer-repopick -t pie-caf-imports

# RIP libhealthd.lineage
safer-repopick 242432 -P vendor/lineage/

# Make custom off-mode charging screen great again
safer-repopick 242433 -P vendor/lineage/

# Allow Gallery to access system_app_data_file
safer-repopick 242792
