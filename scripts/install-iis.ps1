# install-iis.ps1
# Installs IIS (Web Server role) with common features on Windows Server.
# Run this script in an elevated PowerShell session on the EC2 instance.

#Requires -RunAsAdministrator

Write-Host "=== IIS Installation Script ===" -ForegroundColor Cyan
Write-Host "Starting IIS installation..." -ForegroundColor Yellow

# Install Web Server (IIS) role with management tools
Install-WindowsFeature -Name Web-Server `
    -IncludeManagementTools `
    -IncludeAllSubFeature

# Verify the installation
$iis = Get-WindowsFeature -Name Web-Server
if ($iis.Installed) {
    Write-Host "IIS installed successfully." -ForegroundColor Green
} else {
    Write-Error "IIS installation failed. Please check the event log."
    exit 1
}

# Ensure the W3SVC (World Wide Web Publishing Service) is running
$svc = Get-Service -Name W3SVC
if ($svc.Status -ne 'Running') {
    Start-Service -Name W3SVC
    Write-Host "IIS service started." -ForegroundColor Green
} else {
    Write-Host "IIS service is already running." -ForegroundColor Green
}

# Set IIS service to start automatically on boot
Set-Service -Name W3SVC -StartupType Automatic
Write-Host "IIS service set to Automatic startup." -ForegroundColor Green

Write-Host ""
Write-Host "=== Installation Complete ===" -ForegroundColor Cyan
Write-Host "Open http://localhost in a browser to verify the default IIS page." -ForegroundColor White
