@echo off
setlocal enabledelayedexpansion

:: Check if running inside "File Unzipper" folder
set "EXPECTED_FOLDER=File Unzipper"
for %%A in ("%CD%") do set "CURRENT_FOLDER=%%~nxA"

if /i not "%CURRENT_FOLDER%"=="%EXPECTED_FOLDER%" (
    echo This script must be run from the "%EXPECTED_FOLDER%" folder.
    pause
    exit /b
)

:: Ask for category
echo Select a category to scan for ZIP files:
echo 1: Downloads
echo 2: Desktop
echo 3: Documents
echo 4: Attachments
echo 5: Pictures
echo 6: Music
echo 7: Videos
set /p CATEGORY="Enter the number of your choice: "

:: Set search directory based on user choice
if "%CATEGORY%"=="1" set "SEARCHDIR=%USERPROFILE%\Downloads"
if "%CATEGORY%"=="2" set "SEARCHDIR=%USERPROFILE%\Desktop"
if "%CATEGORY%"=="3" set "SEARCHDIR=%USERPROFILE%\Documents"
if "%CATEGORY%"=="4" set "SEARCHDIR=%USERPROFILE%\Documents\Attachments"
if "%CATEGORY%"=="5" set "SEARCHDIR=%USERPROFILE%\Pictures"
if "%CATEGORY%"=="6" set "SEARCHDIR=%USERPROFILE%\Music"
if "%CATEGORY%"=="7" set "SEARCHDIR=%USERPROFILE%\Videos"

if not defined SEARCHDIR (
    echo Invalid selection. Exiting...
    pause
    exit /b
)

echo Scanning %SEARCHDIR% for ZIP files...
set "INDEX=1"

:: Find ZIP files in the chosen category
for /r "%SEARCHDIR%" %%F in (*.zip) do (
    set "FILE!INDEX!=%%F"
    echo !INDEX!: %%F
    set /a INDEX+=1
)

if "%INDEX%"=="1" (
    echo No ZIP files found in the selected category.
    pause
    exit /b
)

:: Ask the user to select a file by number
echo.
set /p CHOICE="Enter the number of the ZIP file you want to unzip: "

:: Get the chosen file path
set "ZIPFILE=!FILE%CHOICE%!"

:: Set destination folder (unzip to same location as ZIP file)
for %%A in ("%ZIPFILE%") do set "DESTFOLDER=%%~dpA\Extracted"

:: Create destination folder
mkdir "%DESTFOLDER%" 2>nul

:: Use PowerShell to extract the ZIP file
powershell -command "Expand-Archive -Path '%ZIPFILE%' -DestinationPath '%DESTFOLDER%' -Force"

echo Unzipping completed! Files extracted to %DESTFOLDER%
pause