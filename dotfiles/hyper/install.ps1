#requires -RunAsAdministrator

Import-Module "$PSScriptRoot\..\..\scripts\utils.psm1"

# create a link in app-data to the `_hyper.js` config file
New-Symlink "$env:APPDATA\Hyper\.hyper.js" "$PSScriptRoot\_hyper.js"

Remove-Module utils
