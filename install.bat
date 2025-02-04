@echo off

reg add hkcu\Software\Classes\Directory\shell\AddToPath /ve /t REG_SZ /f /d "A&dd to Path" >nul 2>&1
reg add hkcu\Software\Classes\Directory\shell\AddToPath /v Icon /t REG_EXPAND_SZ /f /d ""%%SystemRoot%%\System32\SHELL32.dll,43"" >nul 2>&1
reg add hkcu\Software\Classes\Directory\shell\AddToPath\command /ve /t REG_EXPAND_SZ /f /d "%%USERPROFILE%%\addtopath.bat ""%%v""" >nul 2>&1

SET batch_target=%USERPROFILE%\addtopath.bat

if exist %batch_target% (
  del /Q %batch_target%
)

:: Create the batch file used to add folders to path
echo @echo off>> %batch_target%
echo.>> %batch_target%
echo if [%%1]==[] (>> %batch_target%
echo   echo Missing argument. Please specify a valid folder path as the argument, e.g. "C:\Users\Luna\Desktop".>> %batch_target%
echo   pause>> %batch_target%
echo   exit>> %batch_target%
echo )>> %batch_target%
echo if not exist %%1 (>> %batch_target%
echo   echo Invalid path. Please specify a valid folder path as the argument, e.g. "C:\Users\Luna\Desktop".>> %batch_target%
echo   pause>> %batch_target%
echo   exit>> %batch_target%
echo )>> %batch_target%
echo.>> %batch_target%
echo for /F "skip=2 tokens=2*" %%%%A in ('reg query "hkcu\Environment" /v "path"') DO SET path_var=%%%%B>> %batch_target%
echo.>> %batch_target%
echo if "%%path_var:~-1%%" neq ";" (>> %batch_target%
echo   SET path_var=%%path_var%%;>> %batch_target%
echo )>> %batch_target%
echo.>> %batch_target%
echo SET new_entry=%%1>> %batch_target%
echo :: Remove quotes from path>> %batch_target%
echo SET new_entry=%%new_entry:~1,-1%%>> %batch_target%
echo.>> %batch_target%
echo setx Path "%%path_var%%%%new_entry%%" ^>nul 2^>^&^1>> %batch_target%
echo.>> %batch_target%
echo echo [92mSuccessfully added [90m"%%new_entry%%"[92m to user Path variable![0m>> %batch_target%
echo pause>> %batch_target%

echo [92mAdd to Path context menu option installed successfully[0m
pause