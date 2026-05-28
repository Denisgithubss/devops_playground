# Phase 2, Task 2: Kubernetes Security Manifests Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create Kubernetes manifests in `devops_playground/k8s/` including namespace, network policy, and Kyverno security policies.

**Architecture:** Static K8s manifests for a dedicated namespace with strict security enforcement via NetworkPolicy and Kyverno ClusterPolicies.

**Tech Stack:** Kubernetes, Kyverno.

---

### Task 1: Setup Directories and Namespace

**Files:**
- Create: `k8s/namespace.yaml`

- [ ] **Step 1: Create directories**

Run: `mkdir -p k8s/kyverno-policies`

- [ ] **Step 2: Create namespace.yaml**

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: devops-lab
  labels:
    env: lab
    security: strict
```

- [ ] **Step 3: Commit**

```bash
git add k8s/namespace.yaml
git commit -m "feat: add k8s namespace"
```

---

### Task 2: Network Policy

**Files:**
- Create: `k8s/networkpolicy.yaml`

- [ ] **Step 1: Create networkpolicy.yaml**

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny
  namespace: devops-lab
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
```

- [ ] **Step 2: Commit**

```bash
git add k8s/networkpolicy.yaml
git commit -m "feat: add default-deny network policy"
```

---

### Task 3: Kyverno Policies - Pod Security

**Files:**
- Create: `k8s/kyverno-policies/disallow-privileged.yaml`
- Create: `k8s/kyverno-policies/require-non-root.yaml`
- Create: `k8s/kyverno-policies/disallow-latest-tag.yaml`

- [ ] **Step 1: Create disallow-privileged.yaml**

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: disallow-privileged-containers
  annotations:
    policies.kyverno.io/title: Disallow Privileged Containers
    policies.kyverno.io/category: Pod Security Standards (Baseline)
    policies.kyverno.io/severity: medium
    policies.kyverno.io/description: >-
      Privileged mode disables most security mechanisms and must be avoided.
spec:
  validationFailureAction: Enforce
  background: true
  rules:
  - name: privileged-containers
    match:
      any:
      - resources:
          kinds:
          - Pod
    validate:
      message: "Privileged containers are not allowed. Set securityContext.privileged to false."
      pattern:
        spec:
          containers:
          - =(securityContext):
              =(privileged): false
```

- [ ] **Step 2: Create require-non-root.yaml**

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: require-non-root-user
  annotations:
    policies.kyverno.io/title: Require Non-Root User
    policies.kyverno.io/category: Pod Security Standards (Restricted)
    policies.kyverno.io/severity: medium
    policies.kyverno.io/description: >-
      Containers should be required to run as a non-root user.
spec:
  validationFailureAction: Enforce
  background: true
  rules:
  - name: check-run-as-non-root
    match:
      any:
      - resources:
          kinds:
          - Pod
    validate:
      message: "Running as root is not allowed. Set securityContext.runAsNonRoot to true."
      pattern:
        spec:
          =(securityContext):
            runAsNonRoot: true
          containers:
          - =(securityContext):
              runAsNonRoot: true
```

- [ ] **Step 3: Create disallow-latest-tag.yaml**

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: disallow-latest-tag
  annotations:
    policies.kyverno.io/title: Disallow Latest Tag
    policies.kyverno.io/category: Best Practices
    policies.kyverno.io/severity: medium
    policies.kyverno.io/description: >-
      Using the latest tag is discouraged because it does not ensure that the
      running image is the one intended.
spec:
  validationFailureAction: Enforce
  background: true
  rules:
  - name: require-image-tag
    match:
      any:
      - resources:
          kinds:
          - Pod
    validate:
      message: "An image tag is required and must not be 'latest'."
      foreach:
      - list: "request.object.spec.containers"
        deny:
          conditions:
            any:
            - key: "{{ element.image | split(@, ':') | last(@) }}"
              operator: Equals
              value: latest
            - key: "{{ element.image | contains(@, ':') }}"
              operator: Equals
              value: false
```

- [ ] **Step 4: Commit**

```bash
git add k8s/kyverno-policies/
git commit -m "feat: add pod security kyverno policies"
```

---

### Task 4: Kyverno Policies - Resource Management

**Files:**
- Create: `k8s/kyverno-policies/require-resources.yaml`

- [ ] **Step 1: Create require-resources.yaml**

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: require-resources
  annotations:
    policies.kyverno.io/title: Require Resources
    policies.kyverno.io/category: Best Practices
    policies.kyverno.io/severity: medium
    policies.kyverno.io/description: >-
      Resource limits and requests are important for ensuring cluster stability
      and efficient resource usage.
spec:
  validationFailureAction: Enforce
  background: true
  rules:
  - name: check-resource-requests-limits
    match:
      any:
      - resources:
          kinds:
          - Pod
    validate:
      message: "CPU and memory resource requests and limits are required."
      pattern:
        spec:
          containers:
          - resources:
              requests:
                cpu: "?*"
                memory: "?*"
              limits:
                cpu: "?*"
                memory: "?*"
```

- [ ] **Step 2: Verify all YAML files**

Run: `for f in k8s/*.yaml k8s/kyverno-policies/*.yaml; do echo "Checking $f"; yq eval . $f > /dev/null; done`

- [ ] **Step 3: Final Commit**

```bash
git add k8s/
git commit -m "feat: add k8s security manifests"
```
