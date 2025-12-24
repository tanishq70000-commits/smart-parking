# SmartParking - Automated Parking Management System

## 🚀 Live Application
**Access URL**: http://13.233.151.155

## ✅ CI/CD Status
- **GitHub Actions**: Automated deployment on every push to main branch
- **Docker Hub**: satyampr01/smartparking
- **Deployment**: EC2 (Amazon Linux, 13.233.151.155)

## 📋 Features
- Automated parking entry/exit management
- PDF bill generation
- Dashboard for monitoring
- Dockerized deployment

## 🔧 Tech Stack
- **Backend**: Django 4.2.20
- **Server**: Gunicorn + Nginx
- **Database**: SQLite
- **Containerization**: Docker + Docker Compose
- **CI/CD**: GitHub Actions

## 🚀 Deployment
Every push to the `main` branch automatically triggers:
1. Build Docker image
2. Push to Docker Hub
3. Deploy to EC2
4. Run migrations
5. Restart services

## 📊 Monitoring
Check deployment status: https://github.com/satyam-prakash/smartparking/actions

---

**Last Updated**: December 24, 2025
**Status**: ✅ Deployed and Running
