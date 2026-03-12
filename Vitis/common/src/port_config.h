/*
 * port_config.h — Ethernet FMC port selection (GEM)
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

#endif
