##### STRUCTURE.md - markdown 
> Projet CallShield 

```text
CallShield/
│
├── README.md
├── LICENSE
│
├── docs/
│   ├── ARCHITECTURE.md
│   ├── STRUCTURE.md
│   ├── SECURITY.md
│   ├── MVP.md
│   ├── ROADMAP.md
│   └── VISION.md
│
├── android/
├── ios/
├── backend/
├── api/
├── data/
├── ui/
├── scripts/
│
└── .github/
    └── workflows/
```

# Mise à jour de la structure v1.0
```text
CallShield/
│
├── README.md
├── LICENSE
├── .gitignore
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md
│   │   ├── feature_request.md
│   │   └── task.md
│   └── workflows/
│       ├── ci.yml
│       └── lint.yml
│
├── docs/
│   ├── VISION.md
│   ├── MVP.md
│   ├── ROADMAP.md
│   ├── ARCHITECTURE.md
│   ├── SECURITY.md
│   ├── STRUCTURE.md
│   ├── UI/
│   │   ├── UI_INDEX.md
│   │   ├── onboarding.md
│   │   ├── dashboard.md
│   │   ├── settings.md
│   │   └── permissions.md
│   └── api/
│       ├── callshield-os.md
│       ├── endpoints.md
│       └── models.md
│
├── android/
│   ├── app/
│   ├── call-filter/
│   ├── sms-filter/
│   └── core/
│
├── ios/
│   ├── CallShield/
│   ├── CallShieldExtension/
│   ├── SMSFilter/
│   └── Shared/
│
├── backend/
│   ├── src/
│   ├── routes/
│   ├── services/
│   ├── models/
│   ├── tests/
│   └── config/
│
├── api/
│   ├── openapi.yaml
│   └── sdk/
│       ├── js/
│       ├── swift/
│       └── kotlin/
│
├── data/
│   ├── spam-numbers.json
│   ├── fraud-patterns.json
│   └── ml/
│       ├── model.bin
│       └── rules.json
│
├── ui/
│   ├── components/
│   ├── screens/
│   ├── assets/
│   └── theme/
│
└── scripts/
    ├── build.sh
    ├── deploy.sh
    └── format.sh
```

> À mettre à jour si nécessaire.
