@echo off

:: disable legacy `bash` command in favor of `wsl`,
:: because it opens `bash` regardless of the default shell configured
doskey bash=echo No, run `wsl`

:: disable legacy `powershell` in favor of the newer cross-platform `pwsh`
:: disable instead of alias to make me get used to writing `pwsh`
doskey powershell=echo No, run `pwsh`

:: exit with ^D and Enter
doskey =exit

:: linux-like aliases
doskey ls=dir
:: TODO: doesn't work, seems aliases can't accept extra args
doskey cat=type

:: greetings
:: TODO: this also outputs in non-login shells, make it stop
REM echo Welcome!
