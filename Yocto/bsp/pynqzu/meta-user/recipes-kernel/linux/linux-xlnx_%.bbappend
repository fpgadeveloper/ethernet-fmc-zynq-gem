# Copyright (C) 2025-2026, Opsero Electronic Design Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://bsp.cfg"
KERNEL_FEATURES:append = " bsp.cfg"

# PYNQ-ZU on-board Wi-Fi (Microchip WILC3000 on PS SD1). linux-xlnx 6.12 has
# the in-tree wilc1000 driver but it only recognises the WILC1000 chip ID;
# this backports mainline WILC3000 support (v6.13..v6.18, adapted to the 6.12
# cfg80211 API). Enabled by CONFIG_WILC1000_SDIO=m in bsp.cfg; firmware comes
# from the wilc3000-firmware recipe.
SRC_URI:append = " file://0010-wifi-wilc1000-backport-WILC3000-support.patch"
# A station dump on wlan0 before its first open (no firmware running yet)
# left a config query queued that broke the next firmware start.
SRC_URI:append = " file://0011-wifi-wilc1000-refuse-config-requests-before-the-first-open.patch"
