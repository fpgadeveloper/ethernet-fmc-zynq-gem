#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Opsero Electronic Design Inc.
"""
Generate the block diagrams for the Opsero Zynq GEM (Ethernet FMC) reference design docs.

Two diagrams, one per device family, drawn from the block-design scripts
Vivado/src/bd/bd_zynq.tcl and Vivado/src/bd/bd_zynqmp.tcl:

  zynq-gem-design-block-diagram.png    Zynq-7000 (ZedBoard, PicoZed 7030, ZC706)
      FMC ports 0-2: AXI Ethernet Subsystem (RGMII) + AXI DMA, DMA memory traffic to
      DDR through axi_mem_intercon and S_AXI_HP0, registers on M_AXI_GP0.
      FMC port 3: PS GEM1 over EMIO -> GMII-to-RGMII.
      Board Ethernet port: PS GEM0 over MIO (not through the PL).
      clk_wiz_0 makes 125 MHz and 200 MHz from the FMC's 125 MHz reference clock.

  zynqmp-gem-design-block-diagram.png  Zynq UltraScale+ (all ZynqMP / RFSoC targets)
      FMC ports 0-3: PS GEM0-3 over EMIO -> one GMII-to-RGMII each; the third
      GMII-to-RGMII carries the shared logic (clocks + IDELAYCTRL); clk_wiz_0 makes
      375 MHz from the FMC's 125 MHz reference clock. zcu102_hpc1 variant: GEM0-2
      only, GEM3 stays on MIO for the ZCU102's own Ethernet port.

The output PNGs are written next to this script (i.e. into docs/source/images/).

Usage (from anywhere):
    python3 docs/source/images/gen_block_diagram.py
"""

import os
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import Polygon, FancyBboxPatch, FancyArrowPatch
from matplotlib.lines import Line2D

# ---- palette (shared with the other Opsero reference-design block diagrams) --
C_PS_FILL      = "#D9D9D9"; C_PS_EDGE      = "#7F7F7F"   # processor / DDR column
C_FAB_FILL     = "#F2F2F2"; C_FAB_EDGE     = "#BFBFBF"   # FPGA fabric container
C_DMA_FILL     = "#808080"; C_DMA_EDGE     = "#404040"   # AXI DMA (dark grey)
C_MAC_FILL     = "#E8E8F2"; C_MAC_EDGE     = "#8C8CC0"   # MAC / PL Ethernet logic (lavender)
C_GT_FILL      = "#F3EFE2"; C_GT_EDGE      = "#BFB585"   # hard blocks: PS GEMs (cream)
C_FMC_FILL     = "#DCE6F2"; C_FMC_EDGE     = "#9DB7D4"   # external FMC (blue-grey)
C_CAGE_FILL    = "#FFFFFF"                                # PHYs / connectors (white)
C_CLK_FILL     = "#FDE9D9"; C_CLK_EDGE     = "#E0B090"   # clocking (peach)
C_CTRL_FILL    = "#ECECEC"; C_CTRL_EDGE    = "#BFBFBF"   # control plane
C_AXARR_FILL   = "#EDF3D4"; C_AXARR_EDGE   = "#A6B85A"   # data arrows (pale green)
C_LINKARR_FILL = "#DAE8F5"; C_LINKARR_EDGE = "#6F9FCF"   # link arrows (pale blue)
C_REFCLK_LINE  = "#C8823C"                                # refclk arrows (orange)
C_MUTED        = "#8C8C8C"                                # notes / variants
TXT = "#1A1A1A"


def box(ax, x, y, w, h, fc, ec, label, fs=10, rot=0, lw=1.2, weight="normal",
        txtcolor=None, ls="-", z=2):
    ax.add_patch(plt.Rectangle((x, y), w, h, fc=fc, ec=ec, lw=lw, ls=ls, zorder=z))
    if label:
        ax.text(x + w / 2, y + h / 2, label, ha="center", va="center",
                fontsize=fs, rotation=rot, color=txtcolor or TXT, weight=weight,
                zorder=z + 1, linespacing=1.25)


