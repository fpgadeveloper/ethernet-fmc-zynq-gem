# Patch for FSBL
SRC_URI_append = " \
        file://zcu104_vadj_fsbl.patch \
        "
  
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
  
#Add debug for FSBL(optional)
XSCTH_BUILD_DEBUG = "1"
  
# Note: This is not required if you are using Yocto
EXTERNALXSCTSRC = ""
EXTERNALXSCTSRC_BUILD = ""
