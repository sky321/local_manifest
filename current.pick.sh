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

# pie-network-traffic
safer-repopick -t pie-network-traffic -P frameworks/base -e 238702
safer-repopick 238702 -P packages/apps/LineageParts/

# Sounds: Squashed cleanup of sound files
safer-repopick 236765 -P frameworks/base

# SDCLANG-6: fix declaration
safer-repopick 219760 -P system/nfc/

# SystemUI: allow devices override audio panel location
safer-repopick 236982 -P frameworks/base -f

# pie-qcom-wfd
safer-repopick -t pie-qcom-wfd -e 237206,237194,237173,237352,237174 -P frameworks/base/
safer-repopick 237173
safer-repopick 237206 -P frameworks/av
safer-repopick 237352 -P vendor/lineage/

# pie-msim-ringtones
safer-repopick -t pie-msim-ringtones -e 233633,233634,237209
safer-repopick 233633 -P frameworks/base/
safer-repopick 233634 -P packages/apps/Settings/
safer-repopick 237209 -P vendor/lineage/

# libril: Fix manual network selection with old modem & op3: Enable workaround for old MCC/MNC format
safer-repopick 230737
safer-repopick 240026 -P device/oneplus/oneplus3/

# settings: Allow accessing LineageSettings via settings command
safer-repopick 226358 -P frameworks/base/

# op3: Convert TouchscreenGestures to touch HAL
safer-repopick 241212 -P device/oneplus/oneplus3/

# op3: Migrate to livedisplay 2.0
safer-repopick 240885 -P device/oneplus/oneplus3/

# op3: livedisplay: Support sysfs backend display modes
safer-repopick 241174 -P device/oneplus/oneplus3/

# lineagehw-hidl
safer-repopick 241116
safer-repopick -t lineagehw-hidl -e 241116,241004
safer-repopick 241004 -P lineage-sdk/
