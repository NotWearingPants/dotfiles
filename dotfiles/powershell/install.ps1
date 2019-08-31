New-Item -ItemType Directory "$env:USERPROFILE\Documents\Windows­PowerShell"
New-Item -ItemType SymbolicLink "$env:USERPROFILE\Documents\Windows­PowerShell\profile.ps1" -Target "$PSScriptRoot\profile.ps1"
