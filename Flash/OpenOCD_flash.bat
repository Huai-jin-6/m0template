@echo off
REM Get the project name (parent directory of this script)
for %%i in ("%~dp0\..") do set "PROJECT_NAME=%%~nxi"

REM Build ELF file path (use forward slashes for OpenOCD compatibility)
set "ELF_FILE=build/%PROJECT_NAME%.elf"
set "ELF_FILE=%ELF_FILE:\=/%"

REM Check if file exists
if not exist "%ELF_FILE%" (
    echo Error: ELF file not found at %ELF_FILE%
    exit /b 1
)

REM OpenOCD path
set "OPENOCD_PATH=d:\Embedded_Tools\OpenOCD-20260302\bin\openocd.exe"

REM DAPLink config file path
set "DAPLINK_CFG=%~dp0daplink.cfg"

REM Flash firmware
"%OPENOCD_PATH%" -f "%DAPLINK_CFG%" -c "program \"%ELF_FILE%\" verify reset exit"
pause