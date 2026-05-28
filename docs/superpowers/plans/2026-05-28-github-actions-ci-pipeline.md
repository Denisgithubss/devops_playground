# GitHub Actions CI Pipeline Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a functional GitHub Actions workflow in `devops_playground/` that implements Lint & Test, Secret Scan, IaC Scan, and Build & Scan stages.

**Architecture:** A multi-job GitHub Actions workflow triggered on push/PR to main. Jobs run on `ubuntu-latest` and use community-standard actions for security tooling.

**Tech Stack:** GitHub Actions, Python (flake8, pytest), Gitleaks, Checkov, Docker, Trivy.

---

### Task 1: Initialize Workflow Directory and File

**Files:**
- Create: `.github/workflows/ci.yml`

- [ ] **Step 1: Create the directory structure**

Run: `mkdir -p .github/workflows`

- [ ] **Step 2: Create the initial workflow file with triggers and basic structure**

```yaml
name: CI Pipeline

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  # Jobs will be added in subsequent tasks
  lint-test:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Initializing CI pipeline"
```

- [ ] **Step 3: Commit**

```bash
git add .github/workflows/ci.yml
git commit -m "feat: initialize GitHub Actions workflow"
```

### Task 2: Implement Lint & Test Job

**Files:**
- Modify: `.github/workflows/ci.yml`

- [ ] **Step 1: Update the `lint-test` job with functional steps**

```yaml
  lint-test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.12'

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install flake8 pytest
          if [ -f app/requirements.txt ]; then pip install -r app/requirements.txt; fi

      - name: Run linting
        run: flake8 app/

      - name: Run tests
        run: pytest app/
```

- [ ] **Step 2: Commit**

```bash
git add .github/workflows/ci.yml
git commit -m "feat: add lint and test job to CI pipeline"
```

### Task 3: Implement Secret Scan Job

**Files:**
- Modify: `.github/workflows/ci.yml`

- [ ] **Step 1: Add the `secret-scan` job**

```yaml
  secret-scan:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Gitleaks Scan
        uses: gitleaks/gitleaks-action@v2
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

- [ ] **Step 2: Commit**

```bash
git add .github/workflows/ci.yml
git commit -m "feat: add secret scan job to CI pipeline"
```

### Task 4: Implement IaC Scan Job

**Files:**
- Modify: `.github/workflows/ci.yml`

- [ ] **Step 1: Add the `iac-scan` job**

```yaml
  iac-scan:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Checkov Scan
        uses: bridgecrewio/checkov-action@master
        with:
          directory: .
          framework: terraform,helm
```

- [ ] **Step 2: Commit**

```bash
git add .github/workflows/ci.yml
git commit -m "feat: add IaC scan job to CI pipeline"
```

### Task 5: Implement Build & Scan Job

**Files:**
- Modify: `.github/workflows/ci.yml`

- [ ] **Step 1: Add the `build-scan` job**

```yaml
  build-scan:
    runs-on: ubuntu-latest
    needs: [lint-test]
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Build Docker image
        run: |
          docker build -t demo-app:latest app/

      - name: Trivy Scan
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: 'demo-app:latest'
          format: 'table'
          exit-code: '1'
          ignore-unfixed: true
          vuln-type: 'os,library'
          severity: 'CRITICAL,HIGH'
```

- [ ] **Step 2: Commit**

```bash
git add .github/workflows/ci.yml
git commit -m "feat: add build and scan job to CI pipeline"
```
