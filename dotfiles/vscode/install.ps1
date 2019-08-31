function Install-VSCodeExtensions {
    $extensionsToInstall = $args[0]

    "About to install {0} extensions..." -f $extensionsToInstall.length

    start -Wait -NoNewWindow -FilePath "code" -ArgumentList (@("--force") + (
        $extensionsToInstall | foreach { "--install-extension", $_ }
    ))

    "Finished installing all extensions."
}

function Get-VSCodeExtensions {
    $installedExtensions = (code --list-extensions)

    return $installedExtensions
}


$extensionsToInstall = sls '^[^#]' $PSScriptRoot\extensions.txt | select -expand line

$installedExtensions = Get-VSCodeExtensions
$additionalExtensions = $installedExtensions | where { $extensionsToInstall -notcontains $_ }

"Extensions installed separately:"
$additionalExtensions | foreach { "`t" + $_ }

Install-VSCodeExtensions $extensionsToInstall
