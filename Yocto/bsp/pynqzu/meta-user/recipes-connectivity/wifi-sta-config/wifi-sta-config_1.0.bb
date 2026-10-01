# Copyright (C) 2025-2026, Opsero Electronic Design Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT

SUMMARY = "Wi-Fi station bring-up for wlan0 (wpa_supplicant + systemd-networkd DHCP)"
DESCRIPTION = "PYNQ-ZU has no Ethernet port; its only network is the on-board \
WILC3000 Wi-Fi. This ships the plumbing so wlan0 associates and gets a DHCP \
lease as soon as credentials exist on the board. NO credentials are shipped: \
the operator writes /etc/wpa_supplicant/wpa_supplicant-wlan0.conf at runtime \
(wifi-sta-setup helper, or by hand from the .example template)."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
    file://25-wlan0.network \
    file://10-wifi-sta.conf \
    file://wpa_supplicant-wlan0.conf.example \
    file://wifi-sta-setup \
"

S = "${WORKDIR}"

inherit allarch features_check
REQUIRED_DISTRO_FEATURES = "systemd"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install() {
    # DHCP on wlan0 (systemd-networkd)
    install -d ${D}${systemd_unitdir}/network
    install -m 0644 ${S}/25-wlan0.network ${D}${systemd_unitdir}/network/

    # Drop-in for the stock wpa_supplicant@.service template (wlan0 instance):
    # skip cleanly while no credentials file exists, restart on failure,
    # disable Wi-Fi power save once the supplicant is up.
    install -d ${D}${systemd_system_unitdir}/wpa_supplicant@wlan0.service.d
    install -m 0644 ${S}/10-wifi-sta.conf ${D}${systemd_system_unitdir}/wpa_supplicant@wlan0.service.d/

    # Start wpa_supplicant@wlan0 when the wlan0 netdev appears (device-bound
    # enable: no boot delay if the driver/firmware fails to bring wlan0 up).
    install -d ${D}${sysconfdir}/systemd/system/sys-subsystem-net-devices-wlan0.device.wants
    ln -sf ${systemd_system_unitdir}/wpa_supplicant@.service \
        ${D}${sysconfdir}/systemd/system/sys-subsystem-net-devices-wlan0.device.wants/wpa_supplicant@wlan0.service

    # Template only - no SSID/passphrase in the image.
    install -d -m 0755 ${D}${sysconfdir}/wpa_supplicant
    install -m 0644 ${S}/wpa_supplicant-wlan0.conf.example ${D}${sysconfdir}/wpa_supplicant/

    install -d ${D}${sbindir}
    install -m 0755 ${S}/wifi-sta-setup ${D}${sbindir}/
}

FILES:${PN} = " \
    ${systemd_unitdir}/network/25-wlan0.network \
    ${systemd_system_unitdir}/wpa_supplicant@wlan0.service.d \
    ${sysconfdir}/systemd/system/sys-subsystem-net-devices-wlan0.device.wants \
    ${sysconfdir}/wpa_supplicant \
    ${sbindir}/wifi-sta-setup \
"

RDEPENDS:${PN} = " \
    wpa-supplicant \
    wpa-supplicant-cli \
    wpa-supplicant-passphrase \
    iw \
"
