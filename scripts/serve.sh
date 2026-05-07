#!/usr/bin/env bash
set -euo pipefail

main() {
    echo "[SERVE] Démarrage du serveur local..."
    npm run dev
}

main "$@"
