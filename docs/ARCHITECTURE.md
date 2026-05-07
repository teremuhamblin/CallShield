##### ARCHITECTURE.md - markdown
>CallShield
- CallShield protège les utilisateurs des appels et SMS frauduleux sur Android, iOS et tablettes.

### Composants principaux
- Application Android
- Application iOS (CallKit)
- Backend propriétaire CallShield
- API CallShield v1.0
- Données : règles, listes, journaux anonymisés

### Objectif
Fournir un filtrage intelligent, local + cloud, avec un minimum de permissions.

# Mise à jour 
# CallShield

## Vision
CallShield protège les utilisateurs contre les appels indésirables via une architecture modulaire et sécurisée.

## Structure
- **Backend (FastAPI)** : API centrale
- **Android** : App mobile native
- **iOS** : App mobile native
- **CI/CD** : Workflows GitHub Actions
- **Sécurité** : CodeQL, ZAP, Dependabot

## Flux
1. App → API `/shield/verify`
2. API → Analyse interne
3. API → Retour statut (safe / risky / blocked)
