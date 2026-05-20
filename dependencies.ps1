$ErrorActionPreference = "Continue"

$repoRoot = $PSScriptRoot
Push-Location $repoRoot
try {
    $output = & Rscript "dependencies.R" 2>&1
    $status = $LASTEXITCODE
}
finally {
    Pop-Location
}

$output | ForEach-Object { Write-Host $_ }

if ($output -match "Dependency check passed") {
    exit 0
}

exit $status
