#requires -RunAsAdministrator

Import-Module "$PSScriptRoot\..\..\scripts\utils.psm1"

# create a link in app-data to the `_.hyper.js` config file
New-Symlink "$env:APPDATA\Hyper\.hyper.js" "$PSScriptRoot\_.hyper.js"

Remove-Module utils
