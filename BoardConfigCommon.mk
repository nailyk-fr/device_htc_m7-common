# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2013 The Android Open Source Project
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
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

# WARNING: This line must come *before* including the proprietary
# variant, so that it gets overwritten by the parent (which goes
# against the traditional rules of inheritance).

PLATFORM_PATH := device/htc/m7-common

BOARD_VENDOR := htc

ALLOW_MISSING_DEPENDENCIES=true

# General compilation flags
TARGET_SPECIFIC_HEADER_PATH += $(PLATFORM_PATH)/include

# QCOM hardware
BOARD_USES_QCOM_HARDWARE := true

# Audio
BOARD_USES_ALSA_AUDIO := true
BOARD_HAVE_HTC_CSDCLIENT := true
USE_CUSTOM_AUDIO_POLICY := 1
USE_XML_AUDIO_POLICY_CONF := 1
TARGET_QCOM_AUDIO_VARIANT := caf-msm8960

# Bionic
#Target_LD_SHIM_LIBS := \
#        /system/vendor/lib/hw/camera.vendor.msm8960.so|libcamera_shim.so \
#        /system/vendor/lib/libqc-opt.so|libqc-opt_shim.so \
#        /system/lib/liblog.so|liblog_shim.so \
#        /system/vendor/lib/libwvm.so|libshim_wvm.so \
#        /system/vendor/lib/libril.so|libshim_ril.so \
#        /system/vendor/lib/libril-qc-qmi-1.so|libshim_ril.so

# USB
TARGET_USES_LEGACY_ADB_INTERFACE := true

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# Power
TARGET_POWERHAL_VARIANT := qcom

# NFC
BOARD_NFC_HAL_SUFFIX := msm8960

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_CUSTOM_BT_CONFIG := $(PLATFORM_PATH)/bluetooth/libbt_vndcfg.txt
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(PLATFORM_PATH)/bluetooth
BOARD_BLUETOOTH_USES_HCIATTACH_PROPERTY := false
BOARD_HAVE_BLUETOOTH_BCM := true

# Boot animation
TARGET_BOOTANIMATION_HALF_RES := true

# Gps
USE_DEVICE_SPECIFIC_GPS := true

# Camera
TARGET_HAS_LEGACY_CAMERA_HAL1 := true
TARGET_NEEDS_PLATFORM_TEXT_RELOCATIONS := true
TARGET_DISPLAY_INSECURE_MM_HEAP := true
USE_DEVICE_SPECIFIC_CAMERA := true
TARGET_USES_MEDIA_EXTENSIONS := true
TARGET_USES_NON_TREBLE_CAMERA := true
TARGET_QCOM_MEDIA_VARIANT := caf-msm8960

# Charger
BOARD_CHARGING_MODE_BOOTING_LPM := /sys/htc_lpm/lpm_mode

# Dexpreopt
ifeq ($(HOST_OS),linux)
  ifneq ($(TARGET_BUILD_VARIANT),eng)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
      WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY := true
    endif
  endif
endif

# Filesystem
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16776704

# Graphics
HAVE_ADRENO_SOURCE := false
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
TARGET_DISPLAY_USE_RETIRE_FENCE := true
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_ION := true
USE_OPENGL_RENDERER := true
TARGET_QCOM_DISPLAY_VARIANT := caf-msm8960

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8960
TARGET_NO_BOOTLOADER := true

# Platform
TARGET_BOARD_PLATFORM := msm8960
TARGET_BOARD_PLATFORM_GPU := qcom-adreno200

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := krait

# Kernel
BOARD_KERNEL_BASE := 0x80600000
BOARD_KERNEL_CMDLINE := console=none androidboot.hardware=qcom user_debug=31 androidboot.selinux=permissive
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_IMAGE_NAME := zImage
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x01800000
TARGET_KERNEL_CONFIG := m7_defconfig
TARGET_KERNEL_SOURCE := kernel/htc/msm8960
TARGET_COMPILE_WITH_MSM_KERNEL := true
KERNEL_TOOLCHAIN        := $(ANDROID_BUILD_TOP)/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8/bin
KERNEL_TOOLCHAIN_PREFIX := arm-eabi-

# Recovery
BOARD_GLOBAL_CFLAGS := -DBOARD_RECOVERY_BLDRMSG_OFFSET=2048
BOARD_NO_SECURE_DISCARD := true
TARGET_RECOVERY_DEVICE_DIRS += device/htc/m7-common
TARGET_RECOVERY_FSTAB := $(PLATFORM_PATH)/rootdir/etc/fstab.qcom
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_RECOVERY_DEVICE_MODULES += chargeled
TARGET_USERIMAGES_USE_EXT4 := true
#TARGET_USERIMAGES_USE_F2FS := true
LZMA_RAMDISK_TARGETS := recovery

# Los Hardware
BOARD_HARDWARE_CLASS := $(PLATFORM_PATH)/lineagehw

# RIL
BOARD_PROVIDES_LIBRIL := true
TARGET_RIL_VARIANT := caf
BOARD_RIL_CLASS := ../../../$(PLATFORM_PATH)/ril/

# SELinux
-include device/qcom/sepolicy/sepolicy.mk
-include device/qcom/sepolicy/legacy-sepolicy.mk
BOARD_SEPOLICY_DIRS += $(PLATFORM_PATH)/sepolicy

# Wifi
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE                := bcmdhd
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
WIFI_DRIVER_FW_PATH_AP           := "/system/etc/firmware/fw_bcmdhd_apsta_b0.bin"
WIFI_DRIVER_FW_PATH_P2P          := "/system/etc/firmware/fw_bcmdhd_p2p_b0.bin"
WIFI_DRIVER_FW_PATH_PARAM        := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA          := "/system/etc/firmware/fw_bcmdhd_b0.bin"
WPA_SUPPLICANT_VERSION           := VER_0_8_X

# inherit proprietary vendor
-include vendor/htc/m7-common/BoardConfigVendor.mk
