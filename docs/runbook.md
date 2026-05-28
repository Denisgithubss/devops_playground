# Operations Runbook

## Common Issues & Troubleshooting

### 1. Image Pull Backoff
- **Symptoms**: Pods stuck in `ImagePullBackOff`.
- **Action**: Check if the image exists in the registry. Verify `imagePullSecrets` if using a private registry.
- **Cmd**: `kubectl describe pod <pod-name>`

### 2. Terraform State Lock
- **Symptoms**: `Error: Error acquiring the state lock`.
- **Action**: Ensure no other Terraform process is running. Force unlock if necessary (use with caution).
- **Cmd**: `terraform force-unlock <lock-id>`

### 3. Ansible Connection Refused
- **Symptoms**: `fatal: [node1]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh..."}`
- **Action**: Verify SSH keys and Security Group rules in Yandex Cloud.
