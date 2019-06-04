#!/bin/bash

GITUSER="nvertigo"

REPOS="
art
build/make
build/soong
frameworks/av
frameworks/base
hardware/qcom/power
lineage-sdk
packages/apps/Backgrounds
packages/apps/LineageParts
packages/apps/Messaging
packages/apps/PackageInstaller
packages/apps/Settings
vendor/lineage"

for i in $REPOS; do
  pushd $i

  git fetch los lineage-16.0
  if [ "$?" -gt "0" ] ; then
    read -p "$i: fetch los lineage-16.0 failed. STRG-C to abort. ENTER to continue"
  fi

  git checkout nlos-16.0
  if [ "$?" -gt "0" ] ; then
    read -p "$i: checkout nlos-16.0 failed. STRG-C to abort. ENTER to continue"
  fi

  git rebase los/lineage-16.0
  if [ "$?" -gt "0" ] ; then
    read -p "$i: rebase on top of los/lineage-16.0 failed. STRG-C to abort. ENTER to continue"
  fi

  git push -f 
  if [ "$?" -gt "0" ] ; then
    read -p "$i: push -f to $GITUSER failed. STRG-C to abort. ENTER to continue"
  fi

  popd
done
