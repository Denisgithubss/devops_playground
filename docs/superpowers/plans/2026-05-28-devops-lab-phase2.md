# DevOps Portfolio Lab Implementation Plan: Phase 2 (Helm & K8s)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a Helm chart and Kubernetes manifests with security policies.

**Architecture:** Helm chart for the demo app, Kyverno policies for enforcement, and NetworkPolicies for isolation.

**Tech Stack:** Helm 3, Kubernetes, Kyverno.

---

### Task 1: Create Helm Chart

**Files:**
- Create: `helm/demo-app/Chart.yaml`
- Create: `helm/demo-app/values.yaml`
- Create: `helm/demo-app/templates/deployment.yaml`
- Create: `helm/demo-app/templates/service.yaml`
- Create: `helm/demo-app/templates/configmap.yaml`
- Create: `helm/demo-app/templates/ingress.yaml`

- [ ] **Step 1: Create Chart.yaml**

```yaml
apiVersion: v2
name: demo-app
description: A Helm chart for the DevOps Portfolio Demo App
version: 0.1.0
appVersion: "1.0.0"
```

- [ ] **Step 2: Create values.yaml**

```yaml
replicaCount: 1
image:
  repository: demo-app
  pullPolicy: IfNotPresent
  tag: "latest"
service:
  type: ClusterIP
  port: 80
ingress:
  enabled: false
resources:
  limits:
    cpu: 100m
    memory: 128Mi
  requests:
    cpu: 50m
    memory: 64Mi
securityContext:
  runAsNonRoot: true
  runAsUser: 1000
config:
  welcomeMessage: "Hello from Helm!"
```

- [ ] **Step 3: Create deployment.yaml**

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "demo-app.fullname" . }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ include "demo-app.name" . }}
  template:
    metadata:
      annotations:
        checksum/config: {{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}
      labels:
        app: {{ include "demo-app.name" . }}
    spec:
      securityContext:
        {{- toYaml .Values.podSecurityContext | nindent 8 }}
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          ports:
            - name: http
              containerPort: 8000
              protocol: TCP
          livenessProbe:
            httpGet:
              path: /health
              port: http
          readinessProbe:
            httpGet:
              path: /ready
              port: http
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
```

- [ ] **Step 4: Create service.yaml and configmap.yaml**

`helm/demo-app/templates/service.yaml`:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ include "demo-app.fullname" . }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: http
      protocol: TCP
      name: http
  selector:
    app: {{ include "demo-app.name" . }}
```

`helm/demo-app/templates/configmap.yaml`:
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "demo-app.fullname" . }}
data:
  welcome.message: {{ .Values.config.welcomeMessage | quote }}
```

- [ ] **Step 5: Lint Helm Chart**

Run: `helm lint helm/demo-app`
Expected: 0 chart(s) linted, 0 chart(s) failed.

- [ ] **Step 6: Commit**

```bash
git add helm/
git commit -m "feat: add helm chart"
```

---

### Task 2: Kubernetes Security Manifests

**Files:**
- Create: `k8s/namespace.yaml`
- Create: `k8s/networkpolicy.yaml`
- Create: `k8s/kyverno-policies/disallow-privileged.yaml`
- Create: `k8s/kyverno-policies/require-resources.yaml`

- [ ] **Step 1: Create Namespace and NetPol**

`k8s/namespace.yaml`:
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: devops-lab
```

`k8s/networkpolicy.yaml`:
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

- [ ] **Step 2: Create Kyverno Policies**

`k8s/kyverno-policies/disallow-privileged.yaml`:
```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: disallow-privileged-containers
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
      message: "Privileged containers are not allowed."
      pattern:
        spec:
          containers:
          - securityContext:
              privileged: false
```

- [ ] **Step 3: Commit**

```bash
git add k8s/
git commit -m "feat: add k8s manifests and kyverno policies"
```
