SRC_URI_append += " \
		file://tebf0808_fsbl.patch \
		"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# Note: This is not required if you are using Yocto
# CAUTION!: EXTERNALXSCTSRC and EXTERNALXSCTSRC_BUILD is required only for 2018.2 and below petalinux releases
EXTERNALXSCTSRC = ""
EXTERNALXSCTSRC_BUILD = ""
