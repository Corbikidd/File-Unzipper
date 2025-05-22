@echo off
setlocal enabledelayedexpansion

:: Set specific search directory inside File Unzipper
set "SEARCHDIR=%USERPROFILE%\File Unzipper\File_finder"

echo Searching for unzip.bat in %SEARCHDIR%...
set "FOUND="

:: Scan for the file
for %%F in ("%SEARCHDIR%\unzip.bat") do if exist "%%F" (
    set "FOUND=%%F"
    goto :FOUND
)

:: If not found, display message
echo File not found in %SEARCHDIR%. Make sure "unzip.bat" exists in the File_finder folder.
pause
exit /b

:FOUND
echo Found at: %FOUND%
echo Opening...
start "" "%FOUND%"
exit /b