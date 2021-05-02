=====================
Updating the projects
=====================

This section contains instructions for updating the reference designs. It is intended as a guide
for anyone wanting to attempt updating the designs for a tools release that we do not yet support.
Note that the update process is not always straight-forward and sometimes requires dealing with
new issues or significant changes to the functionality of the tools and/or specific IP. Unfortunately, 
we cannot always provide support if you have trouble updating the designs.

Vivado projects
===============

1. Download and install the Vivado release that you intend to use.
2. If you are using one of the following boards, you will have to download and install the latest 
   board files for that target platform. Other boards are already built into Vivado and require no
   extra installation.

   * MicroZed board files can be downloaded `here <https://github.com/Avnet/bdf>`_
   * PicoZed board files can be downloaded `here <https://github.com/Avnet/bdf>`_
   * UltraZed EG and EV board files can be downloaded `here <https://github.com/Avnet/bdf>`_
   
3. In a text editor, open the ``Vivado/build-<target>.bat`` file for
   the design that you wish to update, and perform the following changes:
   
   * Update the tools version number to the one you are using (eg. 2020.2)
   
4. In a text editor, open the ``Vivado/build-<target>.tcl`` file for
   the design that you wish to update, and perform the following changes:
   
   * Update the ``version_required`` variable value to the tools version number 
     that you are using.
   * Update the year in all references to ``Vivado Synthesis <year>`` to the 
     tools version number that you are using. For example, if you are using tools
     version 2020.2, then the ``<year>`` should be 2020.
   * Update the year in all references to ``Vivado Implementation <year>`` to the 
     tools version number that you are using. For example, if you are using tools
     version 2020.2, then the ``<year>`` should be 2020.
   * If the version of the board files for your target platform has changed, update 
     the ``board_part`` parameter value to the new version.

After following the above steps, you can now run the build script. If there were no significant changes
to the tools and/or IP, the build script should succeed and you will be able to open and generate a 
bitstream for the Vivado project.

PetaLinux
=========

The main procedure for updating the PetaLinux project is to update the BSP for the target platform.
The BSP files for each supported target platform are contained in the ``PetaLinux/src`` directory.
For example, the BSP files for the ZedBoard are located in ``PetaLinux/src/zedboard``.

1. Download and install the PetaLinux release that you intend to use.
2. Download and install the BSP for the target platform for the release that you intend to use.

   * MicroZed BSP
   * PicoZed BSP
   * UltraZed EG and EV BSP
   * ZC706 BSP from the `PetaLinux download page <https://www.xilinx.com/petalinux>`_
   * ZCU102 BSP from the `PetaLinux download page <https://www.xilinx.com/petalinux>`_
   * ZCU104 BSP from the `PetaLinux download page <https://www.xilinx.com/petalinux>`_
   * ZCU106 BSP from the `PetaLinux download page <https://www.xilinx.com/petalinux>`_
   * ZedBoard BSP from the `PetaLinux download page <https://www.xilinx.com/petalinux>`_
   * TEBF0808 BSP

3. Update the BSP files for the target platform in the ``PetaLinux/src/<platform>`` directory. 
   These are the specific directories to update:
   
   * ``<platform>/project-spec/configs/*``
   * ``<platform>/project-spec/meta-user/*``
   
   The simple way to update the files is to delete those in the repository and copy in those from
   the BSP that you just downloaded.
   
4. Apply the required modifications to the updated BSP files. The modifications are described for each
   target platform in the following sections.
   
Change project name
-------------------

This BSP modification applies to all target platforms.

1. Append the following lines to ``project-spec/configs/config``:

.. code-block:: 
   
  # Set project name
  CONFIG_SUBSYSTEM_HOSTNAME="zynqgem"
  CONFIG_SUBSYSTEM_PRODUCT="zynqgem"
   
Note that this will set the project name to "zynqgem" but you can use a more descriptive name, for example
one that includes the target platform name and the tools version.

Add tools to root filesystem
----------------------------

This BSP modification applies to all target platforms.

1. Append the following lines to ``project-spec/configs/rootfs_config``:

.. code-block::

  # Useful tools for Ethernet FMC
  CONFIG_ethtool=y
  CONFIG_ethtool-dev=y
  CONFIG_ethtool-dbg=y
  CONFIG_iperf3=y

2. Append the following lines to ``project-spec/meta-user/conf/user-rootfsconfig``:

.. code-block::

  CONFIG_iperf3
  CONFIG_ethtool

Include port config in device tree
----------------------------------

This BSP modification applies to all target platforms.

1. Append the following line after ``/include/ "system-conf.dtsi"`` in ``project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi``:

.. code-block::

  /include/ "port-config.dtsi"

2. Append the following line after ``SRC_URI += "file://system-user.dtsi"`` in ``project-spec/meta-user/recipes-bsp/device-tree/device-tree.bbappend``:

.. code-block::

  SRC_URI += "file://port-config.dtsi"

Add kernel configs
------------------

This BSP modification applies to all target platforms.

1. Add the following lines to the top of file ``project-spec/meta-user/recipes-kernel/linux/linux-xlnx/bsp.cfg``:

.. code-block::

  # Required by all designs
  CONFIG_XILINX_GMII2RGMII=y

  # Required by BSP

Mods for ZCU104
---------------

These modifications are specific to the ZCU104 BSP.

1. Append the following lines to ``project-spec/configs/config``:

.. code-block:: 
   
   # ZCU104 port configs
   
   CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_0_SELECT=y
   CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_1_SELECT=n
   CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_2_SELECT=n
   CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_3_SELECT=n
   CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_0_USE_DHCP=y
   CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_1_USE_DHCP=y
   CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_2_USE_DHCP=y
   CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_3_USE_DHCP=y
   CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_0_MAC="00:0a:35:00:22:01"
   CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_1_MAC="00:0a:35:00:22:02"
   CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_2_MAC="00:0a:35:00:22:03"
   CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_3_MAC="00:0a:35:00:22:04"
   
2. Add patch for FSBL to ``project-spec/meta-user/recipes-bsp/fsbl/``. You will have to update this
   patch for the version of PetaLinux that you are using. Refer to the existing patch files in that
   location for guidance.

Mods for ZCU106
---------------

These modifications are specific to the ZCU106 BSP.

1. Append the following lines to ``project-spec/configs/config``. The first option prevents the removal of
   the PL DTB nodes that we need in this design. The second option disables the FPGA manager.

.. code-block:: 
   
   # ZCU106 configs
   
   CONFIG_SUBSYSTEM_REMOVE_PL_DTB=n
   CONFIG_SUBSYSTEM_FPGA_MANAGER=n
   


