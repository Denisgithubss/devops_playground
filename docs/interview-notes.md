# Interview Talking Points

## 1. Why GitHub Actions instead of GitLab/Jenkins?
- **Cloud-Native**: Zero infrastructure to manage, integrated directly with the repository.
- **Market Standard**: Extensive ecosystem of pre-built actions for security tools (Trivy, Gitleaks, Checkov).
- **Automation Rigor**: Demonstrated by my CI pipeline which automates 5+ security and quality gates on every push.

## 2. Policy Enforcement Strategy (Kyverno)
- **Problem**: Developers often forget to set resource limits or run as non-root.
- **Solution**: Kyverno enforces these as "Admission Control". If a manifest doesn't comply, K8s rejects the deployment before it even starts.
- **Benefit**: "Guardrails" for developers, ensuring compliance without manual review of every Helm chart.

## 3. Runtime Security (Falco)
- **Concept**: Admission control is for *what* is deployed; Falco is for *what happens* after it starts.
- **Implementation**: I've configured custom Falco rules to alert on suspicious activity, like a shell being opened in a production container or modifications to sensitive system files.

## 4. Shift Left & Developer Experience
- **Approach**: I implemented `scripts/scan.sh` so developers get the *exact same* security feedback on their laptops as they do in CI.
- **Result**: Reduces "CI Friction" – developers fix issues before they even push code, speeding up the development cycle.

## 5. Lessons Learned
- **Security is a Process**: It's not just about tools; it's about the feedback loop between scanning, reporting, and fixing.
- **IaC Drift**: Infrastructure should be purely defined in code. Manual changes in the cloud console are "Technical Debt" that breaks automation.

## 6. Observability & Application Health
- **Concept**: Deploying is not the end; we must monitor the application in production.
- **Implementation**: Instrumented the application to expose Prometheus metrics. Added a ServiceMonitor for auto-discovery and created a Grafana dashboard (`monitoring/grafana-dashboard.json`) to visualize performance and health in real-time.

## 7. Secrets Management (External Secrets Operator)
- **Problem**: Storing static K8s secrets or putting them in Helm values is insecure, risks exposure in source control, and makes rotation difficult.
- **Solution**: We use External Secrets Operator (ESO) to dynamically fetch credentials from a centralized enterprise SecretStore (like HashiCorp Vault or AWS Secrets Manager) and sync them into the cluster.
- **Benefit**: Decouples secret management from application deployment. Developers never see the production secrets, rotation is automated, and the cluster is populated dynamically with `demo-app-db-secret` without exposing raw values in Git.
