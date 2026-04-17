from pydantic import BaseSettings

class Settings(BaseSettings):
    app_name: str = "CallShield Backend"
    debug: bool = True

settings = Settings()
