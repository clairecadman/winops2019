
#
# Node pre-provision script for the WinOps Demo to install:
# 1. Puppet
# 2. Git
# 3. Chocolatey
# 4. Vscode and extension
# 5. Download Repo
# 6. Setup useful shortcuts for demo

[Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile("https://puppet:8140/packages/current/install.ps1", "$ENV:TEMP/install.ps1")
& "$ENV:TEMP\install.ps1" -PuppetServiceEnsure stopped -PuppetServiceEnable false main:certname=$ENV:ComputerName;

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install vscode and git
#
choco install -f -y vscode
choco install -f -y git
choco install -f -y poshgit

# Registry settings for Server Manager and setting decent terminal resolution 

New-ItemProperty -Path 'Registry::HKCU\Control Panel\Desktop' -Name 'LogPixels' -Value 120 -PropertyType DWORD -Force
New-ItemProperty -Path 'Registry::HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations' -Name 'IgnoreClientDesktopScaleFactor' -PropertyType DWORD -Value 1 -Force
New-Item -Path 'Registry::HKLM\Software\Microsoft\ServerManager' -Force
New-ItemProperty -Path 'Registry::HKLM\Software\Microsoft\ServerManager' -Name 'DoNotOpenServerManagerAtLogon' -PropertyType DWORD -Value 1 -Force

Restart-Computer -Force
