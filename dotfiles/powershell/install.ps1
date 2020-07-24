#requires -RunAsAdministrator

Import-Module "$PSScriptRoot\..\..\scripts\utils.psm1"

# create a link documents to the profile file
New-Folder '~\Documents\WindowsPowerShell'
New-Symlink '~\Documents\WindowsPowerShell\profile.ps1' "$PSScriptRoot\profile.ps1"

# download offline help
Update-Help

Remove-Module utils
