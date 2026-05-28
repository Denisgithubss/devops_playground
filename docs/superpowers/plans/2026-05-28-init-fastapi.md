# Init FastAPI App Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Initialize the FastAPI demo application with basic endpoints and prometheus metrics, following TDD.

**Architecture:** FastAPI service with health/metrics endpoints.

**Tech Stack:** FastAPI, Uvicorn, Prometheus-client, Pytest, Httpx.

---

### Task 1: Setup Environment and Requirements

**Files:**
- Create: `app/requirements.txt`

- [ ] **Step 1: Create requirements.txt**
```text
fastapi==0.109.0
uvicorn==0.27.0
prometheus-client==0.19.0
```

- [ ] **Step 2: Install dependencies**
Install requested requirements plus testing tools.
Run: `pip install -r app/requirements.txt pytest httpx`

---

### Task 2: Implement Endpoints with TDD

**Files:**
- Create: `app/test_app.py`
- Create: `app/app.py`

- [ ] **Step 1: Write failing test for Root endpoint**
File: `app/test_app.py`
```python
from fastapi.testclient import TestClient
from .app import app

client = TestClient(app)

def test_read_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Welcome to the DevOps Portfolio Lab"}
```

- [ ] **Step 2: Run test and watch it fail**
Run: `pytest app/test_app.py`
Expected: FAIL (ModuleNotFoundError: No module named 'app.app' or similar)

- [ ] **Step 3: Implement minimal Root endpoint**
File: `app/app.py`
```python
from fastapi import FastAPI

app = FastAPI(title="DevOps Portfolio Demo")

@app.get("/")
async def root():
    return {"message": "Welcome to the DevOps Portfolio Lab"}
```

- [ ] **Step 4: Run test and watch it pass**
Run: `pytest app/test_app.py`
Expected: PASS

- [ ] **Step 5: Write failing tests for Health and Ready endpoints**
Update `app/test_app.py`:
```python
def test_read_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}

def test_read_ready():
    response = client.get("/ready")
    assert response.status_code == 200
    assert response.json() == {"status": "ready"}
```

- [ ] **Step 6: Run tests and watch them fail**
Run: `pytest app/test_app.py`
Expected: FAIL (404 Not Found for /health and /ready)

- [ ] **Step 7: Implement Health and Ready endpoints**
Update `app/app.py`:
```python
@app.get("/health")
async def health():
    return {"status": "healthy"}

@app.get("/ready")
async def ready():
    return {"status": "ready"}
```

- [ ] **Step 8: Run tests and watch them pass**
Run: `pytest app/test_app.py`
Expected: PASS

- [ ] **Step 9: Write failing test for Metrics endpoint**
Update `app/test_app.py`:
```python
def test_read_metrics():
    response = client.get("/metrics")
    assert response.status_code == 200
    # Prometheus metrics usually start with # HELP or similar
    assert "# HELP" in response.text
```

- [ ] **Step 10: Run test and watch it fail**
Run: `pytest app/test_app.py`
Expected: FAIL (404 Not Found)

- [ ] **Step 11: Implement Metrics endpoint**
Update `app/app.py`:
```python
from prometheus_client import make_asgi_app
# ...
metrics_app = make_asgi_app()
app.mount("/metrics", metrics_app)
```

- [ ] **Step 12: Run tests and watch them pass**
Run: `pytest app/test_app.py`
Expected: PASS

---

### Task 3: Finalize Project Structure

**Files:**
- Create: `app/.dockerignore`

- [ ] **Step 1: Create .dockerignore**
```text
__pycache__
*.pyc
.venv
.env
.git
```

- [ ] **Step 2: Remove test file before commit (as per usual repo structure unless tests are kept)**
Actually, tests SHOULD be kept in a repo. I'll keep `app/test_app.py`.

- [ ] **Step 3: Commit changes**
Run: `git add app/ && git commit -m "feat: init fastapi app"`
