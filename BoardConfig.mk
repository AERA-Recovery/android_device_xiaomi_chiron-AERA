# Copyright (C) 2017-2026 The Android Open Source Project
# SPDX-License-Identifier: Apache-2.0

DEVICE_PATH := device/xiaomi/chiron

# Build compatibility
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_PLUGIN_VALIDATION := soong-libaosprecovery_defaults soong-libguitwrp_defaults soong-libminuitwrp_defaults soong-vold_defaults

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a73

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a73

# Bootloader and platform
TARGET_BOOTLOADER_BOARD_NAME := msm8998
TARGET_NO_BOOTLOADER := true
TARGET_BOARD_PLATFORM := msm8998
TARGET_BOARD_PLATFORM_GPU := qcom-adreno540
QCOM_BOARD_PLATFORMS += msm8998
BOARD_USES_QCOM_HARDWARE := true
TARGET_USES_ION := true

# Kernel. This prebuilt is extracted from the matching Android 16 crDroid
# boot image; the obsolete Android 11 tree kernel must not be used.
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
BOARD_BOOT_HEADER_VERSION := 0
BOARD_KERNEL_PAGESIZE := 4096
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.gz-dtb
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_KERNEL_CMDLINE := androidboot.console=ttyMSM0 androidboot.hardware=qcom
BOARD_KERNEL_CMDLINE += androidboot.boot_devices=soc/1da4000.ufshc
BOARD_KERNEL_CMDLINE += msm_rtb.filter=0x37 ehci-hcd.park=3
BOARD_KERNEL_CMDLINE += service_locator.enable=1
BOARD_KERNEL_CMDLINE += swiotlb=2048
BOARD_KERNEL_CMDLINE += loop.max_part=7

# Match the ramdisk format used by the known-working Android 16 recovery.
# Although the 4.4 kernel advertises LZMA initramfs support, the LZMA-packed
# bring-up image never reached userspace on this device.

# A-only physical partition layout
AB_OTA_UPDATER := false
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_CACHEIMAGE_PARTITION_SIZE := 402653184
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 5368709120
BOARD_USERDATAIMAGE_PARTITION_SIZE := 120426835968
BOARD_VENDORIMAGE_PARTITION_SIZE := 872415232
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 262144
TARGET_COPY_OUT_VENDOR := vendor

# Filesystems
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USES_MKE2FS := true

# Android 16 file-based encryption. There is no metadata-encrypted partition;
# the ROM fstab uses Qualcomm inline crypto via fileencryption=ice.
BOARD_USES_QCOM_FBE_DECRYPTION := true
AERA_INCLUDE_CRYPTO := true
AERA_INCLUDE_CRYPTO_FBE := true
AERA_USE_FSCRYPT_POLICY := 1

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
AERA_SKIP_ADDITIONAL_FSTAB := true

# AERA links boot-control helpers even on this A-only target. Keep their
# recovery variants in the ramdisk instead of relying on an A/B product list.
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hardware.keymaster@3.0-impl \
    libkeymaster3device \
    libpuresoftkeymasterdevice \
    android.hardware.boot-V1-ndk \
    libboot_control_client
AERA_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_VENDOR_SHARED_LIBRARIES)/hw/android.hardware.keymaster@3.0-impl.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster3device.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpuresoftkeymasterdevice.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.boot-V1-ndk.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libboot_control_client.so

# Recovery tools
AERA_INCLUDE_LIBRESETPROP := true
AERA_INCLUDE_REPACKTOOLS := true
AERA_INCLUDE_RESETPROP := true

# Logging for initial bring-up
TARGET_USES_LOGD := true
AERA_INCLUDE_LOGCAT := true

# Display
AERA_UI_ADAPTIVE_RESOLUTION := true
AERA_UI_LEGACY_KGSL_GPU := true
AERA_EXCLUDE_OFFLINE_ROOT_PROVIDERS := 1
AERA_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
AERA_DEFAULT_BRIGHTNESS := 2047
AERA_MAX_BRIGHTNESS := 4095
AERA_FRAMERATE := 60
AERA_NO_SCREEN_BLANK := true
AERA_SCREEN_BLANK_ON_BOOT := true
AERA_THEME := portrait_hdpi

# Storage
BOARD_HAS_NO_REAL_SDCARD := true
RECOVERY_SDCARD_ON_DATA := true
AERA_INCLUDE_FUSE_EXFAT := true
AERA_INCLUDE_FUSE_NTFS := true
AERA_INCLUDE_NTFS_3G := true
AERA_NO_EXFAT_FUSE := true

# Version metadata
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
AERA_DEVICE_VERSION := Xiaomi_Mi_MIX_2

# Device behavior
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_RECOVERY_QCOM_RTC_FIX := true
AERA_EXCLUDE_APEX := true
AERA_EXCLUDE_DEFAULT_USB_INIT := true
AERA_DEFAULT_LANGUAGE := en
AERA_INPUT_BLACKLIST := "hbtp_vm"
AERA_NO_TREBLE_COMPATIBILITY_CHECK := 1
AERA_USE_TOOLBOX := true
