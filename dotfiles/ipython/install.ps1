#requires -RunAsAdministrator

Import-Module "$PSScriptRoot\..\..\scripts\utils.psm1"

# create a link in the home directory to the `ipython_config.py` config file
New-Symlink '~\.ipython\profile_default\ipython_config.py' "$PSScriptRoot\ipython_config.py"

Remove-Module utils
