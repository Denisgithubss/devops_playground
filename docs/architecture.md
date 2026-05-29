# Project Architecture

## High-Level Flow

```mermaid
graph TD
    A[Developer] -->|git push| B[GitHub]
    B --> C[GitHub Actions CI]
    subgraph "CI Pipeline Security Gates"
        C1[Gitleaks - Secrets]
        C2[Trivy - FS/Image]
        C3[Checkov - IaC]
        C4[Pytest - Testing]
    end
    C --> C1 & C2 & C3 & C4
    C1 & C2 & C3 & C4 -->|Pass| D[Docker Build]
    D --> E[Trivy Image Scan]
    E -->|Pass| F[Helm Deployment]
    subgraph "K8s Runtime Protection"
        G[k3s Cluster]
        H[Kyverno - Admission Control]
        I[Falco - Runtime Monitoring]
        J[NetworkPolicy - Zero Trust]
    end
    F --> G
    G --> H & I & J
```

## Component Breakdown

### 1. Application Layer
- **FastAPI**: High-performance Python service.
- **Metrics/Health**: Instrumented with Prometheus-style metrics and deep health checks.

### 2. Infrastructure as Code (IaC)
- **Terraform**: Skeletons for Yandex Cloud (VPC, Instances).
- **Ansible**: Automated k3s installation and node configuration.

### 3. CI/CD & Security Automation
- **GitHub Actions**: Integrated pipeline for continuous verification.
- **Scan Script**: `scripts/scan.sh` provides a local mirror of CI security checks.

### 4. Kubernetes Security & Governance
- **Kyverno**: Enforces "Secure by Default" (no privileged containers, require non-root).
- **Falco**: Detects shell execution in containers or unusual file access at runtime.
- **NetworkPolicy**: Implements micro-segmentation to limit lateral movement.

### 5. Observability
- **Prometheus**: Scrapes application metrics via ServiceMonitor.
- **Grafana**: Visualizes telemetry using the pre-built `monitoring/grafana-dashboard.json`.
