# Opsero Electronic Design Inc. 2021
# We patch psu_init.c by copying our modified version into the FSBL build workspace
# during do_compile_prepend bitbake task as descibed here:
# https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842475/PetaLinux+Yocto+Tips
# The patch prevents execution of serdes_illcalib function which causes the FSBL to fail
# on UltraZed EG SoM.

do_compile_prepend(){
   install -m 0644 ${TOPDIR}/../project-spec/hw-description/psu_init.c ${B}/fsbl/psu_init.c
}

