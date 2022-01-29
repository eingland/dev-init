Write-Output "Install choco"
if(Test-Path C:\ProgramData\chocolatey\bin\choco.exe)
{
    choco upgrade chocolatey -y
}
 else
{
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    . $PROFILE
}

Write-Output "Install apps"
choco install packages.config -y

Write-Output "Install nodejs"
$NodeVersion = "17.4.0"
cmd /c "nvm install $NodeVersion --latest-npm"
cmd /c "nvm use $NodeVersion"
cmd /c "npm i -g yarn"

Write-Output "Install configs"
Copy-Item ~\AppData\Local\Programs\oh-my-posh\themes\blueish.omp.json ~
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/eingland/dev-init/main/os/windows/config/Microsoft.PowerShell_profile.ps1' -OutFile $PROFILE
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/eingland/dev-init/main/os/windows/config/settings.json' -OutFile '~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json'
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/eingland/dev-init/main/os/windows/config/.gitconfig' -OutFile ~