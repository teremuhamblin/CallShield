from fastapi import APIRouter
from services.shield_service import verify_number

router = APIRouter()

@router.get("/verify")
def verify(phone: str):
    return verify_number(phone)
