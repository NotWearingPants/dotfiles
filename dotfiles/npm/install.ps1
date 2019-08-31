function Install-NPMPackages {
    $packagesToInstall = $args[0]

    "About to install {0} packages..." -f $packagesToInstall.length

    npm install -g $packagesToInstall

    "Finished installing all packages."    
}

$packagesToInstall = sls '^[^#]' $PSScriptRoot\packages.txt | select -expand line
Install-NPMPackages $packagesToInstall
