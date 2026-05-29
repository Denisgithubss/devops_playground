# Design Spec: Documentation Refresh (2026-05-29)

## Goal
Update the project documentation to reflect recent "Senior DevSecOps" feature additions, including ArgoCD (GitOps), External Secrets Operator (ESO), Infracost (Cost Management), and pre-commit hooks.

## Proposed Changes

### 1. `README.md`
- **Architecture Diagram**: Update Mermaid diagram to show:
    - GitHub Actions CI (lint, test, scan, build).
    - ArgoCD pulling from GitHub and syncing to Kubernetes.
    - ESO fetching secrets from Vault.
- **Project Structure**:
    - Add `argocd/`: GitOps application manifests.
    - Add `security/`: Falco rules, Gitleaks config, etc.
- **Key Features**:
    - **GitOps Deployment**: Mention ArgoCD for automated syncing.
    - **Secret Management**: Mention ESO for fetching secrets from external providers (Vault).
    - **Cost Management**: Mention Infracost in the CI pipeline for cloud cost estimation.
- **Usage**:
    - Add "Pre-commit Hooks" section:
      ```bash
      pip install pre-commit
      pre-commit install
      ```

### 2. `docs/architecture.md`
- **High-Level Flow Diagram**: Update to a more detailed Mermaid diagram showing the CI/CD split and the GitOps loop.
- **Component Breakdown**:
    - Add **GitOps (ArgoCD)**: Automated deployment and drift detection.
    - Add **Secret Management (ESO)**: Decoupling secrets from manifests.
    - Add **Cost Estimation (Infracost)**: "Shift Left" for cloud costs.

### 3. `terraform/README.md`
- Add a note about Infracost being used in CI to estimate costs for Terraform changes.

## Verification Plan
- Render Markdown files locally to ensure Mermaid diagrams are valid.
- Verify all links within the documentation work correctly.
- Ensure no sensitive information is accidentally added to documentation.
