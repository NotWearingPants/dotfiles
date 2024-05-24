#requires -RunAsAdministrator

Import-Module "$PSScriptRoot\..\..\scripts\utils.psm1"

# create a link in AppData to the vimrc file
New-Symlink "$env:LOCALAPPDATA\nvim\init.vim" "$PSScriptRoot\_2.vimrc"

Remove-Module utils
