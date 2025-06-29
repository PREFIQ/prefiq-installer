# Project Architecture

Prefiq follows a modular full-stack architecture:

```

project/
├── apps/
│   └── app\_name/
│       ├── app.py
│       ├── routes/
│       ├── logic/
│       ├── database/
│       └── templates/
├── sites/
│   └── ... (multi-site support)
├── prefentity/
│   ├── manifest.json
│   └── shared logic
├── venv/
├── requirements.txt
└── README.md

```

- `apps/` contains individual modular apps
- `prefentity/` acts as the project core
- `sites/` supports multi-site routing or domain apps
```

---