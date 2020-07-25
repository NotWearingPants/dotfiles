#requires -RunAsAdministrator

Import-Module "$PSScriptRoot\..\..\scripts\utils.psm1"

# create a link in documents to the profile file for Windows PowerShell
New-Folder '~\Documents\WindowsPowerShell'
New-Symlink '~\Documents\WindowsPowerShell\profile.ps1' "$PSScriptRoot\profile.ps1"

# create a link in documents to the profile file for Powershell Core
New-Folder '~\Documents\PowerShell'
New-Symlink '~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1' "$PSScriptRoot\profile.ps1"

# download offline help
Update-Help

Remove-Module utils
