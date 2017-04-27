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

read -p "Press ENTER..."

#add Magisk
pushd build
#Build: Switch to Magisk as the built in root
wget https://github.com/nvertigo/android_build/commit/63a305e3312595f73d4e037e66bdfed87ecc1d20.patch -O - | git am
#magisk: delete magisk.zip from system after flashing
wget https://github.com/nvertigo/android_build/commit/5bd6eb23466b8c0b13142b20360fc6e4670e3ba5.patch -O - | git am
popd

read -p "Press ENTER..."

pushd frameworks/base
#microG
#Add signature Spoofing permission
wget https://github.com/nvertigo/android_frameworks_base/commit/029c7d7f1111d6f1cc9d90f6626b49e372afe9d2.patch -O - | git am
#Allow location providers also outside of /system
wget https://github.com/nvertigo/android_frameworks_base/commit/a58a27b7c24f95308f64618ff751e3179b9ca436.patch -O - | git am
popd

read -p "Press ENTER..."

repopick -t network-traffic

read -p "Press ENTER..."

pushd frameworks/base
#DASH
#BatteryService: add dash charging support
wget https://github.com/nvertigo/android_frameworks_base/commit/70ae53640b1165cc9b12ec7d9d3e235a61b7a803.patch -O - | git am
popd


read -p "Press ENTER..."

# get the LineageOMS commits:
${LOMSDIR}/lineage_oms_merge.sh ${LAOSROOT}
