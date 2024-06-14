@REM  Set Variable called github_mods_url and set it to https://github.com/PFearr/smp_mods

set github_mods_url="https://github.com/PFearr/smp_mods.git"

@REM make a new dir called TMP_MODS, if already exist delete it and make a new one
if exist TMP_MODS rmdir /s /q TMP_MODS
mkdir TMP_MODS

@REM download the mods from github
git clone %github_mods_url% TMP_MODS

@REM in cmd.exe run command "cd TMP_MODS && ./unzip.bat"
cmd /c "cd TMP_MODS && unzip.bat"
timeout /t 2
cd TMP_MODS


@REM check if %APPDATA%\.minecraft\mods exist, if not create it
if not exist %APPDATA%\.minecraft\mods mkdir %APPDATA%\.minecraft\mods

@REM Remove all .jar files in %APPDATA%\.minecraft\mods
del %APPDATA%\.minecraft\mods\*.jar

dir 

@REM get only the .jar files and copy them to %APPDATA%\.minecraft\mods
for /r files_unzipped %%f in (*.jar) do copy "%%f" %APPDATA%\.minecraft\mods

@REM delete the TMP_MODS folder
rmdir /s /q TMP_MODS

@REM pause the script and echo Done installing mods
echo Done installing mods
pause
