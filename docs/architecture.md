# Project Architecture

## High-Level Flow

```mermaid
graph TD
    A[Developer] -->|git push| B(GitLab/Jenkins)
    B --> C{Security Checks}
    C -->|Pass| D[Docker Build]
    D --> E[Trivy Scan]
    E -->|Pass| F[Helm Deployment]
    F --> G[k3s Cluster]
    G --> H[Kyverno Policies]
```

## Component Breakdown
- **App**: FastAPI based microservice.
- **IaC**: Terraform for cloud provisioning, Ansible for k3s setup.
- **Orchestration**: Helm charts with SecurityContext and resource limits.
