#requires -RunAsAdministrator

Import-Module "$PSScriptRoot\..\..\scripts\utils.psm1"

# create a link in app data to the vimrc file
New-Symlink '~\AppData\Local\nvim\init.vim' "$PSScriptRoot\_2.vimrc"

Remove-Module utils
