param(
    [switch]$y = $false
)

<##
 # Installs an autohotkey script.
 #
 # This function checks whether the user agrees to get the script installed by
 # asking for confirmation.
 #>
function AHK-Script-Install {
    if (-not $args[0]) {
        "AHK-Script-Install requires script name as first argument."
    }
    if (-not $y) {
        "We are about to install $($args[0]). Please confirm: (Y/n)."
        $yn = Read-Host
        if ($yn -eq 'Y') {
            cp "$(Split-Path $script:MyInvocation.MyCommand.Path)\..\$($args[0])" "C:\Users\marko\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
        } else {
            "$($args[0]) not being installed."
        }
    } else {
        cp "$(Split-Path $script:MyInvocation.MyCommand.Path)\..\$($args[0])" "C:\Users\marko\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
    }
}

if (Test-Path "C:\Program Files\AutoHotkey\AutoHotkey.exe") {
    AHK-Script-Install EverythingStartup.ahk
} else {
    "AutoHotkey not found. Not installing Autohotkey scripts."
}