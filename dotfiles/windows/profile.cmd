@echo off

:: disable `bash` to force using `wsl` (to open the default shell instead)
:: TODO: this only disables `bash` through cmd, not powershell or Win+R
doskey bash=echo No, run `wsl`

:: exit with ^D and Enter
doskey =exit

:: ls alias
doskey ls=dir

:: greetings
:: TODO: this also outputs in non-login shells, make it stop
REM echo Welcome!
