New-Item -ItemType Directory "$env:USERPROFILE\Documents\WindowsPowerShell"
New-Item -ItemType SymbolicLink "$env:USERPROFILE\Documents\WindowsPowerShell\profile.ps1" -Target "$PSScriptRoot\profile.ps1"
