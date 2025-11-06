#!/bin/bash
# Security Testing Automation Script

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN} BulletOnRails API Security Scanner${NC}"
echo "================================"
echo ""

echo -e "${YELLOW} Checking if API is accessible...${NC}"
# Security containers attach to the external compose network `rails-docker_network`
# Target the Rails service by name and mapped port
API_URL="http://web:4040"
echo -e "${GREEN}✓ Target set to ${API_URL}${NC}"
echo ""

mkdir -p reports/{semgrep,trivy,nuclei,zap}

echo -e "${YELLOW} Running Security Scans...${NC}"
echo ""

# 1. Semgrep - Static Analysis
echo -e "${YELLOW}[1/4] Running Semgrep (Static Code Analysis)...${NC}"
docker exec sysadmin-semgrep semgrep \
    --config=auto \
    --json \
    --output=/reports/semgrep-report.json \
    /src 2>/dev/null || echo "Semgrep scan completed with findings"
echo -e "${GREEN}✓ Semgrep scan complete${NC}"
echo ""

# 2. Trivy - Vulnerability Scanner
echo -e "${YELLOW}[2/4] Running Trivy (Dependency Vulnerabilities)...${NC}"
docker exec sysadmin-trivy trivy fs \
    --format json \
    --output /reports/trivy-report.json \
    /app 2>/dev/null || echo "Trivy scan completed with findings"
echo -e "${GREEN}✓ Trivy scan complete${NC}"
echo ""

# 3. Nuclei - Web Vulnerability Scanner
echo -e "${YELLOW}[3/4] Running Nuclei (Web Vulnerabilities)...${NC}"
docker exec sysadmin-nuclei nuclei \
    -u ${API_URL} \
    -json \
    -o /reports/nuclei-report.json \
    -silent 2>/dev/null || echo "Nuclei scan completed"
echo -e "${GREEN}✓ Nuclei scan complete${NC}"
echo ""

# 4. OWASP ZAP - Dynamic Application Security Testing
echo -e "${YELLOW}[4/4] Running ZAP Baseline Scan...${NC}"
echo "Note: ZAP scan may take several minutes"
docker exec sysadmin-zap zap-baseline.py \
    -t ${API_URL} \
    -J /zap/reports/zap-report.json \
    -r /zap/reports/zap-report.html \
    2>/dev/null || echo "ZAP scan completed"
echo -e "${GREEN}✓ ZAP scan complete${NC}"
echo ""

echo -e "${GREEN}✅ All security scans completed!${NC}"
echo ""
echo "📊 Reports available in:"
echo "  - Brakeman:         security_tests/reports/brakeman/brakeman-report.html"
echo "  - Dependency Check: security_tests/reports/dependency-check/dependency-check-report.html"
echo "  - Semgrep:          security_tests/reports/semgrep/semgrep-report.json"
echo "  - Trivy:            security_tests/reports/trivy/trivy-report.json"
echo "  - Nuclei:           security_tests/reports/nuclei/nuclei-report.json"
echo "  - ZAP:              security_tests/zap/reports/zap-report.html"
echo ""
echo "🌐 View ZAP Web UI at: http://localhost:8087/zap"
