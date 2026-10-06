#
# Copyright 2022 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

LOCAL_PATH := $(call my-dir)

ifneq ($(filter chiron,$(TARGET_DEVICE)),)
include $(call all-makefiles-under,$(LOCAL_PATH))

# The legacy bootloader cannot reliably unpack a recovery image containing
# both AERA's WLAN stack and the 4.8 MiB incompressible rclone executable.
# Keep WLAN itself and omit only the optional NAS transport on this target.
CHIRON_RCLONE_OUT := $(TARGET_RECOVERY_ROOT_OUT)/system/bin/rclone
CHIRON_RAMDISK_TRIM_STAMP := $(TARGET_RECOVERY_ROOT_OUT)/.chiron-ramdisk-trim

$(CHIRON_RAMDISK_TRIM_STAMP): $(CHIRON_RCLONE_OUT)
	@echo "Chiron: omitting rclone to stay within the legacy recovery boot limit"
	@rm -f $(CHIRON_RCLONE_OUT) && touch $@

$(PRODUCT_OUT)/obj/PACKAGING/recovery_intermediates/ramdisk_files-timestamp: \
    $(CHIRON_RAMDISK_TRIM_STAMP)
endif
