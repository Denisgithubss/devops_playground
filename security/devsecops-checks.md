# DevSecOps Scanning Strategy

This project implements a "Shift Left" security approach by integrating security checks directly into the CI/CD pipeline.

## Layers of Defense

1. **Secret Scanning (Gitleaks)**: Scans the commit history for accidentally committed secrets (AWS keys, tokens, etc.).
2. **Static Application Security Testing (SAST)**: Analyzes the Python code for common vulnerabilities using Semgrep or Bandit.
3. **Container Image Scanning (Trivy)**: Scans the built Docker image for known CVEs in the base OS and application dependencies.
4. **Configuration Scanning (Helm Lint)**: Validates Helm charts for best practices and security misconfigurations.
5. **Infrastructure Scanning (Checkov)**: Scans Terraform manifests for security misconfigurations and compliance with best practices (e.g., Yandex Cloud security rules).
6. **Policy Enforcement (Kyverno)**: Runtime security policies in Kubernetes to ensure containers are running securely (e.g., non-root).

## Infrastructure Scanning Integration

To integrate Checkov into your pipeline:

1.  **Local Development**: Run `checkov -d terraform` before committing to catch issues early.
2.  **CI/CD Pipeline**:
    *   Add a `scan` stage to your pipeline.
    *   Use the `.checkov.yml` file to manage global skips and configurations.
    *   For resource-specific exceptions, use inline comments: `# checkov:skip=CKV_YC_19: Lab environment needs open access`.
3.  **Quality Gates**: Configure the pipeline to fail if high-severity issues are found (set `soft-fail: false` in configuration).
