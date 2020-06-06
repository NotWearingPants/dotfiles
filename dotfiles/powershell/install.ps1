New-Item -ItemType Directory "~\Documents\WindowsPowerShell"
New-Item -ItemType SymbolicLink "~\Documents\WindowsPowerShell\profile.ps1" -Target "$PSScriptRoot\profile.ps1"
