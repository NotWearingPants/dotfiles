#requires -RunAsAdministrator

Import-Module "$PSScriptRoot\..\..\scripts\utils.psm1"

# create a link in home to the python rc file
New-Symlink '~\.pythonrc.py' "$PSScriptRoot\_.pythonrc.py"

# setup pip
. "$PSScriptRoot\..\pip\install.ps1"

Remove-Module utils