def titled_box(ax, x, y, w, h, fc, ec, title, body, title_fs=9.5, body_fs=7.6,
               lw=1.2, txtcolor=None, title_dy=2.6, ls="-"):
    """A box() with a bold title line at the top and a smaller body below it."""
    box(ax, x, y, w, h, fc, ec, "", lw=lw, ls=ls)
    cx = x + w / 2
    ax.text(cx, y + h - title_dy, title, ha="center", va="center",
            fontsize=title_fs, weight="bold", color=txtcolor or TXT, zorder=3)
    if body:
        ax.text(cx, y + (h - title_dy * 1.9) / 2, body, ha="center", va="center",
                fontsize=body_fs, color=txtcolor or TXT, zorder=3, linespacing=1.3)


def harrow(ax, x0, x1, yc, label, fc, ec, double=True, bh=2.0, hh=3.4, hl=3.2,
           fs=8.5, lw=1.1, lab_dy=0.0, lab_color=None, weight="normal", ls="-"):
    """Horizontal block arrow from x0 to x1 (double-headed, or head at x1)."""
    if double:
        pts = [(x0, yc), (x0 + hl, yc + hh), (x0 + hl, yc + bh),
               (x1 - hl, yc + bh), (x1 - hl, yc + hh), (x1, yc),
               (x1 - hl, yc - hh), (x1 - hl, yc - bh),
               (x0 + hl, yc - bh), (x0 + hl, yc - hh)]
    else:
        s = 1.0 if x1 >= x0 else -1.0
        neck = x1 - s * hl
        pts = [(x0, yc + bh), (neck, yc + bh), (neck, yc + hh),
               (x1, yc), (neck, yc - hh), (neck, yc - bh), (x0, yc - bh)]
    ax.add_patch(Polygon(pts, closed=True, fc=fc, ec=ec, lw=lw, ls=ls, zorder=2))
    if label:
        ax.text((x0 + x1) / 2, yc + lab_dy, label, ha="center", va="center",
                fontsize=fs, color=lab_color or TXT, zorder=3, linespacing=1.15,
                weight=weight)


def varrow(ax, xc, y0, y1, fc, ec, double=True, bw=1.4, hw=2.6, hl=2.4, lw=1.1):
    """Vertical block arrow from y0 to y1 (head at y1; both ends if double)."""
    if double:
        lo, hi = min(y0, y1), max(y0, y1)
        pts = [(xc, lo), (xc + hw, lo + hl), (xc + bw, lo + hl),
               (xc + bw, hi - hl), (xc + hw, hi - hl), (xc, hi),
               (xc - hw, hi - hl), (xc - bw, hi - hl),
               (xc - bw, lo + hl), (xc - hw, lo + hl)]
    else:
        s = 1.0 if y1 >= y0 else -1.0
        neck = y1 - s * hl
        pts = [(xc - bw, y0), (xc - bw, neck), (xc - hw, neck), (xc, y1),
               (xc + hw, neck), (xc + bw, neck), (xc + bw, y0)]
    ax.add_patch(Polygon(pts, closed=True, fc=fc, ec=ec, lw=lw, zorder=2))


def route(ax, pts, color, lw=1.6, ls="-"):
    """Thin elbow arrow through the points in pts (head at the last point)."""
    xs, ys = zip(*pts[:-1])
    ax.add_line(Line2D(xs, ys, color=color, lw=lw, ls=ls, zorder=3,
                       solid_capstyle="butt", solid_joinstyle="miter"))
    ax.add_patch(FancyArrowPatch(pts[-2], pts[-1], arrowstyle="-|>",
                                 mutation_scale=11, lw=lw, color=color,
                                 zorder=3, shrinkA=0, shrinkB=0))


def refclk_arrow(ax, p0, p1, label, lab_xy, fs=7.8, lw=1.9):
    """Thin single-line arrow (head at p1) for a single clock net."""
    ax.add_patch(FancyArrowPatch(p0, p1, arrowstyle="-|>", mutation_scale=13,
                                 lw=lw, color=C_REFCLK_LINE, zorder=3,
                                 shrinkA=0, shrinkB=0))
    ax.text(lab_xy[0], lab_xy[1], label, ha="center", va="center",
            fontsize=fs, color=C_REFCLK_LINE, zorder=4, weight="bold",
            linespacing=1.2)


def ps_port(ax, x, yc, label, w=7.0, h=7.0, fs=7.6):
    """A PS interface (GEM, AXI port) drawn on the right edge of the PS column."""
    titled_box(ax, x, yc - h / 2, w, h, C_GT_FILL, C_GT_EDGE, label, "",
               title_fs=fs, title_dy=h / 2)


