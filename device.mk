# Copyright (C) 2017-2026 The Android Open Source Project
# SPDX-License-Identifier: Apache-2.0

DEVICE_PATH := device/xiaomi/chiron

# MSM8998 is a native 4 KiB-page platform. Allow the matching 4 KiB MagiskBoot
# prebuilt instead of applying Android 16's generic 16 KiB ELF validation.
PRODUCT_CHECK_PREBUILT_MAX_PAGE_SIZE := false

# logd and keystore2 require the matching process scheduling profiles.
PRODUCT_COPY_FILES += \
    system/core/libprocessgroup/profiles/task_profiles.json:recovery/root/system/etc/task_profiles.json

# Qualcomm legacy decryption helpers used by MSM8998 Keymaster 3.0 and
# Gatekeeper 1.0.
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Shared sandbox launcher required by AERA's bundled plugin runtimes.
PRODUCT_PACKAGES += aera-browser-jail

PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# Snapdragon 835 exposes Adreno 540 through legacy KGSL/fbdev rather than
# DRM/KMS. The device init script exposes the installed vendor EGL/GLES stack
# through a private read-only mount for AERA's legacy GPU backend.
PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.egl=adreno

$(call inherit-product, $(DEVICE_PATH)/aera_chiron.mk)
