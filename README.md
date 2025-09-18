# Symfony Docker Template

Minimal yet powerful boilerplate for Symfony applications, built with Docker and ready for modular scaling.

---

## 🚀 Features

* Symfony + PHP-FPM (8.3) on Alpine
* Nginx as reverse proxy
* Multi-stage Docker build (optimized production image)
* Composer installed only in build stage
* Easy development & production setup via Docker Compose

---

## 💡 Stack

| Component      | Version / Image        |
| -------------- | ---------------------- |
| PHP            | php:8.3-fpm-alpine     |
| Nginx          | nginx:1.27-alpine      |
| Symfony        | Installed via Composer |
| Docker         | 20.10+                 |
| Docker Compose | v2+                    |

---

## 🛠️ Requirements

* Docker
* Docker Compose
* (optional) GNU Make

---

## 🧪 Getting Started

```bash
# Clone the repo
git clone https://github.com/your-name/symfony-docker-template.git
cd symfony-docker-template

# Build and start (dev mode)
docker compose up --build -d

# Visit your app:
http://localhost:8080
```

---

## 📁 Structure

```
.
├── app/                  # Symfony app
├── docker/
│   ├── php/              # PHP Dockerfile
│   └── nginx/            # Nginx config
├── .dockerignore
├── .gitignore
├── docker-compose.yml
└── README.md
```

---

## 🌐 Exposed Ports

| Port | Description        |
| ---- | ------------------ |
| 8080 | Web access (Nginx) |
| 9000 | PHP-FPM internal   |

---

## 📦 Planned Modules (via docker-compose -f option)

* PostgreSQL
* Redis
* Mailhog
* Grafana + Loki (logging & monitoring)
* Xdebug (on-demand)
* GitHub Actions (CI/CD)

---

## 🤝 Contributing

This repo is built to be educational and production-ready.
Feel free to fork, open issues, or suggest improvements via PRs.

---

##
