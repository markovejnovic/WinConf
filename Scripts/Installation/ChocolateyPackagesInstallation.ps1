param(
    [switch]$y = $false
)

$MAXIMUM_NUMBER_OF_PACKAGES = 200
$PATH_TO_PACKAGES_FILE = "$(Split-Path $script:MyInvocation.MyCommand.Path)\..\..\ChocolateyPackages.txt"
$packagesToInstall = Get-Content $PATH_TO_PACKAGES_FILE -TotalCount $MAXIMUM_NUMBER_OF_PACKAGES

<##
 # Installs a chocolatey package.
 #
 # This function checks whether the user agrees to get the package installed by
 # asking for confirmation.
 #>
function Chocolatey-Package-Install {
    if (-not $args[0]) {
        "Chocolatey-Package-Install requires package name as first argument."
    }
    if (-not $y) {
        "We are about to install $($args[0]). Please confirm: (Y/n)."
        $yn = Read-Host
        if ($yn -eq 'Y') {
            choco install ($args[0])
        } else {
            "$($args[0]) not being installed."
        }
    } else {
        choco install $($args[0])
    }
}

<##
 # Removes an element from a powershell array
 #>
function Remove-Commented {
    $newArray = @()

    foreach ($element in $args[0]) {
        if (-not $element.StartsWith(";")) {
            $newArray += $element
        }
    }

    return $newArray
}

$packagesToInstall = Remove-Commented $packagesToInstall

foreach ($package in $packagesToInstall) {
    Chocolatey-Package-Install $package
}