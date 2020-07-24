#requires -RunAsAdministrator

Import-Module "$PSScriptRoot\..\..\scripts\utils.psm1"

# create link in home to the global gitignore and gitconfig files
New-Folder '~\.config\git\'
New-Symlink '~\.config\git\ignore' "$PSScriptRoot\_.gitignore"
New-Symlink '~\.config\git\config' "$PSScriptRoot\_.gitconfig"

Remove-Module utils
