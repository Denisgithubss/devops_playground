# DevSecOps Scanning Strategy

This project implements a "Shift Left" security approach by integrating security checks directly into the CI/CD pipeline.

## Layers of Defense

1. **Secret Scanning (Gitleaks)**: Scans the commit history for accidentally committed secrets (AWS keys, tokens, etc.).
2. **Static Application Security Testing (SAST)**: Analyzes the Python code for common vulnerabilities using Semgrep or Bandit.
3. **Container Image Scanning (Trivy)**: Scans the built Docker image for known CVEs in the base OS and application dependencies.
4. **Configuration Scanning (Helm Lint)**: Validates Helm charts for best practices and security misconfigurations.
5. **Policy Enforcement (Kyverno)**: Runtime security policies in Kubernetes to ensure containers are running securely (e.g., non-root).
6. **Runtime Security Monitoring (Falco)**: Deep visibility into container behavior using system call monitoring to detect anomalous activities like unauthorized shells or file modifications.
