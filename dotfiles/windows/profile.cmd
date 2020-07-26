@echo off

:: disable legacy `bash` command in favor of `wsl`,
:: because it opens `bash` regardless of the default shell configured
doskey bash=echo No, run `wsl`

:: exit with ^D and Enter
doskey =exit

:: ls alias
doskey ls=dir

:: greetings
:: TODO: this also outputs in non-login shells, make it stop
REM echo Welcome!
