#!/bin/bash

#. build/envsetup.sh

#temp fix for ogg/vorbis
pushd hardware/qcom/audio-caf/msm8996
git fetch https://review.lineageos.org/LineageOS/android_hardware_qcom_audio refs/changes/64/163564/3 && git cherry-pick FETCH_HEAD
popd

#revert April fool jokes
pushd vendor/cm
git fetch https://review.lineageos.org/LineageOS/android_vendor_cm refs/changes/78/167678/1 && git cherry-pick FETCH_HEAD
git fetch https://review.lineageos.org/LineageOS/android_vendor_cm refs/changes/79/167679/1 && git cherry-pick FETCH_HEAD
popd

#add Magisk
pushd build
wget https://github.com/nvertigo/android_build/commit/4bd296c062c8d17ec6e443c5fed46dc3c1813654.patch -O - | git am
popd

#microG
pushd frameworks/base
wget https://github.com/nvertigo/android_frameworks_base/commit/679fcdf4d1d7e8665a68da9911c3b053d8629080.patch -O - | git am
wget https://github.com/nvertigo/android_frameworks_base/commit/a317b187a398b6a4456fe873aecdd9858d4a657b.patch -O - | git am
popd
