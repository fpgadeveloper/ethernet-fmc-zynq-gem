# Copyright (C) 2021 Xilinx, Inc
# SPDX-License-Identifier: BSD-3-Clause

SRC_URI:append = " \
        file://0001-syzygy-voltage-handshake.patch \
        "
  
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

#Enable appropriate FSBL debug flags  
YAML_COMPILER_FLAGS:append = " -DFSBL_PRINT"
