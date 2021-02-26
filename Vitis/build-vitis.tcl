#!/usr/bin/tclsh

# Description
# -----------
# This Tcl script will create Vitis workspace with software applications for each of the
# exported hardware designs in the ../Vivado directory.

# Set the Vivado directories containing the Vivado projects
set vivado_dirs_rel [list "../Vivado"]
set vivado_dirs {}
foreach d $vivado_dirs_rel {
  set d_abs [file join [pwd] $d]
  append vivado_dirs [file normalize $d_abs] " "
}

# Set the application postfix
# Applications will be named using the app_postfix appended to the board name
set app_postfix "_echo_server"

# Specify the postfix on the Vivado projects so that the workspace builder can find them
set vivado_postfix "_qgige"

# Set the app template used to create the application
set support_app "lwip_echo_server"
set template_app "lwIP Echo Server"

# Microblaze designs: Generate combined .bit and .elf file
set mb_combine_bit_elf 0

# Modifies the psu_init.c in the FSBL for the UltraZed EG
# This removes the line that runs function serdes_illcalib() which seems to cause the
# psu_init sequence to hang.
proc patch_psu_init_uzeg {filename} {
  set fd [open "${filename}" "r"]
  set file_data [read $fd]
  close $fd
  set data [split $file_data "\n"]
  
  # Find the call to serdes_illcalib() and comment it out
  set new_filename "${filename}.txt"
  set fd [open "$new_filename" "w"]
  foreach line $data {
    if {[str_contains $line "serdes_illcalib("]} {
			puts $fd "// Opsero mod"
      puts $fd "//$line"
			puts $fd "// End of Opsero mod"
    } else {
      puts $fd $line
    }
  }
  close $fd

  # Delete the old linker script
  file delete $filename
  
  # Rename new linker script to the old filename
  file rename $new_filename $filename
  
  return 0
}

# ----------------------------------------------------------------------------------------------
# Custom modifications functions
# ----------------------------------------------------------------------------------------------
# Use this function to make custom changes to the standard application template such as
# modifying files or copying sources into the application.
# This function is called after creating the application and before compile.

proc custom_platform_mods {platform_name} {
  # For UltraZed EG design, patch the psu_init.c file
  if { $platform_name == "uz_pci_qgige_wrapper" } {
    patch_psu_init_uzeg "./uz_pci_qgige_wrapper/zynqmp_fsbl/psu_init.c"
  }
}

proc custom_app_mods {platform_name app_name} {
  # Copy common sources into the application
  copy-r "common/src" "${app_name}/src"
}

# Call the workspace builder script
source tcl/workspace.tcl

