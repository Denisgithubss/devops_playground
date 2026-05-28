# Scan Script Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create an automated security scanning script in `scripts/scan.sh`.

**Architecture:** Bash script with tool checks, color-coded output, and three-stage scanning (Gitleaks, Trivy IaC, Trivy Image).

**Tech Stack:** Bash, Gitleaks, Trivy.

---

### Task 1: Setup Directory and Script Skeleton

**Files:**
- Create: `scripts/scan.sh`

- [ ] **Step 1: Create the scripts directory**

Run: `mkdir -p scripts`

- [ ] **Step 2: Create the script with basic header and colors**

```bash
#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting Local Security Scans...${NC}"
```

- [ ] **Step 3: Make it executable**

Run: `chmod +x scripts/scan.sh`

- [ ] **Step 4: Commit**

```bash
git add scripts/scan.sh
git commit -m "feat: init scan script skeleton"
```

### Task 2: Implement Tool Verification

**Files:**
- Modify: `scripts/scan.sh`

- [ ] **Step 1: Add check_tool function**

```bash
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
```

- [ ] **Step 2: Commit**

```bash
git commit -am "feat: add tool verification to scan script"
```

### Task 3: Implement Scan Commands

**Files:**
- Modify: `scripts/scan.sh`

- [ ] **Step 1: Add Gitleaks scan**

```bash
echo -e "\n${YELLOW}--- Running Gitleaks (Secrets) ---${NC}"
if command -v gitleaks &> /dev/null; then
    gitleaks detect --source . -v
else
    echo -e "${RED}Skipping Gitleaks scan (not installed)${NC}"
fi
```

- [ ] **Step 2: Add Trivy IaC scan**

```bash
echo -e "\n${YELLOW}--- Running Trivy Config (IaC) ---${NC}"
if command -v trivy &> /dev/null; then
    trivy config .
else
    echo -e "${RED}Skipping Trivy Config scan (not installed)${NC}"
fi
```

- [ ] **Step 3: Add Trivy Image scan**

```bash
echo -e "\n${YELLOW}--- Running Trivy Image (demo-app:local) ---${NC}"
if command -v trivy &> /dev/null; then
    trivy image demo-app:local
else
    echo -e "${RED}Skipping Trivy Image scan (not installed)${NC}"
fi
```

- [ ] **Step 4: Commit**

```bash
git commit -am "feat: add scan commands to script"
```

### Task 4: Finalize and Test

**Files:**
- Modify: `scripts/scan.sh`

- [ ] **Step 1: Add success message**

```bash
echo -e "\n${GREEN}Scan process completed!${NC}"
```

- [ ] **Step 2: Run the script to verify output**

Run: `./scripts/scan.sh`

- [ ] **Step 3: Final Commit**

```bash
git add scripts/
git commit -m "feat: add local security scanning script"
```
