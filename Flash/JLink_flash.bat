@echo off
setlocal enabledelayedexpansion

REM Get the project name (parent directory of this script)
for %%i in ("%~dp0\..") do set "PROJECT_NAME=%%~nxi"

REM Build ELF file path
set "ELF_FILE=build\!PROJECT_NAME!.elf"

REM Check if file exists
if not exist "!ELF_FILE!" (
    echo Error: ELF file not found at !ELF_FILE!
    
    REM Try to find .elf files in build directory
    if exist "build\*.elf" (
        echo Looking for available ELF files in build directory...
        for %%f in (build\*.elf) do (
            set "FOUND_ELF=%%f"
            echo Found: !FOUND_ELF!
        )
        set "ELF_FILE=!FOUND_ELF!"
        echo Using: !ELF_FILE!
    ) else (
        echo Error: No ELF files found in build directory!
        pause
        exit /b 1
    )
)

echo Project Name: !PROJECT_NAME!
echo ELF File: !ELF_FILE!

REM Create temporary J-Link script
set "TEMP_SCRIPT=temp_jlink_script.jlink"
(
echo device MSPM0G3507
echo if SWD
echo speed 4000
echo r
echo loadfile !ELF_FILE!
echo r
echo go
echo exit
) > "!TEMP_SCRIPT!"

REM J-Link installation path
set "JLINK_PATH=C:\Program Files\SEGGER\JLink_V960"

REM Execute J-Link
"!JLINK_PATH!\JLink.exe" -CommanderScript "!TEMP_SCRIPT!"

REM Clean up temp file
del "!TEMP_SCRIPT!"

pause