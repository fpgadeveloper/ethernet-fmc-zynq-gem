# Copyright (C) 2025-2026, Opsero Electronic Design Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT

# Board-level (SoC-side) device-tree fixups, layered on top of the
# gen-machineconf / lopper-generated CONFIG_DTFILE (...-cortexaN-linux.dts). The
# design-specific PL hardware already comes from the SDT's pl.dtsi; this file
# carries only the SoC-side board quirks the XSA / sdtgen output doesn't encode
# (see system-user.dtsi). PL/PHY wiring, when needed, is supplied separately by
# the bsp/port-configs/<ports-*> overlay layer.
#
# meta-xilinx's device-tree.bb consumes EXTRA_DT_INCLUDE_FILES by copying each
# file into the DT build dir and appending `#include "<file>"` to the base DTS.
# Scope it to the Linux (APU) domain ONLY: the FSBL/PLM/PSM domain DTS files
# don't define the SoC peripheral labels these overrides reference, so dtc would
# fail with "Label or path ... not found". Match on os.path.basename(CONFIG_DTFILE)
# containing "linux" -- NOT the full path, which can itself contain "linux".
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

EXTRA_DT_INCLUDE_FILES:append = "${@' system-user.dtsi' if 'linux' in os.path.basename(d.getVar('CONFIG_DTFILE') or '') else ''}"

# Board overrides that must win over the port-config overlay. The overlay
# layer's EXTRA_DT_INCLUDE_FILES entry lands AFTER system-user.dtsi, so
# system-user.dtsi cannot override what the overlay sets. Files listed here are
# #included after everything in EXTRA_DT_INCLUDE_FILES: this do_configure:append
# runs after device-tree.bb's own do_configure:append (recipe appends are
# applied before bbappend appends). Same Linux-domain scoping as above.
# zc706-gem0-phy.dtsi: board RJ45 PHY at MDIO address 7 (overlay says 0).
LATE_DT_INCLUDE_FILES = "zc706-gem0-phy.dtsi"
LATE_DT_INCLUDE_ACTIVE = "${@'1' if 'linux' in os.path.basename(d.getVar('CONFIG_DTFILE') or '') else ''}"

SRC_URI:append = "${@' ' + ' '.join('file://' + f for f in d.getVar('LATE_DT_INCLUDE_FILES').split()) if d.getVar('LATE_DT_INCLUDE_ACTIVE') else ''}"

do_configure:append () {
    if [ -n "${LATE_DT_INCLUDE_ACTIVE}" ]; then
        for f in ${LATE_DT_INCLUDE_FILES}; do
            if [ "$(realpath ${WORKDIR}/${f})" != "$(realpath ${DT_FILES_PATH}/${f})" ]; then
                cp ${WORKDIR}/${f} ${DT_FILES_PATH}/
            fi
            grep -qxF "#include \"$f\"" ${DT_FILES_PATH}/${BASE_DTS}.dts || \
                echo "#include \"$f\"" >> ${DT_FILES_PATH}/${BASE_DTS}.dts
        done
    fi
}
