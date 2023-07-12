#!/bin/bash

if [[ -z "${1}" ]]; then
    echo "No device specified."
    exit
fi

export TARGET_BOARD_PLATFORM="${1}"
export TARGET_BUILD_VARIANT=user

export ANDROID_BUILD_TOP=$(pwd)
export ANDROID_PRODUCT_OUT=${ANDROID_BUILD_TOP}/out/target/product/${TARGET_BOARD_PLATFORM}
export OUT_DIR=${ANDROID_BUILD_TOP}/out/msm-kernel-${TARGET_BOARD_PLATFORM}

# Create symbolic for external drivers
if [ ! -d "${ANDROID_BUILD_TOP}/kernel_platform/vendor" ]; then
  ln -s "${ANDROID_BUILD_TOP}/vendor" "${ANDROID_BUILD_TOP}/kernel_platform/vendor"
fi

export EXT_MODULES="
  vendor/qcom/opensource/mmrm-driver
  vendor/qcom/opensource/audio-kernel
  vendor/qcom/opensource/camera-kernel
  vendor/qcom/opensource/dataipa/drivers/platform/msm
  vendor/qcom/opensource/datarmnet/core
  vendor/qcom/opensource/datarmnet-ext/aps
  vendor/qcom/opensource/datarmnet-ext/offload
  vendor/qcom/opensource/datarmnet-ext/shs
  vendor/qcom/opensource/datarmnet-ext/perf
  vendor/qcom/opensource/datarmnet-ext/perf_tether
  vendor/qcom/opensource/datarmnet-ext/sch
  vendor/qcom/opensource/datarmnet-ext/wlan
  vendor/qcom/opensource/display-drivers/msm
  vendor/qcom/opensource/eva-kernel
  vendor/qcom/opensource/video-driver
  vendor/oplus/kernel/wifi/oplus_wificapcenter
  vendor/qcom/opensource/wlan/qcacld-3.0/.qca6490
  vendor/oplus/kernel/explorer
"

export LTO=thin

RECOMPILE_KERNEL=1 KERNEL_TARGET=waipio ./kernel_platform/build/android/prepare_vendor.sh ${TARGET_BOARD_PLATFORM} gki