# DevOps Portfolio Lab Implementation Plan: Phase 1 (Core App & Docker)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a FastAPI demo application and its Dockerfile.

**Architecture:** Minimalist FastAPI service with health/metrics endpoints, containerized using a slim, non-root image.

**Tech Stack:** FastAPI, Uvicorn, Docker, Python 3.11-slim.

---

### Task 1: Initialize Project Structure

**Files:**
- Create: `app/app.py`
- Create: `app/requirements.txt`
- Create: `app/.dockerignore`

- [ ] **Step 1: Create requirements.txt**

```text
fastapi==0.109.0
uvicorn==0.27.0
prometheus-client==0.19.0
```

- [ ] **Step 2: Create FastAPI app**

```python
from fastapi import FastAPI
from prometheus_client import make_asgi_app

app = FastAPI(title="DevOps Portfolio Demo")

# Add prometheus metrics
metrics_app = make_asgi_app()
app.mount("/metrics", metrics_app)

@app.get("/")
async def root():
    return {"message": "Welcome to the DevOps Portfolio Lab"}

@app.get("/health")
async def health():
    return {"status": "healthy"}

@app.get("/ready")
async def ready():
    return {"status": "ready"}
```

- [ ] **Step 3: Create .dockerignore**

```text
__pycache__
*.pyc
.venv
.env
.git
```

- [ ] **Step 4: Commit**

```bash
git add app/
git commit -m "feat: init fastapi app"
```

---

### Task 2: Create Dockerfile

**Files:**
- Create: `app/Dockerfile`

- [ ] **Step 1: Write Dockerfile**

```dockerfile
FROM python:3.11-slim

WORKDIR /app

RUN groupadd -r appuser && useradd -r -g appuser appuser

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN chown -R appuser:appuser /app
USER appuser

EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
```

- [ ] **Step 2: Verify build**

Run: `docker build -t demo-app:local app/`
Expected: Build success.

- [ ] **Step 3: Commit**

```bash
git add app/Dockerfile
git commit -m "feat: add dockerfile"
```
