#requires -RunAsAdministrator

# sublime is installed via scoop, so the data directory is insie scoop's persist folder for sublime
$sublimeDataDirectory = "~\scoop\persist\sublime-text\Data"

# create a link in sublime's data folder to the settings file
# TODO: check if it already exists - fail if it exists and isn't our link, but pass if it is
# rm "$sublimeDataDirectory\Packages\User\Preferences.sublime-settings"
New-Item -ItemType SymbolicLink "$sublimeDataDirectory\Packages\User\Preferences.sublime-settings" -Target "$PSScriptRoot\Preferences.sublime-settings"
