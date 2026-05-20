$ErrorActionPreference = "Continue"

$repoRoot = Split-Path -Parent $PSScriptRoot
$pdfPath = Join-Path $repoRoot "output\agent-book-public.pdf"
$htmlPath = Join-Path $repoRoot "output\index.html"

Push-Location $repoRoot
try {
    & Rscript "book/render_book.R"
    $status = $LASTEXITCODE
}
finally {
    Pop-Location
}

if (Test-Path $pdfPath) {
    Write-Host "PDF: $pdfPath"
    exit 0
}

if (Test-Path $htmlPath) {
    Write-Host "HTML: $htmlPath"
    exit 0
}

exit $status
