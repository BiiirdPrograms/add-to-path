@echo off
@REM SET regkey1=hkcr\Directory\shell\AddToPath
SET regkey1=hkcu\Software\Classes\Directory\shell\AddToPath

:: Check whether the registry keys exist
reg query %regkey1% >nul 2>&1

if %ERRORLEVEL% equ 0 (
  :: Delete the registry keys
  reg delete %regkey1% /f >nul 2>&1
)

del %USERPROFILE%\addtopath.bat /q >nul 2>&1

echo [92mAdd to Path context menu option uninstalled successfully[0m
pause