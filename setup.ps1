# Install Chocolatey
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Assign Chocolatey Packages to Install
$Packages = `
  'git', `
  'visualstudiocode', `
  'docker-desktop', `
  'cascadiacode', `
  'powershell-core'


# Install Packages
ForEach ($PackageName in $Packages)
{ choco install $PackageName -y 
}

# Add User to Docker Group
Add-LocalGroupMember -Group "docker-users" -Member "azureuser"

# Install Azure PowerShell
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.216 -Force
Set-ExecutionPolicy Bypass -Scope Process -Force; Install-Module -Name Az -AllowClobber -Scope AllUsers -Force
Invoke-Expression "& { $(Invoke-RestMethod 'https://aka.ms/install-powershell.ps1') } -UseMSI -EnablePSRemoting -Quiet"

# Install Azure CLI for Windows
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'

# Enable WSL
# Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart

# Download and Install Ubuntu
# Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile ~/Ubuntu.appx -UseBasicParsing
# Add-AppxPackage -Path ~/Ubuntu.appx

# Download Windows Terminal
Invoke-WebRequest hhttps://github.com/microsoft/terminal/releases/download/v1.12.10732.0/Microsoft.WindowsTerminal_Win11_1.12.10733.0_8wekyb3d8bbwe.msixbundle -OutFile ~/Terminal.msixbundle -UseBasicParsing

# Download Cascadia Font
Invoke-WebRequest https://github.com/microsoft/cascadia-code/releases/download/v1911.21/CascadiaPL.ttf -Outfile ~/CascadiaPL.ttf -UseBasicParsing

# Bring down Desktop Shortcuts
$zipDownload = "https://github.com/danielscholl/hol-win11/blob/master/shortcuts.zip?raw=true"
$downloadedFile = "D:\shortcuts.zip"
$vmFolder = "C:\Users\Public\Desktop"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest $zipDownload -OutFile $downloadedFile
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($downloadedFile, $vmFolder)

# Reboot
Restart-Computer
