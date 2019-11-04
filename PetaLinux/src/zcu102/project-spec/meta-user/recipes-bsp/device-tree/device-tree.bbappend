SRC_URI_append ="\
    file://system-user.dtsi \
    file://zcu102-i2c.dtsi \
"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
