@echo off

:: disable `bash` to force using `wsl` (to open the default shell instead)
:: TODO: this only disables `bash` through cmd, not powershell or Win+R
doskey bash=echo No, run `wsl`

:: exit with ^D and Enter
doskey =exit

:: greetings
echo Welcome!
