from fastapi import FastAPI
from routers.shield import router as shield_router

app = FastAPI(
    title="CallShield API",
    version="1.0.0",
    description="Backend API for CallShield"
)

app.include_router(shield_router, prefix="/shield", tags=["Shield"])
