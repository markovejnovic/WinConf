<#
The installation script
It supports the following arguments: -h, -v, -y
#>

param(
	[switch]$h = $false,
	[switch]$v = $false,
	[switch]$y = $false
)

#TODO: Remove
Set-PSDebug -Trace 1

$HELP_MESSAGE = 
"This script installs the software required and provided by this package.
Command Line Arguments:
	-h - Prints this help menu
	-v - Makes a more verbose output
	-y - Automatically answers 'Y' to all the 'Y/N' questions."

if (-not [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")) {
	"Please run this script as an administrator"
	exit
}

Clear-Host

if ($h) {
	Write-Host $HELP_MESSAGE
	exit
}

# Check if Chocolatey is installed
if (-not $(Get-Command "choco" -ErrorAction SilentlyContinue)) {
	if (-not $y) {
		"We are about to install Chocolatey. Please confirm: (Y/n)."
		$yn = Read-Host
		if ($yn -eq 'Y') {
			Set-ExecutionPolicy Bypass -Scope Process -Force
			iex ((New-Object System.Net.WebClient).DownloadString(`
				'https://chocolatey.org/install.ps1'))
		} else {
			"Chocolatey not being installed."
		}
	} else {
		Set-ExecutionPolicy Bypass -Scope Process -Force
		iex ((New-Object System.Net.WebClient).DownloadString(`
			'https://chocolatey.org/install.ps1'))
	}
} else {
	"Chocolatey is installed. Skipping."
}

# Download Chocolatey Packages
. "$(Split-Path $script:MyInvocation.MyCommand.Path)\Scripts\Installation\ChocolateyPackagesInstallation.ps1" $y

#TODO: Install cygwin things
#TODO: Install custom scripts