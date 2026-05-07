#!/usr/bin/env bash
set -euo pipefail

main() {
    echo "[LINT] Analyse du code..."
    npm run lint
}

main "$@"
