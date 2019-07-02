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

safer-repopick -t P_asb_2019-07 -e 250968,250970,250971,250973
safer-repopick 250968 -P build/make/
safer-repopick 250970 -P frameworks/av/
safer-repopick 250971 -P frameworks/base/
safer-repopick 250973 -P packages/apps/PackageInstaller/
