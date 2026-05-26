# setup-website.ps1
# Deploys the website files to the IIS wwwroot directory.
# Run this script after install-iis.ps1, in an elevated PowerShell session.

#Requires -RunAsAdministrator

$wwwroot    = "C:\inetpub\wwwroot"
$scriptDir  = Split-Path -Parent $MyInvocation.MyCommand.Path
$siteSource = Join-Path $scriptDir "..\website"

Write-Host "=== Website Setup Script ===" -ForegroundColor Cyan

# ── 1. Verify IIS is installed ────────────────────────────────────────────────
$iis = Get-WindowsFeature -Name Web-Server
if (-not $iis.Installed) {
    Write-Error "IIS is not installed. Run install-iis.ps1 first."
    exit 1
}

# ── 2. Remove default IIS placeholder files ───────────────────────────────────
Write-Host "Cleaning default IIS files from $wwwroot ..." -ForegroundColor Yellow

$defaults = @("iisstart.htm", "iisstart.png")
foreach ($file in $defaults) {
    $path = Join-Path $wwwroot $file
    if (Test-Path $path) {
        Remove-Item $path -Force
        Write-Host "  Removed: $file" -ForegroundColor Gray
    }
}

# ── 3. Copy website files ─────────────────────────────────────────────────────
Write-Host "Copying website files from $siteSource ..." -ForegroundColor Yellow

if (-not (Test-Path $siteSource)) {
    Write-Error "Source folder not found: $siteSource"
    exit 1
}

Copy-Item -Path "$siteSource\*" -Destination $wwwroot -Recurse -Force
Write-Host "Website files copied to $wwwroot" -ForegroundColor Green

# ── 4. Restart IIS to apply changes ───────────────────────────────────────────
Write-Host "Restarting IIS..." -ForegroundColor Yellow
iisreset /restart | Out-Null
Write-Host "IIS restarted." -ForegroundColor Green

# ── 5. Display public IP for quick verification ───────────────────────────────
try {
    $publicIp = (Invoke-RestMethod -Uri "http://checkip.amazonaws.com" -TimeoutSec 5).Trim()
    Write-Host ""
    Write-Host "=== Deployment Complete ===" -ForegroundColor Cyan
    Write-Host "Access your website at: http://$publicIp" -ForegroundColor White
} catch {
    Write-Host ""
    Write-Host "=== Deployment Complete ===" -ForegroundColor Cyan
    Write-Host "Open http://<your-ec2-public-ip> in a browser to verify." -ForegroundColor White
}
