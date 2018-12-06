#!/bin/bash

source build/envsetup.sh

repopick -t android-8.1.0_r52 -e 235696,235698,235699,235700,235702
repopick 235696 -P build/make/
repopick 235698 -P frameworks/av/
repopick 235699 -P frameworks/base/
repopick 235700 -P frameworks/native/
repopick 235702 -P system/nfc/
