# SmartParking CI/CD Deployment Guide

## 🚀 Complete Setup for GitHub Actions + Docker + EC2

### Architecture Overview
- **GitHub Actions**: Automated CI/CD pipeline
- **Docker**: Containerized application
- **EC2**: AWS hosting
- **Nginx**: Reverse proxy for production

---

## 📋 Prerequisites

1. **AWS EC2 Instance**
   - Ubuntu 20.04 or 22.04 LTS
   - At least t2.micro (1GB RAM)
   - Security Group: Allow ports 22, 80, 443

2. **GitHub Repository**
   - Push your code to GitHub
   - Enable Actions in repository settings

3. **Local Requirements**
   - Git installed
   - AWS Account

---

## 🔧 Step-by-Step Setup

### Step 1: Initial EC2 Setup

1. **Connect to your EC2 instance:**
```bash
ssh -i your-key.pem ubuntu@your-ec2-ip
```

2. **Run the deployment script:**
```bash
# Copy deploy.sh to EC2 and run:
chmod +x deploy.sh
./deploy.sh
```

Or manually install:
```bash
# Update system
sudo apt-get update && sudo apt-get upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Git
sudo apt-get install -y git

# Logout and login again for docker group to take effect
exit
```

### Step 2: Clone Repository on EC2

```bash
# SSH back to EC2
ssh -i your-key.pem ubuntu@your-ec2-ip

# Clone your repository
cd ~
git clone https://github.com/YOUR-USERNAME/SmartParking.git
cd SmartParking
```

### Step 3: Configure Environment

1. **Create .env file on EC2:**
```bash
cp .env.example .env
nano .env
```

2. **Update .env with your settings:**
```env
SECRET_KEY=your-generated-secret-key-here
DEBUG=False
ALLOWED_HOSTS=your-ec2-ip,your-domain.com
```

Generate a secret key:
```bash
python3 -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
```

### Step 4: Test Docker Deployment

```bash
# Build and run containers
docker-compose up -d --build

# Check if containers are running
docker-compose ps

# View logs
docker-compose logs -f

# Run migrations
docker-compose exec web python manage.py migrate

# Create superuser
docker-compose exec web python manage.py createsuperuser

# Test the application
curl http://localhost:80
```

### Step 5: Configure GitHub Secrets

Go to your GitHub repository: **Settings → Secrets and variables → Actions**

Add these secrets:

1. **EC2_HOST**: Your EC2 public IP or domain
2. **EC2_USERNAME**: `ubuntu` (or `ec2-user` for Amazon Linux)
3. **EC2_SSH_KEY**: Your private SSH key content
   ```bash
   # On your local machine, copy the key:
   cat your-key.pem
   # Copy the entire content including BEGIN and END lines
   ```
4. **DOCKER_USERNAME** (Optional): DockerHub username
5. **DOCKER_PASSWORD** (Optional): DockerHub password/token

### Step 6: Push to GitHub

```bash
# On your local machine
git add .
git commit -m "Add CI/CD configuration"
git push origin main
```

The GitHub Action will automatically deploy to EC2!

---

## 🔄 How It Works

1. **Push to main branch** → Triggers GitHub Actions
2. **GitHub Actions** → SSH into EC2
3. **EC2** → Pulls latest code
4. **Docker** → Rebuilds containers
5. **Application** → Automatically restarted

---

## 📱 Access Your Application

- **HTTP**: `http://your-ec2-ip`
- **Admin**: `http://your-ec2-ip/admin`

---

## 🛠️ Common Commands

### On EC2:

```bash
# View running containers
docker-compose ps

# View logs
docker-compose logs -f web
docker-compose logs -f nginx

# Restart containers
docker-compose restart

# Stop containers
docker-compose down

# Rebuild and restart
docker-compose up -d --build

# Run Django commands
docker-compose exec web python manage.py migrate
docker-compose exec web python manage.py createsuperuser
docker-compose exec web python manage.py collectstatic

# Access Django shell
docker-compose exec web python manage.py shell

# Database backup
docker-compose exec web python manage.py dumpdata > backup.json
```

### Local Development:

```bash
# Run without Docker
python manage.py runserver

# Run with Docker
docker-compose up
```

---

## 🔐 Security Checklist

- [ ] Change SECRET_KEY in .env
- [ ] Set DEBUG=False in production
- [ ] Add your domain/IP to ALLOWED_HOSTS
- [ ] Use strong passwords
- [ ] Enable HTTPS (use Let's Encrypt)
- [ ] Configure EC2 Security Groups properly
- [ ] Regular backups of database
- [ ] Keep Docker images updated

---

## 🚨 Troubleshooting

### Container won't start:
```bash
docker-compose logs web
docker-compose down && docker-compose up --build
```

### Permission denied:
```bash
sudo chown -R $USER:$USER .
```

### Port already in use:
```bash
sudo lsof -i :80
sudo kill -9 PID
```

### GitHub Actions failing:
- Check EC2_SSH_KEY secret is correct (include full key with headers)
- Verify EC2 security group allows SSH from GitHub IPs
- Check EC2_HOST and EC2_USERNAME are correct

### Database errors:
```bash
# Reset database
docker-compose exec web python manage.py flush
docker-compose exec web python manage.py migrate
```

---

## 🌐 Optional: Setup Domain & HTTPS

1. **Point domain to EC2 IP** (in your DNS settings)

2. **Install Certbot in nginx container:**
```bash
docker-compose exec nginx sh
apk add certbot certbot-nginx
certbot --nginx -d yourdomain.com
```

3. **Update nginx.conf** for SSL

---

## 📊 Monitoring

```bash
# System resources
docker stats

# Disk usage
docker system df
docker system prune -a  # Clean up

# Application logs
docker-compose logs --tail=100 -f
```

---

## 🔄 Rollback

If deployment fails:
```bash
cd ~/SmartParking
git log  # Find previous commit
git checkout COMMIT_HASH
docker-compose up -d --build
```

---

## 📚 Additional Resources

- [Django Deployment Checklist](https://docs.djangoproject.com/en/4.2/howto/deployment/checklist/)
- [Docker Compose Docs](https://docs.docker.com/compose/)
- [GitHub Actions Docs](https://docs.github.com/en/actions)
- [AWS EC2 Guide](https://docs.aws.amazon.com/ec2/)

---

## 💡 Tips

1. **Use environment variables** for all sensitive data
2. **Monitor logs** regularly
3. **Set up automated backups**
4. **Use a proper database** (PostgreSQL) for production
5. **Enable CloudWatch** for AWS monitoring
6. **Set up alerts** for downtime

---

## 🎉 Success!

Your SmartParking app is now deployed with automatic CI/CD!

Every push to main branch will automatically deploy to EC2.
