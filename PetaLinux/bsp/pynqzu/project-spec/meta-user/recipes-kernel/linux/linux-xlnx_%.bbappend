# Copyright (C) 2021 Xilinx, Inc
# SPDX-License-Identifier: BSD-3-Clause

SRC_URI:append = " file://bsp.cfg"
SRC_URI += "file://fix_pwrseq_simple.patch"
SRC_URI += "file://0001-usb-dwc3-xilinx-fix-usb3-non-wakeup-source-resume-fa.patch"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
