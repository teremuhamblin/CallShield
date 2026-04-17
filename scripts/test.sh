#!/usr/bin/env bash
set -euo pipefail

main() {
    echo "[TEST] Exécution des tests..."
    npm test
}

main "$@"
