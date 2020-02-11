#requires -RunAsAdministrator

# create a link in app-data to the `_hyper.js` config file
# TODO: check if it already exists - fail if it exists and isn't our link, but pass if it is
# rm "$env:APPDATA\Hyper\.hyper.js"
New-Item -ItemType SymbolicLink "$env:APPDATA\Hyper\.hyper.js" -Target "$PSScriptRoot\_hyper.js"
