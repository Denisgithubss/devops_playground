# Operations Runbook

## Common Issues & Troubleshooting

### 1. CI Pipeline Failures (Security Gates)
- **Symptoms**: GitHub Actions workflow fails at `Gitleaks`, `Trivy`, or `Checkov`.
- **Action**: Check the workflow logs.
    - **Gitleaks**: A secret was likely committed. **DO NOT** just delete the line; you must rotate the secret and potentially rewrite git history.
    - **Trivy**: A vulnerability was found in a dependency or Docker base image. Update the `requirements.txt` or `Dockerfile` base image.
    - **Checkov**: IaC misconfiguration. Update Terraform manifests to comply with security policies.

### 2. Kyverno Policy Rejection
- **Symptoms**: `kubectl apply` or Helm install fails with: `admission webhook "validate.kyverno.svc-fail" denied the request`.
- **Action**: The manifest violates a security policy (e.g., no resource limits).
- **Fix**: Update the Helm `values.yaml` or K8s manifest to include the required security context or resource requests/limits.
- **Cmd**: `kubectl get clusterpolicy` to see active rules.

### 3. Falco Runtime Alerts
- **Symptoms**: Suspicious activity detected (check Falco logs or configured alert sink).
- **Action**: Investigate the pod. If a shell was opened (`Notice A shell was spawned in a container`), determine if it was an authorized admin action or a potential breach.
- **Cmd**: `kubectl logs -n falco <falco-pod-name>`

### 4. Image Pull Backoff
- **Symptoms**: Pods stuck in `ImagePullBackOff`.
- **Action**: Check if the image exists in the registry.
- **Cmd**: `kubectl describe pod <pod-name>`

### 5. Terraform State Lock
- **Symptoms**: `Error: Error acquiring the state lock`.
- **Action**: Ensure no other Terraform process is running. Force unlock if necessary (use with caution).
- **Cmd**: `terraform force-unlock <lock-id>`
