<#
The installation script
It supports the following arguments: -h, -v, -y
#>

#TODO: Remove
Set-PSDebug -Trace 1

param (
	[switch]$h = $false,
	[switch]$v = $false,
	[switch]$y = $false
)

$HELP_MESSAGE = 
"This script installs the software required and provided by this package.
Command Line Arguments:
	-h - Prints this help menu
	-v - Makes a more verbose output
	-y - Automatically answers 'Y' to all the 'Y/N' questions."

Clear-Host

if ($h) {
	Write-Host $HELP_MESSAGE
	exit
}

if (-not ([Security.Principal.WindowsPrincipal]`
	[Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
	[Security.Principal.WindowsBuiltInRole] "Administrator")) {
	Write-Host "This script requires administrative privileges.
Please run it as admin."
	exit
}

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

#TODO: Install other stuff now