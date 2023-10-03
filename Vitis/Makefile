# Opsero Electronic Design Inc. 2023
#
# This Makefile can be used to build the Vitis workspace.

CP = cp -rf
MKDIR = mkdir -p
RM = rm -rf
ROOT_DIR = $(shell pwd)
XSCT = $(XILINX_VITIS)/bin/xsct
BD_NAME = zynqgem
APP_POSTFIX = _echo_server
SYS_POSTFIX = $(APP_POSTFIX)_system

# defaults
.DEFAULT_GOAL := workspace
TARGET ?= none
JOBS ?= 8

# valid targets
mz_7020_target := 0
pynqzu_target := 0
pz_7030_target := 0
uzeg_pci_target := 0
uzev_target := 0
zc706_lpc_target := 0
zcu102_hpc0_target := 0
zcu102_hpc1_target := 0
zcu104_target := 0
zcu106_hpc0_target := 0
zcu111_target := 0
zcu208_target := 0
zedboard_target := 0

TARGET_LIST := $(patsubst %_target,%,$(filter %_target,$(.VARIABLES)))

# Vitis paths
VIT_SCRIPT_WS = tcl/build-vitis.tcl

# Vivado paths
VIV_DIR = $(ROOT_DIR)/../Vivado
VIV_PRJ_DIR = $(VIV_DIR)/$(TARGET)
VIV_XSA = $(VIV_PRJ_DIR)/$(BD_NAME)_wrapper.xsa

.PHONY: help
help:
	@echo 'Usage:'
	@echo ''
	@echo '  make workspace TARGET=<target> JOBS=<val>'
	@echo '    Create the Vitis workspace and add applications for specified target.'
	@echo ''
	@echo '  make all JOBS=<val>'
	@echo '    Create the Vitis workspace and add applications for all targets.'
	@echo ''
	@echo '  make clean'
	@echo '    Delete the Vitis workspace and all applications.'
	@echo ''
	@echo 'Parameters:'
	@echo ''
	@echo '  TARGET: Name of the target design, must be one of the following:'
	@$(foreach targ,$(sort $(TARGET_LIST)),echo "    - $(targ)";)
	@echo ''
	@echo '  JOBS: Optional param to set number of synthesis jobs (default 8)'
	@echo ''
	@echo 'Example usage:'
	@echo '  make workspace TARGET=$(word 1,$(TARGET_LIST))'
	@echo ''

.PHONY: all
all:
	for targ in $(TARGET_LIST); do \
		$(MAKE) workspace TARGET=$$targ; \
	done

.PHONY: workspace
workspace: check_target $(VIV_XSA)
	$(XSCT) $(VIT_SCRIPT_WS) $(TARGET)

$(VIV_XSA):
	$(MAKE) -C $(VIV_DIR) xsa TARGET=$(TARGET) JOBS=$(JOBS)

.PHONY: clean
clean:
	for targ in $(TARGET_LIST); do \
		$(RM) $${targ} $${targ}$(APP_POSTFIX) $${targ}$(SYS_POSTFIX); \
	done
	$(RM) boot .metadata .Xil IDE.log .analytics updatemem*.jou updatemem*.log RemoteSystemsTempFiles embeddedsw

check_target:
ifndef $(TARGET)_target
	$(error "Please specify a TARGET. Use 'make help' to see valid targets.")
endif


