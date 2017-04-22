#!/bin/bash

#. build/envsetup.sh

#temp fix for ogg/vorbis
pushd hardware/qcom/audio-caf/msm8996
git fetch https://review.lineageos.org/LineageOS/android_hardware_qcom_audio refs/changes/64/163564/3 && git cherry-pick FETCH_HEAD
popd

#add Magisk
pushd build
wget https://github.com/nvertigo/android_build/commit/63a305e3312595f73d4e037e66bdfed87ecc1d20.patch -O - | git am
popd

#microG
pushd frameworks/base
wget https://github.com/nvertigo/android_frameworks_base/commit/9289822544678bb9f11d24da413ec4a9b9636694.patch -O - | git am
wget https://github.com/nvertigo/android_frameworks_base/commit/24f384ff3e16742a722d101981f84422ba452a99.patch -O - | git am
popd
