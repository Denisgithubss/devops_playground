# DevOps Portfolio Lab Implementation Plan: Phase 3 (Infrastructure, CI/CD, Security & Docs)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement Terraform, Ansible, CI/CD pipelines, security docs, and final documentation.

**Architecture:** Skeleton IaC for Yandex Cloud/k3s, demo CI/CD pipelines, and comprehensive documentation.

**Tech Stack:** Terraform, Ansible, GitLab CI, Jenkins, Markdown.

---

### Task 1: Infrastructure as Code

**Files:**
- Create: `terraform/main.tf`
- Create: `terraform/variables.tf`
- Create: `terraform/outputs.tf`
- Create: `terraform/README.md`
- Create: `ansible/inventory.example.ini`
- Create: `ansible/playbook.yml`

- [ ] **Step 1: Create Terraform Skeleton**

`terraform/main.tf`:
```hcl
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  zone = var.zone
}

resource "yandex_vpc_network" "lab_net" {
  name = "devops-lab-network"
}

resource "yandex_vpc_subnet" "lab_subnet" {
  name           = "devops-lab-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.lab_net.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}
```

- [ ] **Step 2: Create Ansible Playbook**

`ansible/playbook.yml`:
```yaml
- name: Install k3s on lab nodes
  hosts: all
  become: true
  tasks:
    - name: Update apt cache
      apt:
        update_cache: yes
    - name: Install curl
      apt:
        name: curl
        state: present
    - name: Install k3s
      shell: curl -sfL https://get.k3s.io | sh -
      args:
        creates: /usr/local/bin/k3s
```

- [ ] **Step 3: Commit**

```bash
git add terraform/ ansible/
git commit -m "feat: add terraform and ansible skeletons"
```

---

### Task 2: CI/CD Pipelines

**Files:**
- Create: `ci/gitlab-ci.yml`
- Create: `ci/Jenkinsfile`

- [ ] **Step 1: Create GitLab CI Skeleton**

`ci/gitlab-ci.yml`:
```yaml
stages:
  - lint
  - test
  - secret_scan
  - build
  - deploy

lint:
  stage: lint
  script:
    - echo "Linting code..."

secret_scan:
  stage: secret_scan
  script:
    - echo "Running gitleaks..."

build:
  stage: build
  script:
    - echo "Building docker image..."
```

- [ ] **Step 2: Create Jenkinsfile Skeleton**

`ci/Jenkinsfile`:
```groovy
pipeline {
    agent any
    stages {
        stage('Lint') {
            steps {
                echo 'Linting...'
            }
        }
        stage('Build') {
            steps {
                echo 'Building...'
            }
        }
    }
}
```

- [ ] **Step 3: Commit**

```bash
git add ci/
git commit -m "feat: add ci examples"
```

---

### Task 3: Security & Documentation

**Files:**
- Create: `security/gitleaks.toml`
- Create: `security/devsecops-checks.md`
- Create: `security/quality-gates.md`
- Create: `docs/architecture.md`
- Create: `docs/runbook.md`
- Create: `docs/interview-notes.md`
- Create: `README.md` (Update)

- [ ] **Step 1: Create Security Documentation**

`security/quality-gates.md`:
```markdown
# Quality Gates

## Critical (Blocking)
- Gitleaks finds secrets
- Trivy finds HIGH/CRITICAL vulnerabilities in base image
- Kyverno policy violation (Enforce mode)

## Warning (Non-blocking)
- Linting issues (fix in next sprint)
- Trivy finds LOW/MEDIUM vulnerabilities
```

- [ ] **Step 2: Create Architecture and Runbook**

`docs/architecture.md`:
```markdown
# Architecture

Developer -> Git -> CI/CD -> Security Checks -> Build -> Helm -> k3s
```

`docs/runbook.md`:
```markdown
# Runbook

## Pod CrashLoopBackOff
1. Check logs: `kubectl logs <pod>`
2. Check events: `kubectl describe pod <pod>`
```

- [ ] **Step 3: Create Main README.md**
(Comprehensive landing page as requested).

- [ ] **Step 4: Commit and Push**

```bash
git add security/ docs/ README.md
git commit -m "docs: add comprehensive documentation and security guides"
git push origin main
```