def save(fig, name):
    out = os.path.join(os.path.dirname(os.path.abspath(__file__)), name)
    fig.savefig(out, bbox_inches="tight", pad_inches=0.15, facecolor="white")
    plt.close(fig)
    print("wrote", out)


# ============================================================================
# Zynq-7000
# ============================================================================
def zynq7000():
    fig, ax = plt.subplots(figsize=(17.0, 11.0), dpi=120)
    ax.set_xlim(0, 170)
    ax.set_ylim(0, 110)
    ax.axis("off")

    rows = {0: 85.0, 1: 70.0, 2: 55.0}      # FMC ports 0-2 (AXI Ethernet)
    gem_y = 35.0                            # FMC port 3 (GEM1 over EMIO)
    mio_y = 7.0                             # board Ethernet port (GEM0 over MIO)

    # ---- PS column ----------------------------------------------------------
    ps_x0, ps_w = 2, 22
    ps_r = ps_x0 + ps_w
    titled_box(ax, ps_x0, 98, ps_w, 10, C_PS_FILL, C_PS_EDGE, "DDR",
               "board memory", title_fs=10.5, body_fs=7.6, title_dy=3.0, lw=1.3)
    varrow(ax, ps_x0 + 8, 95.5, 98, C_AXARR_FILL, C_AXARR_EDGE, double=True,
           bw=1.0, hw=2.0, hl=1.2)
    box(ax, ps_x0, 2, ps_w, 93.5, C_PS_FILL, C_PS_EDGE, "", lw=1.3)
    ax.text(ps_x0 + 8, 89.0, "Zynq-7000\nPS", ha="center", va="center",
            fontsize=11.5, weight="bold", color=TXT, linespacing=1.25)
    ax.text(ps_x0 + 8, 80.5, "dual Arm\nCortex-A9", ha="center", va="center",
            fontsize=7.8, color=TXT, linespacing=1.3)
    ax.text(ps_x0 + 8, 62.0,
            "Linux (PetaLinux\nor Yocto) or the\nbare-metal lwIP\necho server",
            ha="center", va="center", fontsize=7.2, color=TXT, linespacing=1.4)
    px = ps_r - 7.5
    ps_port(ax, px, 92.0, "M_AXI\nGP0")
    ps_port(ax, px, 74.0, "S_AXI\nHP0")
    ps_port(ax, px, 46.0, "IRQ\nF2P")
    ps_port(ax, px, gem_y, "GEM1\n(EMIO)")
    ps_port(ax, px, mio_y + 3.5, "GEM0\n(MIO)")

    # ---- FPGA fabric ---------------------------------------------------------
    fab_x0, fab_x1, fab_y0, fab_y1 = 27.5, 121.0, 17.0, 104.0
    ax.add_patch(plt.Rectangle((fab_x0, fab_y0), fab_x1 - fab_x0, fab_y1 - fab_y0,
                               fc=C_FAB_FILL, ec=C_FAB_EDGE, lw=1.3, zorder=1))
    ax.text((fab_x0 + fab_x1) / 2, fab_y1 + 1.2, "FPGA fabric (PL)", ha="center",
            va="bottom", fontsize=13, weight="bold", color=TXT)

    # control plane: AXI interconnect on M_AXI_GP0
    ctrl_y0, ctrl_h = 92.0, 7.0
    titled_box(ax, 44.0, ctrl_y0, 50.0, ctrl_h, C_CTRL_FILL, C_CTRL_EDGE,
               "AXI Interconnect (M_AXI_GP0, 100 MHz)",
               "AXI-Lite registers of the AXI DMAs and AXI Ethernet cores",
               title_fs=8.4, body_fs=7.0, title_dy=2.0)
    harrow(ax, ps_r, 44.0, 93.6, "", C_CTRL_FILL, C_PS_EDGE,
           double=False, bh=1.3, hh=2.4, hl=1.8)

    # DMA memory path: axi_mem_intercon -> S_AXI_HP0
    mi_x, mi_w = 30.5, 8.0
    box(ax, mi_x, 49.0, mi_w, 42.0, C_PS_FILL, C_PS_EDGE,
        "axi_mem_intercon (9 → 1): DMA SG / MM2S / S2MM", fs=7.6, rot=90, weight="bold", lw=1.3)
    harrow(ax, mi_x, ps_r, 74.0, "", C_AXARR_FILL, C_AXARR_EDGE, double=True,
           bh=1.3, hh=2.4, hl=1.4)

    dma_x, dma_w = 44.0, 15.0
    eth_x, eth_w = 70.0, 20.0
    for p, yc in rows.items():
        titled_box(ax, dma_x, yc - 5.5, dma_w, 11.0, C_DMA_FILL, C_DMA_EDGE,
                   f"AXI DMA {p}", "scatter-gather\nMM2S + S2MM",
                   title_fs=8.6, body_fs=7.0, txtcolor="#FFFFFF", title_dy=2.4)
        titled_box(ax, eth_x, yc - 5.5, eth_w, 11.0, C_MAC_FILL, C_MAC_EDGE,
                   f"AXI Ethernet {p}", "Tri-Mode Ethernet MAC\nRGMII, full checksum\noffload",
                   title_fs=8.6, body_fs=7.0, title_dy=2.4)
        harrow(ax, mi_x + mi_w, dma_x, yc, "", C_AXARR_FILL, C_AXARR_EDGE,
               double=True, bh=1.2, hh=2.2, hl=1.3)
        harrow(ax, dma_x + dma_w, eth_x, yc + 2.2, "", C_AXARR_FILL, C_AXARR_EDGE,
               double=False, bh=0.9, hh=1.8, hl=1.4)
        harrow(ax, eth_x, dma_x + dma_w, yc - 2.2, "", C_AXARR_FILL, C_AXARR_EDGE,
               double=False, bh=0.9, hh=1.8, hl=1.4)
        ax.text((dma_x + dma_w + eth_x) / 2, yc + 5.0, "AXIS", ha="center",
                va="center", fontsize=7.0, color="#404040", zorder=3)

    # interrupts
    route(ax, [(eth_x + 4.0, rows[2] - 5.5), (eth_x + 4.0, 46.0), (ps_r, 46.0)],
          C_MUTED, lw=1.4)
    ax.text(52.0, 47.8, "12 interrupts: DMA MM2S / S2MM, MAC + core IRQs",
            ha="center", va="center", fontsize=6.9, color="#404040", zorder=3)

    # FMC port 3: GEM1 over EMIO -> GMII-to-RGMII
    titled_box(ax, eth_x, gem_y - 6.0, eth_w, 12.0, C_MAC_FILL, C_MAC_EDGE,
               "GMII-to-RGMII", "shared logic in core\nMDIO address 8\n(PHY at 0)",
               title_fs=8.6, body_fs=7.0, title_dy=2.4)
    harrow(ax, ps_r, eth_x, gem_y, "GMII + MDIO  (EMIO)", C_AXARR_FILL,
           C_AXARR_EDGE, double=True, bh=1.6, hh=3.0, hl=2.0, fs=8.0)

    # clocking
    clk_y0, clk_h = 19.0, 9.5
    titled_box(ax, 44.0, clk_y0, 75.0, clk_h, C_CLK_FILL, C_CLK_EDGE,
               "Clocking: clk_wiz_0 (input: Ethernet FMC 125 MHz reference)",
               "125 MHz: AXI Ethernet gtx_clk, AXI-Stream, DMA memory side    "
               "200 MHz: IDELAY reference, GMII-to-RGMII clkin\n"
               "FCLK_CLK0 (PS, 100 MHz): AXI-Lite control and the HP0 port",
               title_fs=8.4, body_fs=7.0, title_dy=2.4)

    # ---- Ethernet FMC ----------------------------------------------------------
    fmc_x0, fmc_x1 = 128.0, 160.0
    fcx = (fmc_x0 + fmc_x1) / 2
    ax.add_patch(plt.Rectangle((fmc_x0, fab_y0), fmc_x1 - fmc_x0, fab_y1 - fab_y0,
                               fc=C_FMC_FILL, ec=C_FMC_EDGE, lw=1.3, zorder=1))
    ax.text(fcx, fab_y1 + 1.2, "External to the Zynq", ha="center", va="bottom",
            fontsize=12, weight="bold", color=TXT)
    ax.text(fcx, 99.5, "Ethernet FMC\n(OP031 / OP041)", ha="center", va="center",
            fontsize=9.6, weight="bold", color=TXT, linespacing=1.25)
    phy_x, phy_w = 131.0, 26.0
    for p, yc in list(rows.items()) + [(3, gem_y)]:
        titled_box(ax, phy_x, yc - 5.0, phy_w, 10.0, C_CAGE_FILL, C_FMC_EDGE,
                   f"Port {p}", "Marvell 88E1510 PHY\nown MDIO bus, address 0",
                   title_fs=8.8, body_fs=7.0, title_dy=2.3)
        harrow(ax, eth_x + eth_w, phy_x, yc, "RGMII + MDIO", C_LINKARR_FILL,
               C_LINKARR_EDGE, double=True, bh=1.7, hh=3.0, hl=2.0, fs=7.6)
    titled_box(ax, phy_x, clk_y0, phy_w, clk_h, C_CLK_FILL, C_CLK_EDGE,
               "125 MHz oscillator", "LVDS reference clock",
               title_fs=8.4, body_fs=7.0, title_dy=2.4)
    refclk_arrow(ax, (phy_x, clk_y0 + clk_h / 2), (119.0, clk_y0 + clk_h / 2),
                 "ref_clk", (125.0, clk_y0 + clk_h / 2 + 2.4), fs=7.0)

    # ---- board Ethernet port: GEM0 over MIO ---------------------------------
    titled_box(ax, fmc_x0, 2.0, fmc_x1 - fmc_x0, 11.0, C_CAGE_FILL, C_LINKARR_EDGE,
               "Board Ethernet port (RJ45)",
               "PHY: ZedBoard 88E1518 @ 0,\nPicoZed SOM 88E151x @ 0, ZC706 88E1116R @ 7",
               title_fs=8.6, body_fs=6.9, title_dy=2.4)
    harrow(ax, ps_r, fmc_x0, mio_y + 3.5, "RGMII + MDIO over MIO (does not pass through the PL)",
           C_LINKARR_FILL, C_LINKARR_EDGE, double=True, bh=1.7, hh=3.0, hl=2.0,
           fs=8.0)

    save(fig, "zynq-gem-design-block-diagram.png")


