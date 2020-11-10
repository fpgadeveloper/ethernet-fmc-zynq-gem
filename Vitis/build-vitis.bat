@ECHO OFF

setlocal ENABLEDELAYEDEXPANSION
SET vitis=C:\Xilinx\Vitis\2020.1\bin\xsct.bat
cmd /c "%vitis% build-vitis.tcl"
pause
