from pydantic import BaseSettings

class Settings(BaseSettings):
    app_name: str = "CallShield Backend"

    # Valeur par défaut : développement → debug=True
    debug: bool = True

    # Environnement : "development" ou "production"
    environment: str = "development"

    # Secrets
    api_key: str | None = None
    database_url: str | None = None

    class Config:
        env_file = ".env"

    def apply_environment_overrides(self):
        """
        Active automatiquement debug=False si environment=production.
        """
        if self.environment.lower() == "production":
            self.debug = False


settings = Settings()
settings.apply_environment_overrides()