# ============================================================================
# Zynq UltraScale+
# ============================================================================
def zynqmp():
    fig, ax = plt.subplots(figsize=(16.0, 11.0), dpi=120)
    ax.set_xlim(0, 160)
    ax.set_ylim(0, 110)
    ax.axis("off")

    rows = {0: 89.0, 1: 74.0, 2: 59.0, 3: 44.0}
    mio_y = 7.0

    # ---- PS column ----------------------------------------------------------
    ps_x0, ps_w = 2, 22
    ps_r = ps_x0 + ps_w
    box(ax, ps_x0, 2, ps_w, 102.0, C_PS_FILL, C_PS_EDGE, "", lw=1.3)
    ax.text(ps_x0 + 8, 97.0, "Zynq\nUltraScale+\nPS", ha="center", va="center",
            fontsize=11.0, weight="bold", color=TXT, linespacing=1.25)
    ax.text(ps_x0 + 8, 30.0, "Arm\nCortex-A53\n\nLinux (PetaLinux\nor Yocto) or the\n"
            "bare-metal lwIP\necho server",
            ha="center", va="center", fontsize=7.2, color=TXT, linespacing=1.4)
    px = ps_r - 7.5
    for p, yc in rows.items():
        ps_port(ax, px, yc, f"GEM{p}\n(EMIO)")
    ps_port(ax, px, mio_y + 3.5, "GEM3\n(MIO)")

    # ---- FPGA fabric ---------------------------------------------------------
    fab_x0, fab_x1, fab_y0, fab_y1 = 27.5, 113.0, 17.0, 104.0
    ax.add_patch(plt.Rectangle((fab_x0, fab_y0), fab_x1 - fab_x0, fab_y1 - fab_y0,
                               fc=C_FAB_FILL, ec=C_FAB_EDGE, lw=1.3, zorder=1))
    ax.text((fab_x0 + fab_x1) / 2, fab_y1 + 1.2, "FPGA fabric (PL)", ha="center",
            va="bottom", fontsize=13, weight="bold", color=TXT)

    g_x, g_w = 62.0, 24.0
    for p, yc in rows.items():
        if p == 2:
            body = "shared logic: clock gen.\n+ IDELAYCTRL\nMDIO address 8"
        else:
            body = "clocks from\ngmii_to_rgmii_2\nMDIO address 8"
        titled_box(ax, g_x, yc - 6.0, g_w, 12.0, C_MAC_FILL, C_MAC_EDGE,
                   f"gmii_to_rgmii_{p}", body, title_fs=8.6, body_fs=6.9,
                   title_dy=2.4)
        harrow(ax, ps_r, g_x, yc, "GMII + MDIO", C_AXARR_FILL, C_AXARR_EDGE,
               double=True, bh=1.6, hh=3.0, hl=2.0, fs=8.0)

    # clocking + resets
    clk_y0, clk_h = 19.0, 13.0
    titled_box(ax, 31.0, clk_y0, 80.0, clk_h, C_CLK_FILL, C_CLK_EDGE,
               "Clocking and resets",
               "clk_wiz_0: Ethernet FMC 125 MHz reference → 375 MHz →\n"
               "gmii_to_rgmii_2 clkin + util_idelay_ctrl (IDELAY reference)\n"
               "proc_sys_reset (pl_clk0): PHY resets and GMII-to-RGMII resets",
               title_fs=8.6, body_fs=7.1, title_dy=2.5)

    # ---- Ethernet FMC ----------------------------------------------------------
    fmc_x0, fmc_x1 = 120.0, 152.0
    fcx = (fmc_x0 + fmc_x1) / 2
    ax.add_patch(plt.Rectangle((fmc_x0, fab_y0), fmc_x1 - fmc_x0, fab_y1 - fab_y0,
                               fc=C_FMC_FILL, ec=C_FMC_EDGE, lw=1.3, zorder=1))
    ax.text(fcx, fab_y1 + 1.2, "External to the ZynqMP", ha="center", va="bottom",
            fontsize=12, weight="bold", color=TXT)
    ax.text(fcx, 99.8, "Ethernet FMC (OP031 / OP041)", ha="center", va="center",
            fontsize=9.2, weight="bold", color=TXT)
    phy_x, phy_w = 123.0, 26.0
    for p, yc in rows.items():
        body = "Marvell 88E1510 PHY\nown MDIO bus, address 0"
        if p == 3:
            body += "\n(not used by zcu102_hpc1)"
        titled_box(ax, phy_x, yc - 5.5, phy_w, 11.0, C_CAGE_FILL, C_FMC_EDGE,
                   f"Port {p}", body, title_fs=8.8, body_fs=6.9, title_dy=2.3)
        harrow(ax, g_x + g_w, phy_x, yc, "RGMII + MDIO", C_LINKARR_FILL,
               C_LINKARR_EDGE, double=True, bh=1.7, hh=3.0, hl=2.0, fs=7.6)
    titled_box(ax, phy_x, clk_y0 + 1.5, phy_w, 10.0, C_CLK_FILL, C_CLK_EDGE,
               "125 MHz oscillator", "LVDS reference clock",
               title_fs=8.4, body_fs=7.0, title_dy=2.4)
    refclk_arrow(ax, (phy_x, clk_y0 + 6.5), (111.0, clk_y0 + 6.5),
                 "ref_clk", (117.0, clk_y0 + 9.0), fs=7.0)

    # ---- zcu102_hpc1 variant: GEM3 stays on MIO -----------------------------
    titled_box(ax, fmc_x0, 2.0, fmc_x1 - fmc_x0, 11.0, C_CAGE_FILL, C_MUTED,
               "ZCU102 Ethernet port (RJ45)", "TI DP83867 PHY, MDIO address 0x0C",
               title_fs=8.6, body_fs=6.9, title_dy=2.6, ls="--")
    harrow(ax, ps_r, fmc_x0, mio_y + 3.5,
           "zcu102_hpc1 only: GEM3 stays on MIO for the board's own Ethernet port;"
           " the design uses GEM0-2 for FMC ports 0-2",
           "#F7F7F7", C_MUTED, double=True, bh=1.7, hh=3.0, hl=2.0, fs=7.6,
           ls="--", lab_color="#404040")

    save(fig, "zynqmp-gem-design-block-diagram.png")


if __name__ == "__main__":
    zynq7000()
    zynqmp()
