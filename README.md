# SmartParking 🚗

A Smart Parking Management System built with Django.

## Deployment Status

- ✅ Deployed on EC2: `http://98.80.140.183`
- ✅ CI/CD Pipeline: GitHub Actions + Docker Hub
- ✅ Containerized: Docker + Docker Compose

## Quick Start

### Local Development
```bash
# Clone the repository
git clone https://github.com/tanishq70000-commits/smart-parking.git
cd smart-parking

# Copy environment file
cp .env.example .env

# Run with Docker Compose
docker-compose up -d

# Apply migrations
docker-compose exec web python manage.py migrate

# Access at http://localhost:80
```

### Production Deployment

The application is automatically deployed to EC2 when you push to the `main` branch.

## Features

- Smart parking slot management
- Automated billing system
- PDF receipt generation
- User-friendly interface

## Tech Stack

- **Backend**: Django 4.2.20
- **Web Server**: Nginx + Gunicorn
- **Database**: SQLite (development) / PostgreSQL ready
- **Containerization**: Docker, Docker Compose
- **CI/CD**: GitHub Actions
- **Deployment**: AWS EC2

## Contributing

Push your changes to the `main` branch to trigger automatic deployment.

---

Last Updated: 2025-12-24
