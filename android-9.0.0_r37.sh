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

safer-repopick -t android-9.0.0_r37 -e 247606,247611,247612,247634,247637
safer-repopick 247606 -P build/make/
safer-repopick 247611 -P frameworks/av/
safer-repopick 247612 -P frameworks/base/
safer-repopick 247634 -P packages/apps/PackageInstaller/
safer-repopick 247637 -P packages/apps/Settings/
