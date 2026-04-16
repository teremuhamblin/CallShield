# Guide UX – CallShield v1.0

## Principes

- Clarté: l’utilisateur comprend toujours l’état de sa protection.
- Contrôle: l’utilisateur peut facilement bloquer/autoriser.
- Sérénité: ton calme, pas anxiogène.

## Heuristiques clés

- Visibilité de l’état du système:
  - Statut de protection toujours visible sur l’accueil.
- Feedback immédiat:
  - Après un blocage/autorisation, confirmation claire.
- Prévention des erreurs:
  - Confirmation avant actions destructrices (ex: vider un journal).

## Patterns recommandés

- Écran d’accueil = hub:
  - Statut + raccourcis vers les zones critiques.
- Détails d’appel:
  - Contexte minimal mais suffisant (numéro, type, action).
- Paramètres:
  - Regroupés par logique: Permissions / Blocage / Confidentialité.

## Anti-patterns à éviter

- Surcharger l’accueil d’options avancées.
- Multiplier les confirmations inutiles.
- Utiliser des termes techniques non expliqués.

## Microcopy

- Préférer:
  - “Protection active” plutôt que “Module de filtrage opérationnel”.
  - “Bloquer ce numéro” plutôt que “Ajouter à la liste de rejet”.
- Toujours expliquer les conséquences:
  - “Les appels de ce numéro seront automatiquement bloqués.”

## Flots critiques à soigner

- Première activation:
  - Guidage simple: Autoriser permissions → Activer protection.
- Premier appel bloqué:
  - Explication courte: pourquoi bloqué, comment changer la règle.
- Gestion des faux positifs:
  - Raccourci “Toujours autoriser ce numéro”.
