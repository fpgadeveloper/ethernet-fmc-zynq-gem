# Copyright (C) 2025-2026, Opsero Electronic Design Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT

SUMMARY = "Microchip WILC3000 Wi-Fi firmware (PYNQ-ZU on-board Wi-Fi)"
DESCRIPTION = "atmel/wilc3000_wifi_firmware-1.bin (v16.1.2) for the in-tree \
wilc1000-sdio driver with the WILC3000 backport. The file only entered \
linux-firmware in release 20250211; scarthgap ships linux-firmware 20240909, \
which has the WILC1000 firmware only, so fetch the single file (and its \
license) from linux-firmware tag 20250211 instead of upgrading linux-firmware."
HOMEPAGE = "https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git"

LICENSE = "Firmware-atmel"
NO_GENERIC_LICENSE[Firmware-atmel] = "LICENSE.atmel-${LFW_COMMIT}"
LIC_FILES_CHKSUM = "file://LICENSE.atmel-${LFW_COMMIT};md5=aa74ac0c60595dee4d4e239107ea77a3"

# linux-firmware tag 20250211. Official GitLab mirror of the kernel.org tree;
# raw URLs by commit hash, so the content is immutable (sha256 pinned below).
LFW_COMMIT = "5bc5868b7ee5a243abdd73cfcd3bbf7166f4f42f"
LFW_RAW = "https://gitlab.com/kernel-firmware/linux-firmware/-/raw/${LFW_COMMIT}"

SRC_URI = " \
    ${LFW_RAW}/atmel/wilc3000_wifi_firmware-1.bin;name=fw;downloadfilename=wilc3000_wifi_firmware-1-${LFW_COMMIT}.bin \
    ${LFW_RAW}/LICENSE.atmel;name=license;downloadfilename=LICENSE.atmel-${LFW_COMMIT} \
"
SRC_URI[fw.sha256sum] = "43acf3f949d2cbe23e7bf1184b68359fa94232fb71533994c0ceb34347bdd681"
SRC_URI[license.sha256sum] = "45f210a21086288d93b374c5b679518506db3d68b93c60bdc6dea3715b37c713"

# Plain (non-archive) files unpack into ${WORKDIR} under their downloadfilename.
S = "${WORKDIR}"

inherit allarch

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install() {
    install -d ${D}${nonarch_base_libdir}/firmware/atmel
    install -m 0644 ${S}/wilc3000_wifi_firmware-1-${LFW_COMMIT}.bin \
        ${D}${nonarch_base_libdir}/firmware/atmel/wilc3000_wifi_firmware-1.bin
    install -m 0644 ${S}/LICENSE.atmel-${LFW_COMMIT} \
        ${D}${nonarch_base_libdir}/firmware/LICENSE.atmel-wilc3000
}

FILES:${PN} = "${nonarch_base_libdir}/firmware/atmel/wilc3000_wifi_firmware-1.bin \
               ${nonarch_base_libdir}/firmware/LICENSE.atmel-wilc3000"
