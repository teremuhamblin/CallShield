✅ webhooks.md

`markdown

Webhooks

Webhooks envoyés par CallShield lors d’événements importants.

Événements
- Appel bloqué
- Appel autorisé
- Mise à jour du profil

Format
`json
{
  "event": "call.blocked",
  "data": {
    "number": "+33123456789",
    "timestamp": "2026-04-17T10:32:00Z"
  }
}
`

Sécurité
- Signature HMAC
- Validation côté client
`

---
