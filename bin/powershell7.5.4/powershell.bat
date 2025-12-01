@echo off
REM Bearsampp PowerShell Launcher
REM This script launches PowerShell with the custom Bearsampp profile
REM Supports Windows Terminal-style arguments: --title, --startingDirectory, --command

setlocal enabledelayedexpansion

REM Get the directory where this script is located
set "SHELL_ROOT=%~dp0"
set "SHELL_ROOT=%SHELL_ROOT:~0,-1%"

REM Set the custom profile path
set "CUSTOM_PROFILE=%SHELL_ROOT%\config\Microsoft.PowerShell_profile.ps1"

REM Initialize variables
set "TAB_TITLE="
set "START_DIR="
set "EXEC_COMMAND="

REM Parse command-line arguments
:parse_args
if "%~1"=="" goto end_parse
if /i "%~1"=="--title" (
    set "TAB_TITLE=%~2"
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
if /i "%~1"=="--command" (
    set "EXEC_COMMAND=%~2"
    shift
    shift
    goto parse_args
)
REM If no recognized argument, treat as command
set "EXEC_COMMAND=%~1"
shift
goto parse_args
:end_parse

REM Change to starting directory if specified
if not "%START_DIR%"=="" (
    cd /d "%START_DIR%"
)

REM Build the PowerShell command
set "PS_CMD=. '%CUSTOM_PROFILE%'"

REM Add tab title if specified
if not "%TAB_TITLE%"=="" (
    set "PS_CMD=!PS_CMD!; $host.ui.RawUI.WindowTitle = '%TAB_TITLE%'"
)

REM Add command to execute if specified
if not "%EXEC_COMMAND%"=="" (
    set "PS_CMD=!PS_CMD!; & %EXEC_COMMAND%"
)

REM Launch PowerShell with custom profile and commands
"%SHELL_ROOT%\pwsh.exe" -NoExit -NoProfile -Command "!PS_CMD!"

endlocal
