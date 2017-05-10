#!/bin/bash

# This script needs to know where you build root resides.
# Set LAOSROOT accordingly, or it will not work.
# LOASROOT has to be an absolute path!

LAOSROOT=/mnt/export/data/src/cm14/

# You need to clone https://github.com/LineageOMS/merge_script
# LOMSDIR is the absolute path to where you cloned merge_script.

LOMSDIR=/mnt/export/data/src/cm14/my_tmp/merge_oms

# This is NOT synced by repo sync. So we take care of it:
pushd ${LOMSDIR}
git pull
git status
popd


. build/envsetup.sh

read -p "Press ENTER..."

pushd frameworks/base
#microG
#Add signature Spoofing permission
wget https://github.com/nvertigo/android_frameworks_base/commit/995cd65ea42897b7adb4ea0fa837bb199eebc5b2.patch -O - | git am
#Allow location providers also outside of /system
wget https://github.com/nvertigo/android_frameworks_base/commit/cca0a256a0b237d0df5a97a84c5ad23a7848b249.patch -O - | git am
popd

read -p "Press ENTER..."

repopick -t network-traffic

read -p "Press ENTER..."

pushd frameworks/base
#DASH
#BatteryService: add dash charging support
wget https://github.com/nvertigo/android_frameworks_base/commit/0e35a53553f65710237d953bc5359ab94517018d.patch -O - | git am
popd

pushd frameworks/av
#OnePlus OSS addition
#CameraService: addition from OSS for OnePlusCamera (found by Kevin Mckee <kxzxxx@gmail.com>)
wget https://github.com/nvertigo/android_frameworks_av/commit/0336495c64b5cd7f3085888a968791bde7ace41f.patch -O - | git am
popd

read -p "Press ENTER..."

# get the LineageOMS commits:
${LOMSDIR}/lineage_oms_merge.sh ${LAOSROOT}
