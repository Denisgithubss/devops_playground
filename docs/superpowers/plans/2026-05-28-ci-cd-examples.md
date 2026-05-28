# CI/CD Pipeline Examples Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create example CI/CD pipeline configurations for GitLab and Jenkins in the `devops_playground/ci/` directory.

**Architecture:** Skeleton-based pipelines using `echo` placeholders to demonstrate a standard DevSecOps flow including linting, testing, security scanning, building, and deployment stages.

**Tech Stack:** GitLab CI (YAML), Jenkins (Groovy).

---

### Task 1: Initialize CI Directory

**Files:**
- Create: `devops_playground/ci/.gitkeep`

- [ ] **Step 1: Create the CI directory**

Run: `mkdir -p devops_playground/ci/`

- [ ] **Step 2: Add a .gitkeep file**

Run: `touch devops_playground/ci/.gitkeep`

- [ ] **Step 3: Commit**

```bash
git add devops_playground/ci/.gitkeep
git commit -m "chore: initialize ci directory"
```

---

### Task 2: Create GitLab CI Example

**Files:**
- Create: `devops_playground/ci/gitlab-ci.yml`

- [ ] **Step 1: Write gitlab-ci.yml**

```yaml
stages:
  - lint
  - test
  - secret_scan
  - sast
  - build
  - image_scan
  - helm_lint
  - deploy_manual

variables:
  PYTHON_IMAGE: "python:3.12-slim"
  DOCKER_IMAGE: "docker:latest"

lint:
  stage: lint
  image: $PYTHON_IMAGE
  script:
    - echo "Running flake8 linting..."

test:
  stage: test
  image: $PYTHON_IMAGE
  script:
    - echo "Running pytest..."

secret_scan:
  stage: secret_scan
  script:
    - echo "Running gitleaks or trufflehog..."

sast:
  stage: sast
  script:
    - echo "Running Bandit or Semgrep for static analysis..."

build:
  stage: build
  image: $DOCKER_IMAGE
  script:
    - echo "Building docker image: demo-app:latest"

image_scan:
  stage: image_scan
  script:
    - echo "Running Trivy scan on demo-app:latest..."

helm_lint:
  stage: helm_lint
  image: alpine/helm:latest
  script:
    - echo "Running helm lint on charts/demo-app..."

deploy_manual:
  stage: deploy_manual
  script:
    - echo "Deploying to production environment..."
  when: manual
```

- [ ] **Step 2: Verify file existence**

Run: `ls devops_playground/ci/gitlab-ci.yml`

- [ ] **Step 3: Commit**

```bash
git add devops_playground/ci/gitlab-ci.yml
git commit -m "feat: add gitlab-ci example"
```

---

### Task 3: Create Jenkinsfile Example

**Files:**
- Create: `devops_playground/ci/Jenkinsfile`

- [ ] **Step 1: Write Jenkinsfile**

```groovy
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
            }
        }

        stage('Test') {
            steps {
                echo 'Running unit tests with pytest...'
            }
        }

        stage('Secret Scan') {
            steps {
                echo 'Scanning for secrets with Gitleaks...'
            }
        }

        stage('Build Image') {
            steps {
                echo 'Building Docker image...'
            }
        }

        stage('Trivy Scan') {
            steps {
                echo 'Scanning image for vulnerabilities with Trivy...'
            }
        }

        stage('Helm Lint') {
            steps {
                echo 'Linting Helm charts...'
            }
        }

        stage('Deploy manual placeholder') {
            steps {
                input message: 'Deploy to production?', ok: 'Deploy'
                echo 'Deploying to Kubernetes...'
            }
        }
    }
}
```

- [ ] **Step 2: Verify file existence**

Run: `ls devops_playground/ci/Jenkinsfile`

- [ ] **Step 3: Commit**

```bash
git add devops_playground/ci/Jenkinsfile
git commit -m "feat: add Jenkinsfile example"
```
