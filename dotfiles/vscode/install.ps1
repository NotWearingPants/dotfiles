function Install-VSCodeExtensions {
    $extensions = $args[0]

    "About to install {0} extensions..." -f $extensions.length

    start -Wait -NoNewWindow -FilePath "code" -ArgumentList (@("--force") + (
        $extensions | foreach { "--install-extension", $_ }
    ))

    "Finished installing all extensions."
}

$extensions = sls '^[^#]' $PSScriptRoot\extensions.txt | select -expand line
Install-VSCodeExtensions $extensions
