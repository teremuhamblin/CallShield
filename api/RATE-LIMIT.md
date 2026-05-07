✅ rate-limits.md

`markdown

Rate Limits

Limites d’utilisation de l’API CallShield.

Objectifs
- Protéger l’infrastructure
- Éviter les abus
- Garantir la disponibilité

Règles
- Limite par minute
- Limite par IP
- Limite par token

Réponse en cas de dépassement
```json
{
  "error": "ratelimitexceeded",
  "retry_after": 30
}
```
`

---
