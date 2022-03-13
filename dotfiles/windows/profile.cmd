@echo off

:: disable legacy `bash` command in favor of `wsl`,
:: because it opens `bash` regardless of the default shell configured
doskey bash=echo No, run `wsl`

:: disable legacy `powershell` in favor of the newer cross-platform `pwsh`
:: disable instead of alias to make me get used to writing `pwsh`
doskey powershell=echo No, run `pwsh`

:: exit with ^D and Enter
:: supply an explicit exit code since otherwise the exit code will be the exit code of the last command we ran
doskey =exit 0
:: cls with ^P and Enter since ^L can't be bound
doskey =cls
doskey cls=echo No, use Control+P

:: linux-like aliases
doskey ls=dir $*
doskey cat=type $*
doskey ~=cd %USERPROFILE%
:: NOTE: doskey also works with a file: `doskey /macrofile=path\to\macros.mac`
:: this file should just have lines that look like `foo=bar`, and comments using semicolon

:: greetings
:: TODO: this also outputs in non-login shells, make it stop
REM echo Welcome!
