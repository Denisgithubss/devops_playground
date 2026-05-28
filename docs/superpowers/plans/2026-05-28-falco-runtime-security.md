# Falco Runtime Security Rules Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a Falco rule example for runtime monitoring to the `devops_playground` lab.

**Architecture:** Create a standalone YAML file with standard Falco rules and update the security strategy documentation to include runtime monitoring.

**Tech Stack:** Falco (YAML), Markdown.

---

### Task 1: Create Falco Rules File

**Files:**
- Create: `security/falco-rules.yaml`

- [ ] **Step 1: Write the Falco rules**

```yaml
- macro: container
  condition: container.id != host

- macro: spawned_process
  condition: evt.type = execve and evt.dir = <

- rule: Shell in Container
  desc: Detect a shell spawned inside a container
  condition: container and spawned_process and proc.name in (bash, sh, zsh)
  output: "Shell spawned in container (user=%user.name container_id=%container.id proc_name=%proc.name)"
  priority: WARNING

- rule: Write to /etc
  desc: Detect any write to /etc
  condition: fd.name startswith /etc and evt.type in (open, openat) and evt.arg.flags contains O_WRONLY
  output: "Write attempt to /etc (user=%user.name command=%proc.cmdline file=%fd.name)"
  priority: WARNING
```

- [ ] **Step 2: Verify file creation**

Run: `ls security/falco-rules.yaml`
Expected: File exists.

---

### Task 2: Update Security Documentation

**Files:**
- Modify: `security/devsecops-checks.md`

- [ ] **Step 1: Append Runtime Security section**

```markdown
6. **Runtime Security Monitoring (Falco)**: Deep visibility into container behavior using system call monitoring to detect anomalous activities like unauthorized shells or file modifications.
```

- [ ] **Step 2: Verify documentation update**

Run: `grep "Falco" security/devsecops-checks.md`
Expected: Line matching the above content.

---

### Task 3: Final Commit

- [ ] **Step 1: Commit all changes**

```bash
git add security/falco-rules.yaml security/devsecops-checks.md
git commit -m "feat: add Falco runtime security rules"
```
