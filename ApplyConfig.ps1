Copy-Item .\Microsoft.PowerShell_profile.ps1 $PROFILE
Copy-Item '.\Windows Terminal\settings.json' "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
Copy-Item ".\.config" "~\.config" -Recurse