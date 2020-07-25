function Install-NPMPackages {
    $packagesToInstall = $args[0]

    'About to install {0} packages...' -f $packagesToInstall.length

    npm install -g $packagesToInstall

    'Finished installing all packages.'    
}

$packagesToInstall = (Select-String '^[^#]' "$PSScriptRoot\packages.txt").Line
Install-NPMPackages $packagesToInstall

# setup eslint
. "$PSScriptRoot\..\eslint\install.ps1"
