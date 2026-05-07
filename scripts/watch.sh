#!/usr/bin/env bash
set -euo pipefail

main() {
    echo "[WATCH] Surveillance des fichiers..."
    npm run watch
}

main "$@"
