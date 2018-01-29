param(
    [switch]$y = $false
)

$MAXIMUM_NUMBER_OF_PACKAGES = 200
$PATH_TO_PACKAGES_FILE = "$(Split-Path $script:MyInvocation.MyCommand.Path)\..\..\CygwinPackages.txt"
$packagesToInstall = Get-Content $PATH_TO_PACKAGES_FILE -TotalCount $MAXIMUM_NUMBER_OF_PACKAGES

<##
 # Installs apt-cyg
 #>
function Apt-Cyg-Install {
	# Add cygwin to the path
	if (-not $Env:Path -contains 'C:\tools\cygwin\bin') {
		"Cygwin is not added to the path environment variable. Adding..."
		Clear-Host
		$AddedLocation = "C:\tools\cygwin\bin\"
		$Reg = "Registry::HKLM\System\CurrentControlSet\Control\Session Manager\Environment"
		$OldPath = (Get-ItemProperty -Path "$Reg" -Name PATH).Path
		$NewPath = $OldPath + ';' + $AddedLocation
		Set-ItemProperty -Path "$Reg" -Name PATH -Value $NewPath
	} else {
		"Cygwin is already in the path environment variable. Not installing."
	}

	"Installing apt-cyg..."
	Invoke-WebRequest -Uri "rawgit.com/transcode-open/apt-cyg/master/apt-cyg" -OutFile "C:\tools\cygwin\bin\apt-cyg.sh"
	chmod +x "C:\tools\cygwin\bin\apt-cyg.sh"
	cp apt-cyg.bat C:\tools\cygwin\bin\apt-cyg.bat
}

<##
 # Installs a cygwin package.
 #
 # This function checks whether the user agrees to get the package installed by
 # asking for confirmation.
 #>
function Cygwin-Package-Install {
    if (-not $args[0]) {
        "Cygwin-Package-Install requires package name as first argument."
    }
    if (-not $y) {
        "We are about to install $($args[0]). Please confirm: (Y/n)."
        $yn = Read-Host
        if ($yn -eq 'Y') {
            apt-cyg install ($args[0])
        } else {
            "$($args[0]) not being installed."
        }
    } else {
        apt-cyg install $($args[0])
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

if (-not $y) {
	"We are about to install apt-cyg. Please confirm: (Y/n)."
	$yn = Read-Host
	if ($yn -eq 'Y') {
		Apt-Cyg-Install
	} else {
		"apt-cyg not being installed."
		exit
	}
} else {
	Apt-Cyg-Install
}

$packagesToInstall = Remove-Commented $packagesToInstall

foreach ($package in $packagesToInstall) {
    Cygwin-Package-Install $package
}