SRC_URI += "file://user.cfg \
	    file://axieth.patch \
            "
KERNEL_FEATURES_append = " user.cfg"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

