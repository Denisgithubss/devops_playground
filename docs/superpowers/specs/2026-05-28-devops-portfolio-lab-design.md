# Design Spec: DevOps/DevSecOps Portfolio Lab

## Goal
Build a minimalist yet comprehensive DevOps/DevSecOps portfolio lab that demonstrates practical skills in automation, orchestration, and security.

## Architecture
Developer -> Git -> CI/CD -> Security Checks (Gitleaks, SAST) -> Container Build -> Image Scan (Trivy) -> Helm Lint -> k3s/Kubernetes Deployment -> Security Policy Enforcement (Kyverno)

## Components

### 1. Demo Application (`app/`)
- **Framework:** FastAPI
- **Endpoints:**
  - `/`: Welcome message
  - `/health`: Liveness probe
  - `/ready`: Readiness probe
  - `/metrics`: Prometheus metrics (basic)
- **Dockerfile:**
  - Base: `python:3.11-slim`
  - User: `appuser` (non-root)
  - Multi-stage build (optional, but keep it simple)

### 2. Infrastructure as Code (`terraform/`, `ansible/`)
- **Terraform:** Yandex Cloud skeleton. VPC, Subnets, Security Groups, VM for k3s.
- **Ansible:** Install k3s on the VM created by Terraform. Basic package management.

### 3. Orchestration (`helm/`, `k8s/`)
- **Helm:** `demo-app` chart.
  - Supports `values-dev.yaml` and `values-prod.yaml`.
  - ConfigMap checksum annotation for automated rollouts.
  - SecurityContext (runAsNonRoot, readOnlyRootFilesystem).
- **K8s Manifests:**
  - Namespace and NetworkPolicies (Default Deny).
  - Kyverno policies: Privileged containers, resource limits, latest tag, non-root.

### 4. CI/CD (`ci/`)
- **GitLab CI:** Multi-stage pipeline with `secret_scan`, `sast`, `image_scan`, and `helm_lint`.
- **Jenkinsfile:** Parallel stages for scanning and building.

### 5. Security (`security/`)
- `gitleaks.toml` configuration.
- `devsecops-checks.md`: Detailed explanation of the scanning strategy.
- `quality-gates.md`: Definition of blocking vs. non-blocking failures.

### 6. Documentation (`docs/`, `README.md`)
- `architecture.md`: Visual flow (Mermaid/Text).
- `runbook.md`: Real-world troubleshooting scenarios.
- `interview-notes.md`: Talking points for recruiters.
- `README.md`: The "landing page" with clear instructions and CLI commands.

## Success Criteria
- All linters/syntax checks pass (Helm, Terraform, Ansible, Python).
- Docker image builds successfully.
- Documentation is clear and actionable.
- Repository structure matches the user's requested layout.
