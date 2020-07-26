#requires -RunAsAdministrator

Import-Module "$PSScriptRoot\..\..\scripts\utils.psm1"

# create links in home to the global gitignore and gitconfig files
New-Folder '~\.config\git\'
New-Symlink '~\.config\git\ignore' "$PSScriptRoot\_.gitignore"
New-Symlink '~\.config\git\config' "$PSScriptRoot\_.gitconfig"

# setup bash for git bash
. "$PSScriptRoot\..\bash\install.ps1"

Remove-Module utils
