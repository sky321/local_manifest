#!/bin/bash

BUILD_ROOT=/usr/local/src/los16
LOCAL_MANIFEST=my_tmp/local_manifest

export BUILD_ROOT LOCAL_MANIFEST

cd ${BUILD_ROOT}

source build/envsetup.sh

# safer git:
# checks for the return value of git and waits for
# user input to continue.

safer-git() {
    git $*
    if [ "$?" -gt "0" ] ; then
      read -p "$0 $*: ENTER to continue"
    fi
}

pushd frameworks/base
safer-git fetch nvertigo longshot
safer-git cherry-pick 33d447462cc
safer-git cherry-pick 3bf8a609fdb
safer-git cherry-pick fa23d149345
popd

pushd lineage-sdk
safer-git fetch nvertigo longshot
safer-git cherry-pick 2aa4cea5
popd
