from prometheus_client import Counter, Histogram, Gauge

REQUEST_COUNT = Counter(
    "fastapi_requests_total",
    "Total API requests",
    ["method", "endpoint"]
)

REQUEST_LATENCY = Histogram(
    "fastapi_response_duration_seconds",
    "API response latency",
    ["endpoint"]
)

IN_PROGRESS = Gauge(
    "fastapi_requests_in_progress",
    "Requests currently in progress"
)
