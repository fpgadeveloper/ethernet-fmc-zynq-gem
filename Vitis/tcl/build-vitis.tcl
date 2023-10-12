#!/usr/bin/tclsh

# Description
# -----------
# This Tcl script will create Vitis workspace and add a software application for the specified
# target design. If a target design is not specified, a software application will be added for 
# each of the exported hardware designs in the ../Vivado directory.

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

# Specify the postfix on the Vivado projects (if one is used)
set vivado_postfix ""

# Set the app template used to create the application
set support_app "lwip_echo_server"
set template_app "lwIP Echo Server"

# Microblaze designs: Generate combined .bit and .elf file
set mb_combine_bit_elf 1

# Possible targets (board name in lower case for the board.h file)
dict set target_dict pynqzu { pynqzu }
dict set target_dict pz_7030 { pz }
dict set target_dict uzeg_pci { uzeg_pci }
dict set target_dict uzev { uzev}
dict set target_dict zc706_lpc { zc706 }
dict set target_dict zcu102_hpc0 { zcu102 }
dict set target_dict zcu102_hpc1 { zcu102 }
dict set target_dict zcu104 { zcu104 }
dict set target_dict zcu106_hpc0 { zcu106 }
dict set target_dict zcu111 { zcu111 }
dict set target_dict zcu208 { zcu208 }
dict set target_dict zedboard { zedboard }

# Target can be specified by creating the target variable before sourcing, or in the arguments
if { $argc >= 1 } {
  set target [lindex $argv 0]
  puts "Target for the build: $target"
} elseif { [info exists target] && [dict exists $target_dict $target] } {
  puts "Target for the build: $target"
} else {
  puts "No target specified, or invalid target."
  set target ""
}

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
# Use these functions to make custom changes to the platform or standard application template 
# such as modifying files or copying sources into the platform/application.
# These functions are called after creating the platform/application and before build.

proc custom_platform_mods {platform_name} {
  # For UltraZed EG design, patch the psu_init.c file
  if { $platform_name == "uz_pci" } {
    patch_psu_init_uzeg "./uz_pci/zynqmp_fsbl/psu_init.c"
  }
}

proc custom_app_mods {platform_name app_name} {
  # Copy common sources into the application
  copy-r "common/src" "${app_name}/src"
}

# Call the workspace builder script
source tcl/workspace.tcl

