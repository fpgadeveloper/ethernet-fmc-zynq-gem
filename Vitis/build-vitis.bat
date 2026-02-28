@ECHO OFF

setlocal ENABLEDELAYEDEXPANSION
SET vitis=C:\AMDDesignTools\2025.2\Vitis\bin\xsct.bat
cmd /c "%vitis% tcl\build-vitis.tcl"
pause
