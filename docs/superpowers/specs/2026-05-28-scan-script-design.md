# Automated Security Scanning Script Design

**Topic:** Local Security Checks for DevSecOps Workflow
**Date:** 2026-05-28

## Purpose
Provide a single command for developers to run local security scans before pushing code. This "shifts left" security by catching secrets, IaC misconfigurations, and container vulnerabilities early.

## Design
### Tools
- **Gitleaks:** For secret detection in the repository.
- **Trivy:** For IaC (Infrastructure as Code) and Container Image scanning.

### Scan Stages
1. **Prerequisites Check:** Verify tools are installed.
2. **Secret Scan:** Run `gitleaks` on the current directory.
3. **IaC Scan:** Run `trivy` on configuration files (Terraform, K8s, Dockerfile).
4. **Image Scan:** Run `trivy` on the `demo-app:local` Docker image.

### Output
- Color-coded log levels (INFO, WARN, SUCCESS).
- Summary of findings.

## Success Criteria
- Script is executable.
- Script warns if tools are missing.
- Script executes all three scan types.
