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

safer-repopick -t P_asb_2019-08 -e 252607,252608,252609,252610,252615
safer-repopick 252607 -P art/
safer-repopick 252608 -P build/make/
safer-repopick 252609 -P frameworks/av/
safer-repopick 252610 -P frameworks/base/
safer-repopick 252615 -P packages/apps/Settings
