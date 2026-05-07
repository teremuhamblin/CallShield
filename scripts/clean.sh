#!/usr/bin/env bash
set -euo pipefail

main() {
    echo "[CLEAN] Nettoyage du projet..."
    rm -rf dist .cache node_modules/.cache
    echo "[CLEAN] Terminé."
}

main "$@"
