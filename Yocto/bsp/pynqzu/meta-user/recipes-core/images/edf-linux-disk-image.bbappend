# Copyright (C) 2025-2026, Opsero Electronic Design Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT

# Ethernet FMC Zynq GEM reference-design rootfs packages (ported from the PetaLinux
# bsp rootfs_config: design test/utility tools layered on the amd-edf base).
IMAGE_INSTALL:append = " \
    ethtool \
    phytool \
    iperf3 \
    mtd-utils \
    can-utils \
    nfs-utils \
    pciutils \
"

# PYNQ-ZU has no Ethernet: on-board WILC3000 Wi-Fi (firmware, supplicant, iw, regdb, wlan0 DHCP; credentials written on the board at runtime).
IMAGE_INSTALL:append = " \
    wilc3000-firmware \
    wifi-sta-config \
    wpa-supplicant \
    wpa-supplicant-cli \
    wpa-supplicant-passphrase \
    iw \
    wireless-regdb-static \
"
