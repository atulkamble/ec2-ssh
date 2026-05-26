<powershell>
# userdata.ps1
# EC2 UserData bootstrap script – runs automatically when the Windows instance
# first starts. Installs IIS and deploys a simple website without any manual steps.

# ── 1. Install IIS ────────────────────────────────────────────────────────────
Install-WindowsFeature -Name Web-Server -IncludeManagementTools -IncludeAllSubFeature

# ── 2. Ensure the W3SVC service starts automatically ─────────────────────────
Set-Service -Name W3SVC -StartupType Automatic
Start-Service -Name W3SVC

# ── 3. Remove default IIS placeholder files ───────────────────────────────────
$wwwroot = "C:\inetpub\wwwroot"
@("iisstart.htm", "iisstart.png") | ForEach-Object {
    $p = Join-Path $wwwroot $_
    if (Test-Path $p) { Remove-Item $p -Force }
}

# ── 4. Write the website's index.html ─────────────────────────────────────────
$html = @'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AWS IIS Website</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #232f3e, #ff9900);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }
        .container {
            background: white;
            border-radius: 12px;
            padding: 48px 56px;
            max-width: 720px;
            width: 90%;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            text-align: center;
        }
        h1 { font-size: 2rem; color: #232f3e; margin-bottom: 8px; }
        h2 { font-size: 1.1rem; color: #ff9900; font-weight: 600;
             margin-bottom: 32px; text-transform: uppercase; letter-spacing: 1px; }
        .status { display: inline-block; background: #28a745; color: white;
                  font-size: 0.85rem; padding: 6px 16px; border-radius: 20px;
                  margin-top: 24px; font-weight: 600; }
    </style>
</head>
<body>
    <div class="container">
        <div style="font-size:48px;margin-bottom:16px">&#9729;&#65039;</div>
        <h1>Website Hosted on AWS Windows EC2</h1>
        <h2>Cloud Computing Practical Lab</h2>
        <p style="color:#555;line-height:1.7;">
            This page is served by <strong>IIS (Internet Information Services)</strong>
            running on <strong>Windows Server 2022</strong> in AWS EC2.
        </p>
        <div class="status">&#10003; Server is Live</div>
    </div>
</body>
</html>
'@

Set-Content -Path (Join-Path $wwwroot "index.html") -Value $html -Encoding UTF8

# ── 5. Restart IIS to serve the new content ───────────────────────────────────
iisreset /restart

# ── 6. Write a setup log ──────────────────────────────────────────────────────
$log = "C:\setup-log.txt"
"[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] IIS installed and website deployed." |
    Out-File -FilePath $log -Append -Encoding UTF8
</powershell>
