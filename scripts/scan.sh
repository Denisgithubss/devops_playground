#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting Local Security Scans...${NC}"

check_tool() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${RED}Warning: $1 is not installed.${NC}"
        return 1
    fi
    echo -e "${GREEN}Detected $1 version: $($1 version 2>/dev/null || $1 --version)${NC}"
    return 0
}

check_tool "gitleaks"
check_tool "trivy"

echo -e "\n${YELLOW}--- Running Gitleaks (Secrets) ---${NC}"
if command -v gitleaks &> /dev/null; then
    gitleaks detect --source . -v
else
    echo -e "${RED}Skipping Gitleaks scan (not installed)${NC}"
fi

echo -e "\n${YELLOW}--- Running Trivy Config (IaC) ---${NC}"
if command -v trivy &> /dev/null; then
    trivy config . --skip-dirs .venv,app/.venv
else
    echo -e "${RED}Skipping Trivy Config scan (not installed)${NC}"
fi

echo -e "\n${YELLOW}--- Running Trivy Image (demo-app:local) ---${NC}"
if command -v trivy &> /dev/null; then
    trivy image demo-app:local
else
    echo -e "${RED}Skipping Trivy Image scan (not installed)${NC}"
fi

echo -e "\n${GREEN}Scan process completed!${NC}"
