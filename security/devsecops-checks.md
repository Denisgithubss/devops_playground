# DevSecOps Scanning Strategy

This project implements a "Shift Left" security approach by integrating security checks directly into the CI/CD pipeline and local development workflow.

## Layers of Defense

1. **Secret Scanning (Gitleaks)**: Scans the repository for accidentally committed secrets (API keys, tokens, etc.) in GitHub Actions and local scans.
2. **Static Application Security Testing (SAST)**: Automated linting and testing in the CI pipeline to catch bugs and potential security flaws early.
3. **Container Image Scanning (Trivy)**: Scans built Docker images for known CVEs. Integrated into GitHub Actions and available via `scripts/scan.sh`.
4. **IaC Scanning (Checkov)**: Scans Terraform and K8s manifests for security misconfigurations (e.g., overly permissive IAM, missing encryption).
5. **K8s Admission Control (Kyverno)**: Enforces policies at the Kubernetes API level, preventing insecure deployments from starting.
6. **Runtime Monitoring (Falco)**: Detects anomalous behavior in running containers, providing a final layer of defense.

## Automation Integration

### Local Scanning (`scripts/scan.sh`)
Developers are encouraged to run the local scan script before pushing:
```bash
./scripts/scan.sh all
```
This script wraps Gitleaks, Trivy (FS scan), and Checkov to provide immediate feedback.

### CI/CD Pipeline (GitHub Actions)
The `.github/workflows/ci.yml` pipeline automates:
- **Lint & Test**: Python code quality and unit tests.
- **Security Scans**: Gitleaks, Checkov, and Trivy FS scans.
- **Build & Scan**: Docker image build followed by a Trivy image scan.

### Quality Gates
- Pipeline is configured to fail on any security violation.
- Checkov uses `.checkov.yml` for configuration and supports inline suppression for documented exceptions.
- Trivy scans fail the build if "HIGH" or "CRITICAL" vulnerabilities are found.
