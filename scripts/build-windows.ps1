$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot
$ResumePath = Join-Path $RepoRoot "resume.md"
$OutputPath = Join-Path $RepoRoot "resume.pdf"

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

if (-not (Test-Path -LiteralPath $ResumePath -PathType Leaf)) {
    throw "Markdown input not found: $ResumePath"
}

if ([string]::IsNullOrWhiteSpace($env:SOURCE_DATE_EPOCH)) {
    $env:SOURCE_DATE_EPOCH = "0"
}
if ([string]::IsNullOrWhiteSpace($env:FORCE_SOURCE_DATE)) {
    $env:FORCE_SOURCE_DATE = "1"
}

Push-Location $RepoRoot
try {
    & pandoc --defaults pandoc.yaml
    if ($LASTEXITCODE -ne 0) {
        throw "Pandoc failed to create the PDF (exit code $LASTEXITCODE)."
    }
} finally {
    Pop-Location
}

Write-Host "Created $OutputPath"
