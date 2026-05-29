# Project Architecture

## High-Level Flow

```mermaid
graph TD
    A[Developer] -->|git push| B[GitHub]
    B --> C[GitHub Actions CI]
    subgraph "CI Security Gates"
        C1[Gitleaks]
        C2[Trivy FS]
        C3[Checkov IaC]
        C4[Pytest]
        C5[Infracost]
    end
    C --> C1 & C2 & C3 & C4 & C5
    C1 & C2 & C3 & C4 & C5 -->|Pass| D[Docker Build]
    D --> E[Trivy Image Scan]
    E -->|Pass| F[Update Manifests]
    F -->|Sync| G[ArgoCD]
    subgraph "K8s Production"
        G --> H[Deployment]
        H --> I[External Secrets]
        I --> J[Vault]
        H --> K[Kyverno/Falco]
        H --> L[Prometheus/Grafana]
    end
```

## Component Breakdown

### 1. Application Layer
- **FastAPI**: High-performance Python service.
- **Metrics/Health**: Instrumented with Prometheus-style metrics and deep health checks.

### 2. Infrastructure as Code (IaC)
- **Terraform**: Skeletons for Yandex Cloud (VPC, Instances).
- **Ansible**: Automated k3s installation and node configuration.
- **Cost Estimation (Infracost)**: Integrated into CI to provide visibility into infrastructure cost changes.

### 3. CI/CD & Security Automation
- **GitHub Actions**: Integrated pipeline for continuous verification.
- **Scan Script**: `scripts/scan.sh` provides a local mirror of CI security checks.
- **GitOps (ArgoCD)**: Implements continuous delivery by syncing Helm charts from `helm/` to the cluster.

### 4. Kubernetes Security & Governance
- **Kyverno**: Enforces "Secure by Default" (no privileged containers, require non-root).
- **Falco**: Detects shell execution in containers or unusual file access at runtime.
- **NetworkPolicy**: Implements micro-segmentation to limit lateral movement.
- **Secret Management (ESO)**: Decouples secrets from application manifests, fetching them at runtime from a secure backend (Vault).

### 5. Observability
- **Prometheus**: Scrapes application metrics via ServiceMonitor.
- **Grafana**: Visualizes telemetry using the pre-built `monitoring/grafana-dashboard.json`.
