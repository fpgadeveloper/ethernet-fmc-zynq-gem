"""Pre-build fixup required for lwip_echo_server template apps.

Fix: override PLATFORM_EMAC_BASEADDR with user-configurable port selection
  The template's lwip_echo_server.cmake auto-selects a MAC instance for
  PLATFORM_EMAC_BASEADDR, but the user has no control over which port is
  used. This script patches platform_config.h.in to replace the cmake-
  generated PLATFORM_EMAC_BASEADDR with a port selection block that lets
  the user choose the desired Ethernet port.
  To retarget the echo server to a different port, edit ETHERNET_PORT in
  platform_config.h.in (in the workspace echo_server/src directory).

Usage: called by build-vitis.py with app_src as the first argument.
"""

import os, sys

PORT_CONFIG = """\
/*
 * Ethernet FMC port selection (GEM)
 *
 * Change ETHERNET_PORT to select which Ethernet FMC port to use.
 * Valid values: 0, 1, 2, 3
 *
 * Zynq-7000 designs (zedboard, picozed) only have 2 PS GEMs, so ports 0-2
 * are routed through AXI Ethernet and only port 3 uses a GEM. Zynq
 * UltraScale+ and Versal designs have enough GEMs for all four ports.
 */

#ifndef PORT_CONFIG_H
#define PORT_CONFIG_H

#define ETHERNET_PORT 0

#include "xparameters.h"

#ifdef XPAR_AXI_ETHERNET_0_BASEADDR
/* Zynq-7000: ports 0-2 via AXI Ethernet, port 3 via GEM */
#if ETHERNET_PORT == 0
#define PLATFORM_EMAC_BASEADDR XPAR_AXI_ETHERNET_0_BASEADDR
#elif ETHERNET_PORT == 1
#define PLATFORM_EMAC_BASEADDR XPAR_AXI_ETHERNET_1_BASEADDR
#elif ETHERNET_PORT == 2
#define PLATFORM_EMAC_BASEADDR XPAR_AXI_ETHERNET_2_BASEADDR
#elif ETHERNET_PORT == 3
#define PLATFORM_EMAC_BASEADDR XPAR_XEMACPS_1_BASEADDR
#else
#error "Invalid ETHERNET_PORT value. Must be 0, 1, 2, or 3."
#endif
#else
/* Zynq UltraScale+ / Versal: all ports via GEM */
#if ETHERNET_PORT == 0
#define PLATFORM_EMAC_BASEADDR XPAR_XEMACPS_0_BASEADDR
#elif ETHERNET_PORT == 1
#define PLATFORM_EMAC_BASEADDR XPAR_XEMACPS_1_BASEADDR
#elif ETHERNET_PORT == 2
#define PLATFORM_EMAC_BASEADDR XPAR_XEMACPS_2_BASEADDR
#elif ETHERNET_PORT == 3
#define PLATFORM_EMAC_BASEADDR XPAR_XEMACPS_3_BASEADDR
#else
#error "Invalid ETHERNET_PORT value. Must be 0, 1, 2, or 3."
#endif
#endif

#endif"""

def main():
    if len(sys.argv) < 2:
        print("Usage: pre_build.py <app_src_dir>")
        sys.exit(1)

    app_src = sys.argv[1]
    config_in = os.path.join(app_src, "platform_config.h.in")

    if not os.path.isfile(config_in):
        print(f"WARNING: {config_in} not found; skipping patch")
        return

    with open(config_in, "r") as f:
        content = f.read()

    old = "#cmakedefine PLATFORM_EMAC_BASEADDR @PLATFORM_EMAC_BASEADDR@"

    if old not in content:
        print(f"NOTE: cmake PLATFORM_EMAC_BASEADDR line not found in {config_in}; skipping")
        return

    content = content.replace(old, PORT_CONFIG)
    with open(config_in, "w") as f:
        f.write(content)
    print(f"Patched {config_in}: replaced cmake PLATFORM_EMAC_BASEADDR with port selection")

if __name__ == "__main__":
    main()
