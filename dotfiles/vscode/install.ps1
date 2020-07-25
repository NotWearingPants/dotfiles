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


$extensionsToInstall = Load-ListFile "$PSScriptRoot\extensions.txt"

$installedExtensions = Get-VSCodeExtensions
$additionalExtensions = $installedExtensions | Where-Object { $extensionsToInstall -notcontains $_ }

'Extensions installed separately:'
$additionalExtensions | ForEach-Object { "`t$_" }

Install-VSCodeExtensions $extensionsToInstall

Remove-Module utils
