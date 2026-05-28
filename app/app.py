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
