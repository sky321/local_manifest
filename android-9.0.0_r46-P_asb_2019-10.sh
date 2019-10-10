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

safer-repopick -t P_asb_2019-10 -e 260565,260566,260567,260568,260570,260605
safer-repopick 260565 260566 -P frameworks/av/
safer-repopick 260567 260568 -P frameworks/base/
safer-repopick 260570 -P packages/apps/Settings
safer-repopick 260605 -P build/make/
