Write-Output "Install choco"
if(Test-Path C:\ProgramData\chocolatey\bin\choco.exe)
{
    choco upgrade chocolatey -y
}
 else
{
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    . $PROFILE
}

Write-Output "Install apps"
choco install powershell-core -y
choco install oh-my-posh -y
choco install git -y
choco install python -y
choco install vscode -y
choco install nodejs-lts -y
choco install googlechrome -y
choco install firefox -y
choco install postman -y

Write-Output "Install Modules"
Install-Module Terminal-Icons -Force

Write-Output "Install fonts"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Meslo/M/Regular/complete/Meslo%20LG%20M%20Regular%20Nerd%20Font%20Complete%20Windows%20Compatible.ttf" -OutFile "Meslo LG M Regular Nerd Font Complete Windows Compatible.ttf"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Meslo/M/Bold/complete/Meslo%20LG%20M%20Bold%20Nerd%20Font%20Complete%20Windows%20Compatible.ttf" -OutFile "Meslo LG M Bold Nerd Font Complete Mono Windows Compatible.ttf"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Meslo/M/Bold-Italic/complete/Meslo%20LG%20M%20Bold%20Italic%20Nerd%20Font%20Complete%20Windows%20Compatible.ttf" -OutFile "Meslo LG M Bold Italic Nerd Font Complete Windows Compatible.ttf"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Meslo/M/Italic/complete/Meslo%20LG%20M%20Italic%20Nerd%20Font%20Complete%20Windows%20Compatible.ttf" -OutFile "Meslo LG M Italic Nerd Font Complete Windows Compatible.ttf"
$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
foreach ($file in Get-ChildItem *.ttf)
{
    $fileName = $file.Name
    if (-not(Test-Path -Path "C:\Windows\fonts\$fileName" )) {
        Write-Output $fileName
        Get-ChildItem $file | Where-Object { $fonts.CopyHere($_.fullname) }
    }
}
Move-Item *.ttf c:\windows\fonts\

Write-Output "Install configs"
Invoke-WebRequest 
if(!Test-Path ~\blueish.omp.json){
    Copy-Item ~\AppData\Local\Programs\oh-my-posh\themes\blueish.omp.json ~
}
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/.../Microsoft.PowerShell_profile.ps1' -OutFile $PROFILE
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/.../settings.json' -OutFile ~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
. $PROFILE
