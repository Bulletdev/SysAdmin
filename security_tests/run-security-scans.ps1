Param(
  [string]$ApiUrl = "http://web:4040"
)

Write-Host "SysAdmin Security Scanner" -ForegroundColor Green
Write-Host "Target: $ApiUrl" -ForegroundColor Yellow

# Ensure report directories exist
New-Item -ItemType Directory -Force -Path "security_tests/reports/semgrep" | Out-Null
New-Item -ItemType Directory -Force -Path "security_tests/reports/trivy"   | Out-Null
New-Item -ItemType Directory -Force -Path "security_tests/reports/nuclei"  | Out-Null
New-Item -ItemType Directory -Force -Path "security_tests/zap/reports"     | Out-Null

Write-Host "[1/4] Semgrep (SAST)" -ForegroundColor Yellow
docker exec sysadmin-semgrep semgrep --config=auto --json --output=/reports/semgrep-report.json /src 2>$null
Write-Host "✓ Semgrep complete" -ForegroundColor Green

Write-Host "[2/4] Trivy (SCA)" -ForegroundColor Yellow
docker exec sysadmin-trivy trivy fs --format json --output /reports/trivy-report.json /app 2>$null
Write-Host "✓ Trivy complete" -ForegroundColor Green

Write-Host "[3/4] Nuclei (DAST)" -ForegroundColor Yellow
docker exec sysadmin-nuclei nuclei -u $ApiUrl -json -o /reports/nuclei-report.json -silent 2>$null
Write-Host "✓ Nuclei complete" -ForegroundColor Green

Write-Host "[4/4] ZAP Baseline (DAST)" -ForegroundColor Yellow
docker exec sysadmin-zap zap-baseline.py -t $ApiUrl -J /zap/reports/zap-report.json -r /zap/reports/zap-report.html 2>$null
Write-Host "✓ ZAP complete" -ForegroundColor Green

Write-Host "Reports saved under security_tests/reports and security_tests/zap/reports" -ForegroundColor Green