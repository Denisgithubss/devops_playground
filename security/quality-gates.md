# Security Quality Gates

To maintain a high security posture, the following rules are enforced in the CI/CD pipeline:

| Severity | Action | Description |
|----------|--------|-------------|
| **CRITICAL** | **BLOCK** | Build fails immediately. Must be fixed or officially exempted. |
| **HIGH** | **BLOCK** | Build fails. Requires immediate attention. |
| **MEDIUM** | **WARN** | Build passes, but issues are logged in the security report. |
| **LOW** | **IGNORE** | Documented but does not impact build status. |

## Exemption Process
False positives or unfixable vulnerabilities must be documented in `security/exemptions.md` (if applicable) with a clear rationale.
