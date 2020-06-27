#requires -RunAsAdministrator

Import-Module "$PSScriptRoot\..\..\scripts\utils.psm1"

# sublime is installed via scoop, so the data directory is insie scoop's persist folder for sublime
$sublimeDataDirectory = "~\scoop\persist\sublime-text\Data"

# create a link in sublime's data folder to the settings file
New-Symlink "$sublimeDataDirectory\Packages\User\Preferences.sublime-settings" "$PSScriptRoot\Preferences.sublime-settings"

# also link the package control settings
New-Symlink "$sublimeDataDirectory\Packages\User\Package Control.sublime-settings" "$PSScriptRoot\Package Control.sublime-settings"

Remove-Module utils
