@echo off

:installGit
    setlocal
    set "installDir=%~dp0Git"
    set "configFile=%temp%\config.inf"

    (
        echo [Setup]
        echo Lang=default
        echo Dir=%installDir%
        echo Group=Git
        echo NoIcons=0
        echo SetupType=default
        echo Components=icons,ext\reg\shellhere,assoc,assoc_sh
        echo Tasks=
        echo PathOption=Cmd
        echo SSHOption=OpenSSH
        echo CRLFOption=CRLFAlways
        echo BashTerminalOption=ConHost
        echo PerformanceTweaksFSCache=Enabled
        echo UseCredentialManager=Enabled
        echo EnableSymlinks=Disabled
        echo EnableBuiltinDifftool=Disabled
    ) > "%configFile%"

    set "gitInstaller="
    for /r %%f in (git*.exe) do (
        set "gitInstaller=%%f"
        echo Found installer: %%f
    )

    if not defined gitInstaller (
        echo Error: Could not find Git installer (git*.exe).
        exit /b 2
    )

    echo Installing Git...
    "%gitInstaller%" /VERYSILENT /LOADINF="%configFile%"
    if errorlevel 1 (
        echo Error during Git installation.
        del "%configFile%"
        exit /b %errorlevel%
    )

    del "%configFile%"
    echo Git installed successfully in %installDir%.

    endlocal
    exit /b 0
goto:eof

:: Call the function
call :installGit
