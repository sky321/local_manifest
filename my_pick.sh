#!/bin/bash

# This script needs to know where you build root resides.
# Set LAOSROOT accordingly, or it will not work.
# LOASROOT has to be an absolute path!

LAOSROOT=/mnt/export/data/src/cm14/

# You need to clone https://github.com/nvertigo/merge_script
# LOMSDIR is the absolute path to where you cloned merge_script.

LOMSDIR=/mnt/export/data/src/cm14/my_tmp/merge_oms

# This is NOT synced by repo sync. So we take care of it:
pushd ${LOMSDIR}
git pull
git status
popd


. build/envsetup.sh

#add Magisk
pushd build
#Build: Switch to Magisk as the built in root
wget https://github.com/nvertigo/android_build/commit/63a305e3312595f73d4e037e66bdfed87ecc1d20.patch -O - | git am
#magisk: delete magisk.zip from system after flashing
wget https://github.com/nvertigo/android_build/commit/5bd6eb23466b8c0b13142b20360fc6e4670e3ba5.patch -O - | git am
popd

pushd frameworks/base
#microG
#Add signature Spoofing permission
wget https://github.com/nvertigo/android_frameworks_base/commit/07315b1fc6cf0ff013a88c53608817ea02109189.patch -O - | git am
#Allow location providers also outside of /system
wget https://github.com/nvertigo/android_frameworks_base/commit/14f700ad41c6b3ad2d21d2311d66e74b20990b99.patch -O - | git am
#DASH
#indicate this
wget https://github.com/nvertigo/android_frameworks_base/commit/afce974d9a456fd1e00a469b5ce9cddb811ccb93.patch -O - | git am
popd

repopick -t network-traffic

# get the LineageOMS commits:
${LOMSDIR}/lineage_oms_merge.sh ${LAOSROOT}
