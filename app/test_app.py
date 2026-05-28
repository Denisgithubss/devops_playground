from fastapi.testclient import TestClient
from app.app import app

client = TestClient(app)

def test_read_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Welcome to the DevOps Portfolio Lab"}

def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}

def test_ready():
    response = client.get("/ready")
    assert response.status_code == 200
    assert response.json() == {"status": "ready"}

def test_metrics():
    response = client.get("/metrics")
    assert response.status_code == 200
    # Prometheus metrics usually return plain text
    assert "process_cpu_seconds_total" in response.text
