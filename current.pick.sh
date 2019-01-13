#!/bin/bash

BUILD_ROOT=/usr/local/src/los16
LOCAL_MANIFEST=my_tmp/local_manifest

export BUILD_ROOT LOCAL_MANIFEST

cd ${BUILD_ROOT}

source build/envsetup.sh

# Crash app on foreground service notification error
repopick 235128 -P frameworks/base -f

# pie linked volume
repopick 235978 236184 -P packages/apps/Settings
repopick 235986 -P frameworks/base

# pie-qcom-sepolicy
repopick -t pie-qcom-sepolicy

# pie-battery-styles
repopick -t pie-battery-styles -e 221716,232663
repopick 232663 -P vendor/lineage
repopick 221716 -P frameworks/base/

read -p "waiting... STRG-C to abort. ENTER to continue"

# pie-network-traffic
repopick -t pie-network-traffic -P frameworks/base

# Sounds: Squashed cleanup of sound files
repopick 236765 -P frameworks/base

# SDCLANG-6: fix declaration
repopick 219760 -P system/nfc/

# SystemUI: allow devices override audio panel location
repopick 236982 -P frameworks/base -f

# power: Add specific powerhal for msm8937
repopick 237769 -P hardware/qcom/power/

# power: msm8937: Update power profile settings
repopick 237770 -P hardware/qcom/power/

# power: Handle launch and interaction hints for perf HAL platforms
repopick 237002 -P hardware/qcom/power/

# power: Build with with BOARD_VNDK_VERSION
repopick 237771 -P hardware/qcom/power/

# pie-qcom-wfd
repopick -t pie-qcom-wfd -e 237206,237194,237173,237352,237174 -P frameworks/base/
repopick 237173 237206
repopick 237352 -P vendor/lineage/

# pie-msim-ringtones
repopick -t pie-msim-ringtones -e 233633,233634,237209
repopick 233633 -P frameworks/base/
repopick 233634 -P packages/apps/Settings/
repopick 237209 -P vendor/lineage/

# config: Add Deskclock to power whitelist
repopick 238057 -P vendor/lineage/

# Revert "AOSP/Messaging: bump targetSDK to 28"
repopick 238551
