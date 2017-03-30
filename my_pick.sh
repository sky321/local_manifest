#!/bin/bash

. build/envsetup.sh

#temp fix for ogg/vorbis
pushd hardware/qcom/audio-caf/msm8996
git fetch https://review.lineageos.org/LineageOS/android_hardware_qcom_audio refs/changes/64/163564/3 && git cherry-pick FETCH_HEAD
popd

#stop sim settings from crashing
repopick -t remove_call_barring

#add Magisk
pushd build
wget https://github.com/nvertigo/android_build/commit/4bd296c062c8d17ec6e443c5fed46dc3c1813654.patch -O - | git am
popd

#microG
pushd frameworks/base
wget https://github.com/nvertigo/android_frameworks_base/commit/679fcdf4d1d7e8665a68da9911c3b053d8629080.patch -O - | git am
wget https://github.com/nvertigo/android_frameworks_base/commit/a317b187a398b6a4456fe873aecdd9858d4a657b.patch -O - | git am
popd
