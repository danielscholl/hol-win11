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
# Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.216 -Force
# Set-ExecutionPolicy Bypass -Scope Process -Force; Install-Module -Name Az -AllowClobber -Scope AllUsers -Force
# Invoke-Expression "& { $(Invoke-RestMethod 'https://aka.ms/install-powershell.ps1') } -UseMSI -EnablePSRemoting -Quiet"

# Install Azure CLI for Windows
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'

# Enable WSL
wsl --install -d Ubuntu

# Reboot
Restart-Computer
