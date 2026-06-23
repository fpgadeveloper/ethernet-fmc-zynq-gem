# Copyright (C) 2025-2026, Opsero Electronic Design Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT

# Per-target port-config overlay. Supplies the external-PHY / per-port wiring
# (MAC address, phy-handle, MDIO bus, phy-mode) that the XSA / SDT does not
# describe (the PHYs live off-chip on the FMC). configure-build.sh adds this
# layer per target, selected by the target's lane-derived port config
# (e.g. ports-0123 / ports-012-), so a board BSP can be shared across targets
# that differ only in active ports.
#
# Injected via EXTRA_DT_INCLUDE_FILES; scoped to the Linux (APU) domain DTS,
# same as the board system-user.dtsi.
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

EXTRA_DT_INCLUDE_FILES:append = "${@' port-config.dtsi' if 'linux' in os.path.basename(d.getVar('CONFIG_DTFILE') or '') else ''}"
