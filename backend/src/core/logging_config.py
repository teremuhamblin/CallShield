import logging
import logging.handlers
import json
from datetime import datetime

class JsonFormatter(logging.Formatter):
    def format(self, record):
        log = {
            "timestamp": datetime.utcnow().isoformat(),
            "level": record.levelname,
            "message": record.getMessage(),
            "logger": record.name
        }
        return json.dumps(log)

def setup_logging():
    handler = logging.handlers.RotatingFileHandler(
        "logs/callshield.log",
        maxBytes=5_000_000,
        backupCount=5
    )
    handler.setFormatter(JsonFormatter())

    logger = logging.getLogger()
    logger.setLevel(logging.INFO)
    logger.addHandler(handler)
