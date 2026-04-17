from fastapi import FastAPI, Request
from fastapi.exceptions import RequestValidationError
from core.error_handler import global_exception_handler app.add_exception_handler(Exception, global_exception_handler)
from core.logging_config import setup_logging
setup_logging()
from routers.health import router as health_router
app.include_router(health_router, prefix="/", tags=["Health"])
from prometheus_client import generate_latest
from core.metrics import REQUEST_COUNT, REQUEST_LATENCY, IN_PROGRESS
from routers.shield import router as shield_router
import time

# ------------------------------------------------------------
# Application FastAPI
# ------------------------------------------------------------
app = FastAPI(
    title="CallShield API",
    version="1.0.0",
    description="Backend API for CallShield"
)

# ------------------------------------------------------------
# Middleware Prometheus
# ------------------------------------------------------------
@app.middleware("http")
async def metrics_middleware(request: Request, call_next):
    endpoint = request.url.path
    method = request.method

    REQUEST_COUNT.labels(method=method, endpoint=endpoint).inc()
    IN_PROGRESS.inc()

    start = time.time()
    response = await call_next(request)
    duration = time.time() - start

    REQUEST_LATENCY.labels(endpoint=endpoint).observe(duration)
    IN_PROGRESS.dec()

    return response

# ------------------------------------------------------------
# Endpoint /metrics pour Prometheus
# ------------------------------------------------------------
@app.get("/metrics")
def metrics():
    return generate_latest()

# ------------------------------------------------------------
# Router principal CallShield
# ------------------------------------------------------------
app.include_router(shield_router, prefix="/shield", tags=["Shield"])
