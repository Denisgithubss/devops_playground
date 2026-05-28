# Interview Talking Points

## Why this architecture?
- **FastAPI**: Minimalist and high performance for Python microservices.
- **Helm**: Industry standard for managing complex Kubernetes deployments.
- **Kyverno**: Kubernetes-native policy engine that doesn't require learning Rego (unlike OPA).

## Security First
- Containers run as **non-root** user.
- **ReadOnlyRootFilesystem** is enabled for the app.
- **NetworkPolicies** implement a default-deny ingress/egress.

## Lessons Learned
- Integrating security early (Shift Left) reduces the cost of fixing vulnerabilities.
- IaC (Terraform/Ansible) ensures environment parity between Dev and Prod.
