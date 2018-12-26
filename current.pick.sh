#!/bin/bash

BUILD_ROOT=/usr/local/src/los16
LOCAL_MANIFEST=my_tmp/local_manifest

export BUILD_ROOT LOCAL_MANIFEST

cd ${BUILD_ROOT}

source build/envsetup.sh

# FDE
repopick -t pie-hw-fde -e 226123,226125,226126,226398,226399
repopick 226398 226399 -P frameworks/base
repopick 226123 226125 226126 -P vendor/lineage/
repopick -t pie-fde-crash-fix -e 234325,235127,234395
repopick 234325 -P frameworks/base

# Crash app on foreground service notification error
repopick 235128 -P frameworks/base

# common: Allow init to relabel I/O sched tuning nodes
repopick 235402

# lineage-sdk: Start Weather service in onUnlockUser.
repopick 235659 -P lineage-sdk/

# pie linked volume
repopick 235978 236184 -P packages/apps/Settings
repopick 235986 -P frameworks/base

# pie-qcom-sepolicy
repopick -t pie-qcom-sepolicy

# pie-battery-styles
repopick -t pie-battery-styles -e 221716,232663
repopick 232663 -P vendor/lineage
repopick 221716 -P frameworks/base/

# pie-su
repopick -t pie-su -e 226142,232442
repopick 226142 232442 -P packages/apps/Settings

# pie-privacy-guard
repopick -t pie-privacy-guard -e 232197,232198
repopick 232197 -P frameworks/base/
repopick 232198 -P packages/apps/Settings

# pie-network-traffic
repopick -t pie-network-traffic -P frameworks/base

# Sounds: Squashed cleanup of sound files
repopick 236765 -P frameworks/base

# SDCLANG-6: fix declaration
repopick 219760 -P system/nfc/

# SystemUI: allow devices override audio panel location
repopick 236982 -P frameworks/base -f

# power: Handle launch and interaction hints for perf HAL platforms
repopick 237002 -P hardware/qcom/power/
