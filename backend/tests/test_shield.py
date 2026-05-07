from src.services.shield_service import verify_number

def test_verify_number():
    result = verify_number("0600000000")
    assert "status" in result
