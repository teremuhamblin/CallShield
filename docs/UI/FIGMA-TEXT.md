# Figma Text – CallShield v1.0

## FRAME: App
- Type: Mobile App
- Layout: Vertical, 8px spacing

---

## FRAME: Accueil
- Header: "CallShield"
- Section: StatusCard
  - Text: "Protection active/inactive"
  - Button: "Activer / Désactiver"
- Section: Shortcuts
  - Item: Journal
  - Item: Blocage intelligent
  - Item: Alertes
  - Item: Paramètres

---

## FRAME: Journal
- Header: "Journal"
- List: CallItem (repeated)
  - Icon: status
  - Title: numéro
  - Subtitle: date/heure
- Panel: CallDetails
  - Number
  - Type
  - Actions: Bloquer / Autoriser

---

## FRAME: Blocage intelligent
- Header: "Blocage intelligent"
- Component: LevelSelector
  - Levels: Faible / Moyen / Élevé
- Component: OptionsList
  - Détection IA
  - Listes noires
  - Signaux communautaires
- Button: "Sauvegarder"

---

## FRAME: Alertes
- Header: "Alertes"
- List: AlertItem
  - Type: info / warning / critical
  - Text court
- Panel: AlertDetails
  - Description
  - Action rapide

---

## FRAME: Paramètres
- Header: "Paramètres"
- List: SettingsItem
  - Permissions
  - Règles de blocage
  - Confidentialité
  - À propos
