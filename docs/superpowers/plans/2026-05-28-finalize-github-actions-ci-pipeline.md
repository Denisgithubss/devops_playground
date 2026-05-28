# Finalize GitHub Actions CI Pipeline Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fully implement `devops_playground/.github/workflows/ci.yml` with the provided functional workflow.

**Architecture:** A comprehensive GitHub Actions CI pipeline with four parallel/dependent jobs for linting/testing, secret scanning, IaC scanning, and container image scanning.

**Tech Stack:** GitHub Actions, Python 3.11, flake8, pytest, Gitleaks, Checkov, Docker, Trivy.

---

### Task 1: Update CI Workflow

**Files:**
- Modify: `.github/workflows/ci.yml`

- [ ] **Step 1: Replace content of `devops_playground/.github/workflows/ci.yml` with the functional workflow**

```yaml
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  lint-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'
      - name: Install dependencies
        run: |
          cd app
          python -m pip install --upgrade pip
          pip install flake8 pytest httpx
          if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
      - name: Lint with flake8
        run: |
          # stop the build if there are Python syntax errors or undefined names
          flake8 app --count --select=E9,F63,F7,F82 --show-source --statistics
      - name: Test with pytest
        run: |
          pytest app/test_app.py

  secret-scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - name: Gitleaks Scan
        uses: gitleaks/gitleaks-action@v2
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

  iac-scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Checkov Scan
        uses: bridgecrewio/checkov-action@master
        with:
          directory: .
          framework: terraform,kubernetes,helm
          quiet: true
          soft_fail: true

  build-scan:
    runs-on: ubuntu-latest
    needs: [lint-test, secret-scan, iac-scan]
    steps:
      - uses: actions/checkout@v4
      - name: Build Image
        run: docker build -t demo-app:${{ github.sha }} app/
      - name: Trivy Image Scan
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: 'demo-app:${{ github.sha }}'
          format: 'table'
          exit-code: '1'
          ignore-unfixed: true
          vuln-type: 'os,library'
          severity: 'CRITICAL,HIGH'
```

- [ ] **Step 2: Commit changes**

Run: `cd devops_playground && git add .github/ && git commit -m "feat: add functional GitHub Actions CI pipeline"`
