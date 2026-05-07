##### STRUCTURE.md - markdown 
> Projet CallShield
### 🛡️ Structure de base
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

### 🛡️ Structure v1.0
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

### 🛡️ Structure v1.1
>Modulaire, scalable.
```text
CallShield/
│
├── core/
│   ├── engine/
│   │   ├── filters/
│   │   ├── rules/
│   │   ├── parser/
│   │   └── README.md
│   ├── utils/
│   ├── security/
│   └── README.md
│
├── platforms/
│   ├── android/
│   │   ├── src/
│   │   ├── manifest/
│   │   └── README.md
│   ├── ios/
│   │   ├── src/
│   │   └── README.md
│   └── web/
│       ├── src/
│       └── README.md
│
├── services/
│   ├── api/
│   │   ├── controllers/
│   │   ├── models/
│   │   ├── routes/
│   │   └── README.md
│   ├── storage/
│   ├── analytics/
│   └── README.md
│
├── clients/
│   ├── cli/
│   │   ├── bin/
│   │   ├── commands/
│   │   └── README.md
│   ├── sdk/
│   └── README.md
│
├── design-system/
│   ├── tokens/
│   │   ├── colors.json
│   │   ├── spacing.json
│   │   ├── typography.json
│   │   └── README.md
│   ├── components/
│   │   ├── buttons/
│   │   ├── cards/
│   │   ├── alerts/
│   │   ├── forms/
│   │   └── README.md
│   ├── layouts/
│   └── README.md
│
├── analytics/
│   ├── collectors/
│   ├── processors/
│   ├── exporters/
│   └── README.md
│
├── config/
│   ├── environments/
│   │   ├── dev.json
│   │   ├── prod.json
│   │   └── test.json
│   ├── schema.json
│   └── README.md
│
├── infra/
│   ├── docker/
│   ├── ci/
│   │   ├── lint.yml
│   │   ├── build.yml
│   │   ├── tests.yml
│   │   └── release.yml
│   ├── scripts/
│   └── README.md
│
├── tests/
│   ├── unit/
│   ├── integration/
│   ├── e2e/
│   └── README.md
│
├── docs/
│   ├── architecture.md
│   ├── security/
│   │   ├── threat-model.md
│   │   ├── data-flow.md
│   │   └── policies.md
│   ├── api/
│   ├── ui/
│   ├── onboarding.md
│   └── README.md
│
├── .github/
│   ├── ISSUE_TEMPLATE/
│   ├── PULL_REQUEST_TEMPLATE.md
│   ├── workflows/
│   └── README.md
│
├── CHANGELOG.md
├── README.md
└── LICENSE
```

> À mettre à jour si nécessaire.
