# Copyright (C) 2017-2026 The Android Open Source Project
# SPDX-License-Identifier: Apache-2.0

PRODUCT_RELEASE_NAME := chiron

$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, vendor/twrp/config/common.mk)
$(call inherit-product, device/xiaomi/chiron/device.mk)

PRODUCT_DEVICE := chiron
PRODUCT_SHIPPING_API_LEVEL := 25
PRODUCT_NAME := twrp_chiron
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Mi MIX 2
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="chiron-user 8.0.0 OPR1.170623.027 V9.5.4.0.ODEMIFA release-keys"

BUILD_FINGERPRINT := Xiaomi/chiron/chiron:8.0.0/OPR1.170623.027/V9.5.4.0.ODEMIFA:user/release-keys
