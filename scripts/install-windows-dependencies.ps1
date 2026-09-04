$ErrorActionPreference = "Stop"

if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    throw "Chocolatey is required but was not found on PATH."
}

$Packages = @()
if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
    $Packages += "pandoc"
}
if (-not (Get-Command tectonic -ErrorAction SilentlyContinue)) {
    $Packages += "tectonic"
}
$FontPackage = "nerd-fonts-ubuntu"
$ChocolateyRoot = if ($env:ChocolateyInstall) {
    $env:ChocolateyInstall
} else {
    Join-Path $env:ProgramData "chocolatey"
}
if (-not (Test-Path (Join-Path $ChocolateyRoot "lib\$FontPackage"))) {
    $Packages += $FontPackage
}

foreach ($Package in $Packages) {
    Write-Host "Installing missing dependency: $Package"
    & choco install $Package --yes --no-progress
    if ($LASTEXITCODE -notin @(0, 1641, 3010)) {
        throw "Chocolatey failed to install $Package (exit code $LASTEXITCODE)."
    }
}

if ($Packages.Count -gt 0) {
    $MachinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $UserPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $env:Path = "$MachinePath;$UserPath"
}

if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
    throw "Pandoc was installed but is not available on PATH. Open a new PowerShell window and run the script again."
}
if (-not (Get-Command tectonic -ErrorAction SilentlyContinue)) {
    throw "Tectonic was installed but is not available on PATH. Open a new PowerShell window and run the script again."
}

Write-Host "Pandoc, Tectonic, and Ubuntu Nerd Font are available."
