# Design Spec: GitHub Actions CI Pipeline

## Goal
Replace/supplement static CI examples with a functional GitHub Actions workflow in the `devops_playground` directory.

## Architecture
The workflow will be located at `devops_playground/.github/workflows/ci.yml` and will implement a multi-stage DevSecOps pipeline.

### Workflow Configuration
- **Triggers**: `push` and `pull_request` to the `main` branch.
- **Runner**: `ubuntu-latest`.

### Jobs

#### 1. Lint & Test
- **Purpose**: Ensure Python code quality and functional correctness.
- **Tools**: `flake8`, `pytest`.
- **Steps**:
    - Checkout code.
    - Set up Python 3.12.
    - Install dependencies.
    - Run `flake8`.
    - Run `pytest`.

#### 2. Secret Scan
- **Purpose**: Prevent accidental leakage of credentials.
- **Tool**: `gitleaks/gitleaks-action`.
- **Steps**:
    - Checkout code (fetch-depth: 0 for full history).
    - Run Gitleaks action.

#### 3. IaC Scan
- **Purpose**: Identify security misconfigurations in Terraform and Helm.
- **Tool**: `checkov`.
- **Steps**:
    - Checkout code.
    - Run Checkov on `terraform/` and `helm/`.

#### 4. Build & Scan
- **Purpose**: Verify the container build process and scan for image vulnerabilities.
- **Tools**: `docker`, `aquasecurity/trivy-action`.
- **Steps**:
    - Checkout code.
    - Build Docker image `demo-app:latest`.
    - Run Trivy scan on the local image.

## Requirements
- Trigger on `push` and `pull_request` to `main`.
- Use functional tools instead of `echo` placeholders.
- Stop at the image scan step (no deployment).

## Verification
- Valid GitHub Actions YAML syntax.
- All requested stages are present and functional.
- Successful execution in a GitHub environment.
