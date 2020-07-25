#requires -RunAsAdministrator

Import-Module "$PSScriptRoot\..\..\scripts\utils.psm1"

# create a link in home to the docker client config
New-Symlink '~\.docker\config.json' "$PSScriptRoot\config.json"

Remove-Module utils
