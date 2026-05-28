# Design Spec: Falco Runtime Security Rules

## 1. Goal
Add a Falco rule example for runtime monitoring to the `devops_playground` lab to demonstrate advanced DevSecOps capabilities.

## 2. Components

### 2.1 Falco Rules File (`security/falco-rules.yaml`)
Create a YAML file containing Falco rules to detect:
- **Shell spawned inside a container**: High priority alert when an interactive shell is started.
- **Write to /etc**: Warning when any process attempts to write to the `/etc` directory.

#### Sample Rule Structure:
```yaml
- rule: Shell in Container
  desc: Detect a shell spawned inside a container
  condition: container.id != host and proc.name in (bash, sh, zsh) and proc.pname = container-entrypoint
  output: "Shell spawned in container (user=%user.name container_id=%container.id proc_name=%proc.name)"
  priority: WARNING
```

### 2.2 Security Documentation (`security/devsecops-checks.md`)
Update the "Layers of Defense" section to include Runtime Security with Falco.

## 3. Implementation Plan
1. Create `devops_playground/security/falco-rules.yaml`.
2. Update `devops_playground/security/devsecops-checks.md`.
3. Verify file contents and paths.
4. Commit changes with the specified message.

## 4. Verification
- Manual inspection of YAML and Markdown files.
- Ensure the rule conditions match Falco's documented syntax requirements for basic detection.
