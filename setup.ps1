# Install Chocolatey
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Assign Chocolatey Packages to Install
$Packages = `
  'git', `
  'visualstudiocode', `
  'docker-desktop', `
  'powershell-core', `
  'cascadiacode', `
  'cascadia-code-nerd-font'



# Install Packages
ForEach ($PackageName in $Packages)
{ choco install $PackageName -y
}

# Add User to Docker Group
Add-LocalGroupMember -Group "docker-users" -Member "azureuser"

# Install Azure PowerShell
# Invoke-Expression "& { $(Invoke-RestMethod 'https://aka.ms/install-powershell.ps1') } -UseMSI -EnablePSRemoting -Quiet"
Set-ExecutionPolicy Bypass -Scope Process -Force; Install-Module -Name PackageManagement -RequiredVersion 1.1.0.0
Set-ExecutionPolicy Bypass -Scope Process -Force; Install-Module -Name Az -AllowClobber -Scope AllUsers -Force


# Install Azure CLI for Windows
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'

# Enable WSL
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -OutFile .\wsl_update_x64.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I wsl_update_x64.msi /quiet'
#wsl --install -d Ubuntu

# Reboot
Restart-Computer
