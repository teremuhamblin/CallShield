# CallShield v1.1

CallShield est une plateforme modulaire de filtrage, analyse et sécurisation des communications.

## 🚀 Quickstart

1. cp config/env.example .env
2. docker compose up -d
3. Accéder à l’API : http://localhost:8080
4. Accéder à l’UI : http://localhost:3000

## 📦 Architecture

- services/api : API principale
- services/backend : moteur interne
- services/rules-engine : règles de filtrage
- ui : interface utilisateur
- mobile : clients Android / iOS
- infra : docker, k8s, monitoring
- docs : documentation complète

## 🔐 Sécurité

Voir `/docs/security/`.

## 🛣️ Roadmap

Voir `/docs/roadmap/`.

## 🧪 Tests

pytest-q

## 📄 Licence

MIT – voir LICENSE.md
