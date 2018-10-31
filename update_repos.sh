#!/bin/bash

GITUSER="nvertigo"

REPOS="
build/make
device/qcom/sepolicy
external/libtar
frameworks/av
frameworks/base
frameworks/native
packages/apps/Gallery2
packages/apps/LockClock
packages/apps/Settings
packages/apps/WallpaperPicker
system/nfc
system/sepolicy
vendor/lineage"

for i in $REPOS; do
  pushd $i

  git fetch los lineage-15.1
  if [ "$?" -gt "0" ] ; then
    read -p "$i: fetch los lineage-15.1 failed. STRG-C to abort. ENTER to continue"
  fi

  git checkout nlos-15.1
  if [ "$?" -gt "0" ] ; then
    read -p "$i: checkout nlos-15.1 failed. STRG-C to abort. ENTER to continue"
  fi

  git rebase los/lineage-15.1
  if [ "$?" -gt "0" ] ; then
    read -p "$i: rebase on top of los/lineage-15.1 failed. STRG-C to abort. ENTER to continue"
  fi

  git push -f 
  if [ "$?" -gt "0" ] ; then
    read -p "$i: push -f to $GITUSER failed. STRG-C to abort. ENTER to continue"
  fi

  popd
done
