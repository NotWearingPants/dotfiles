#requires -RunAsAdministrator

Import-Module "$PSScriptRoot\..\..\scripts\utils.psm1"

# create a link in home to the global gitignore file
New-Folder '~\.config\git\'
New-Symlink '~\.config\git\ignore' "$PSScriptRoot\_.gitignore"

Remove-Module utils
