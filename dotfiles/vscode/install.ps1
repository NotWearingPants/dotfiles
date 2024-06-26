#requires -RunAsAdministrator

Import-Module "$PSScriptRoot\..\..\scripts\utils.psm1"

function Install-VSCodeExtensions {
    $extensionsToInstall = $args[0]

    'About to install {0} extensions...' -f $extensionsToInstall.length

    Start-Process -Wait -NoNewWindow -FilePath 'code' -ArgumentList (@('--force') + (
        $extensionsToInstall | ForEach-Object { '--install-extension', $_ }
    ))

    'Finished installing all extensions.'
}

function Get-VSCodeExtensions {
    $installedExtensions = (code --list-extensions)

    return $installedExtensions
}

# create links in AppData to the settings and keybindings
New-Symlink "$env:APPDATA\Code\User\settings.json" "$PSScriptRoot\settings.json"
New-Symlink "$env:APPDATA\Code\User\keybindings.json" "$PSScriptRoot\keybindings.json"

# create a link in home to the .jsbeautifyrc settings file for the Beautify extension
New-Symlink '~\.jsbeautifyrc' "$PSScriptRoot\_.jsbeautifyrc"

$extensionsToInstall = Load-ListFile "$PSScriptRoot\extensions.txt"

Write-Host 'Extensions installed separately:'
Get-VSCodeExtensions | Where-Object { $extensionsToInstall -notcontains $_ } | ForEach-Object { "`t$_" } | Out-Host

Install-VSCodeExtensions $extensionsToInstall

Remove-Module utils
