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

# lineage-sepolicy-fix & op3: Rewrite livedisplay HAL sepolicy
safer-repopick -t lineage-sepolicy-fix
#safer-repopick 241763 -P device/oneplus/oneplus3/

# RIP libhealthd.lineage
safer-repopick 242432 -P vendor/lineage/

# Make custom off-mode charging screen great again
safer-repopick 242433 -P vendor/lineage/

# Update Chromium Webview to 74.0.3729.112
safer-repopick 245252

# p-display-shrink
repopick -t p-display-shrink -e 237500,231828 -P frameworks/base/
repopick 237500 -P packages/apps/Settings
repopick 231828

# SystemUI: Enable and fix QS detail view, adapt layout to Pie
safer-repopick 246850 -P frameworks/base/
