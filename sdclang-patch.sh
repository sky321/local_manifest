#!/bin/bash

BUILD_ROOT=/usr/local/src/los15
LOCAL_MANIFEST=my_tmp/local_manifest

cd ${BUILD_ROOT}

patch -p1 <${LOCAL_MANIFEST}/display-caf-8996.diff
patch -p1 <${LOCAL_MANIFEST}/media-caf-8996.diff
