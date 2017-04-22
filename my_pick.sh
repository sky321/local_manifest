#!/bin/bash

#. build/envsetup.sh

#temp fix for ogg/vorbis
pushd hardware/qcom/audio-caf/msm8996
git fetch https://review.lineageos.org/LineageOS/android_hardware_qcom_audio refs/changes/64/163564/3 && git cherry-pick FETCH_HEAD
popd

#add Magisk
pushd build
wget https://github.com/nvertigo/android_build/commit/63a305e3312595f73d4e037e66bdfed87ecc1d20.patch -O - | git am
wget https://github.com/nvertigo/android_build/commit/ab9e918cfabb27f9895d1738af2cf226708361a5.patch -O - | git am
popd

#microG
pushd frameworks/base
#Add signature Spoofing permission
wget https://github.com/nvertigo/android_frameworks_base/commit/ab2aa7fbb522e8b4a85772836345382d22e4ee13.patch -O - | git am
#Allow location providers also outside of /system
wget https://github.com/nvertigo/android_frameworks_base/commit/6408344bc9ef06dd264a5ad4431659e21ff675d5.patch -O - | git am
popd
