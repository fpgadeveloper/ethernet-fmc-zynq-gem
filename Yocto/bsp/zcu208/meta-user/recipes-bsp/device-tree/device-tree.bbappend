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
