winget install Microsoft.PowerShell.Preview
winget install Microsoft.WindowsTerminal.Preview
winget install Starship.Starship
winget install Microsoft.VisualStudioCode
winget install gerardog.gsudo
winget install OpenJS.NodeJS
winget install sysinternals

mkdir $HOME\Codes

#ffmpeg
{
    $ffmpeg_latest_build_url = 'https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl-shared.zip'
    Invoke-WebRequest $ffmpeg_latest_build_url -OutFile 'ffmpeg.zip'
    Expand-Archive 'ffmpeg.zip' -DestinationPath "$HOME\Codes"
    Remove-Item 'ffmpeg.zip'
}

git clone https://github.com/microsoft/vcpkg $HOME\Codes\vcpkg
. $HOME\Codes\vcpkg\bootstrap-vcpkg.bat
vcpkg integrate powershell

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
Invoke-RestMethod get.scoop.sh | Invoke-Expression
scoop install aria2
scoop install ripgrep
scoop bucket add nerd-fonts
scoop install firacode
scoop install FiraCode-NF
scoop install FiraCode-NF-Mono
scoop install LXGWWenKai
scoop install LXGWWenKaiMono
scoop install LXGWWenKaiScreen
Write-Output "Please check Font Settings. If new fonts are missing, try to install (one of) them manually to refresh the cache"

# TODO: install Source Han Serif font
# font for Telegram Desktop
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontSubstitutes" -Name "DAOpenSansRegular" -Value "Source Han Serif SC VF"  -PropertyType "String"

$ConfigFilePath = (Get-Location).Path
$PROFILE_VSCODE = ($PROFILE -replace '(.*)PowerShell(_profile.ps1)','$1VSCode$2')

Move-Item $PROFILE pwsh_profile_backup.ps1
New-Item -Force -ItemType HardLink -Path $PROFILE -Value "$ConfigFilePath\Microsoft.PowerShell_profile.ps1"
New-Item -Force -ItemType HardLink -Path $PROFILE_VSCODE -Value $PROFILE


$TerminalPreviewSettingPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"
Move-Item $TerminalPreviewSettingPath windows_terminal_prevew_backup.ps1
New-Item -Force -ItemType HardLink -Path $TerminalPreviewSettingPath -Value "$ConfigFilePath\Windows Terminal Preview\settings.json"
#Copy-Item '.\Windows Terminal\settings.json' "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

New-Item -ItemType HardLink -Path "$HOME\.config\starship.toml" -Value "$ConfigFilePath\.config\starship.toml"