SRC_URI += "file://user.cfg \
            file://macb-gmii2rgmii.patch \
            file://edac-cortex.cfg \
            "

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

