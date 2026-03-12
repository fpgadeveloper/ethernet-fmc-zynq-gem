"""Pre-build fixup required for lwip_echo_server template apps.

Fix: override PLATFORM_EMAC_BASEADDR with user-configurable port selection
  The template's lwip_echo_server.cmake auto-selects a MAC instance for
  PLATFORM_EMAC_BASEADDR, but the user has no control over which port is
  used. This script patches platform_config.h.in to replace the cmake-
  generated PLATFORM_EMAC_BASEADDR with the contents of port_config.h,
  which lets the user select the desired Ethernet port.
  The content is inlined because platform_config.h is generated into
  build/include/ where it cannot resolve #include paths to files in src/.

Usage: called by build-vitis.py with app_src as the first argument.
"""

import os, sys

def main():
    if len(sys.argv) < 2:
        print("Usage: pre_build.py <app_src_dir>")
        sys.exit(1)

    app_src = sys.argv[1]
    config_in = os.path.join(app_src, "platform_config.h.in")

    if not os.path.isfile(config_in):
        print(f"WARNING: {config_in} not found; skipping patch")
        return

    with open(config_in, "r") as f:
        content = f.read()

    old = "#cmakedefine PLATFORM_EMAC_BASEADDR @PLATFORM_EMAC_BASEADDR@"

    if old not in content:
        print(f"NOTE: cmake PLATFORM_EMAC_BASEADDR line not found in {config_in}; skipping")
        return

    # Read port_config.h and inline its content
    port_config = os.path.join(app_src, "port_config.h")
    if not os.path.isfile(port_config):
        print(f"WARNING: {port_config} not found; skipping patch")
        return

    with open(port_config, "r") as f:
        port_config_content = f.read()

    content = content.replace(old, port_config_content)
    with open(config_in, "w") as f:
        f.write(content)
    print(f"Patched {config_in}: inlined port_config.h content")

if __name__ == "__main__":
    main()
