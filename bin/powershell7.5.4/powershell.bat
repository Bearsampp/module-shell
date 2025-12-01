@echo off
REM Bearsampp PowerShell Launcher
REM This script launches PowerShell with the custom Bearsampp profile
REM
REM Usage: powershell.bat [--title "Title"] [--startingDirectory "Path"]
REM   --title              - Optional: Window title
REM   --startingDirectory  - Optional: Starting directory

setlocal EnableDelayedExpansion

REM Get the directory where this script is located
set "SHELL_ROOT=%~dp0"
set "SHELL_ROOT=%SHELL_ROOT:~0,-1%"

REM Set the custom profile path
set "CUSTOM_PROFILE=%SHELL_ROOT%\config\Microsoft.PowerShell_profile.ps1"

REM Default values
set "WINDOW_TITLE=Bearsampp PowerShell Console"
set "START_DIR=%CD%"

REM Parse command line arguments
:parse_args
if "%~1"=="" goto end_parse
if /i "%~1"=="--title" (
    set "WINDOW_TITLE=%~2"
    shift
    shift
    goto parse_args
)
if /i "%~1"=="--startingDirectory" (
    set "START_DIR=%~2"
    shift
    shift
    goto parse_args
)
shift
goto parse_args
:end_parse

REM Build the PowerShell command
set "PS_COMMAND=$Host.UI.RawUI.WindowTitle='!WINDOW_TITLE!'; Set-Location '!START_DIR!'; . '!CUSTOM_PROFILE!'"

REM Launch PowerShell with custom profile and parameters
"%SHELL_ROOT%\pwsh.exe" -NoExit -NoProfile -Command "!PS_COMMAND!"

endlocal
=======
