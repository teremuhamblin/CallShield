import time
from fastapi import FastAPI, Request
from fastapi.exceptions import RequestValidationError

# Logging
from core.logging_config import setup_logging

# Config
from core.config import settings

# Metrics Prometheus
from prometheus_client import generate_latest
from core.metrics import REQUEST_COUNT, REQUEST_LATENCY, IN_PROGRESS

# Routers
from routers.health import router as health_router
from routers.shield import router as shield_router

# Error handler
from core.error_handler import global_exception_handler


# ------------------------------------------------------------
# Initialisation
# ------------------------------------------------------------
setup_logging()
print(f"Starting CallShield in {settings.environment} mode")

app = FastAPI(
    title="CallShield API",
    version="1.0.0",
    description="Backend API for CallShield"
)

# ------------------------------------------------------------
# Global Error Handler
# ------------------------------------------------------------
app.add_exception_handler(Exception, global_exception_handler)


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
# Routers
# ------------------------------------------------------------
app.include_router(health_router, prefix="/", tags=["Health"])
app.include_router(shield_router, prefix="/shield", tags=["Shield"])
