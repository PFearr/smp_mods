@echo off
setlocal

REM Initialize version variable
set version=

REM Read the content of newest_version.txt and set the version variable
for /f "tokens=*" %%a in (newest_version.txt) do (
  set version=%%a
)

REM Ensure version variable is set
if "%version%"=="" (
  echo Error: version not found in newest_version.txt
  exit /b 1
)

REM Create the directory for unzipped files if it doesn't exist
if not exist files_unzipped (
  mkdir files_unzipped
)

REM Find and unzip the file
set zipfile=
for %%f in (*%version%*.zip) do (
  set zipfile=%%f
)

REM Ensure the zip file was found
if "%zipfile%"=="" (
  echo Error: No zip file found for version %version%
  exit /b 1
)

REM Unzip the found file to files_unzipped directory
echo Unzipping %zipfile% to files_unzipped
tar -xf %zipfile% -C files_unzipped

echo Done
