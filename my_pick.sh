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
wget https://github.com/nvertigo/android_build/commit/4bd296c062c8d17ec6e443c5fed46dc3c1813654.patch | git am
popd
