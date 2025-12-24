# 🚀 Quick Setup Guide - SmartParking on EC2

## Your Configuration
- **EC2 IP**: 13.233.151.155
- **EC2 OS**: Amazon Linux (t3.micro)
- **Docker Hub**: satyampr01/smartparking
- **SSH Key**: C:\Users\praka\Downloads\smartparking.pem

---

## ⚡ Quick Start (5 Steps)

### Step 1: Connect to EC2 from Your Windows PC

```powershell
ssh -i "C:\Users\praka\Downloads\smartparking.pem" ec2-user@13.233.151.155
```

### Step 2: Setup Docker on EC2 (First Time Only)

```bash
# Update system
sudo yum update -y

# Install Docker
sudo yum install -y docker
sudo service docker start
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Git
sudo yum install -y git

# Logout and login again
exit
```

```powershell
# Reconnect
ssh -i "C:\Users\praka\Downloads\smartparking.pem" ec2-user@13.233.151.155
```

### Step 3: Clone Your Repository on EC2

```bash
cd ~
git clone https://github.com/YOUR-USERNAME/SmartParking.git
cd SmartParking
```

### Step 4: Configure Environment

```bash
# Create .env file
cat > .env << 'EOF'
SECRET_KEY=django-insecure-change-this-in-production-xyz123
DEBUG=False
ALLOWED_HOSTS=13.233.151.155,localhost,127.0.0.1
EOF

# Generate a proper secret key
python3 -c "import secrets; print('SECRET_KEY=' + secrets.token_urlsafe(50))" > .env.new
cat >> .env.new << 'EOF'
DEBUG=False
ALLOWED_HOSTS=13.233.151.155,localhost,127.0.0.1
EOF
mv .env.new .env
```

### Step 5: Start the Application

```bash
# Build and start containers
docker-compose up -d --build

# Run migrations
docker-compose exec web python manage.py migrate

# Create admin user
docker-compose exec web python manage.py createsuperuser

# Check status
docker-compose ps
```

**🎉 Your app is now running at: http://13.233.151.155**

---

## 🔐 Setup GitHub Actions (Automated Deployment)

### 1. Push Your Code to GitHub

```powershell
# On your Windows PC, in the project folder
git init
git add .
git commit -m "Initial commit with CI/CD"
git remote add origin https://github.com/YOUR-USERNAME/SmartParking.git
git branch -M main
git push -u origin main
```

### 2. Add GitHub Secrets

Go to: `https://github.com/YOUR-USERNAME/SmartParking/settings/secrets/actions`

Add these 4 secrets:

**EC2_HOST**
```
13.233.151.155
```

**EC2_USERNAME**
```
ec2-user
```

**EC2_SSH_KEY**
```powershell
# On Windows, open PowerShell and run:
Get-Content "C:\Users\praka\Downloads\smartparking.pem"
# Copy the entire output including -----BEGIN and -----END lines
```

**DOCKER_USERNAME**
```
satyampr01
```

**DOCKER_PASSWORD**
```
your-dockerhub-password-or-token
```

### 3. Test Auto-Deployment

```powershell
# Make a small change
echo "# Test" >> README.md
git add .
git commit -m "Test CI/CD"
git push

# GitHub Actions will automatically deploy to EC2!
# Check: https://github.com/YOUR-USERNAME/SmartParking/actions
```

---

## 🔄 Common Commands

### On Your Windows PC:

```powershell
# Connect to EC2
ssh -i "C:\Users\praka\Downloads\smartparking.pem" ec2-user@13.233.151.155

# Copy files to EC2
scp -i "C:\Users\praka\Downloads\smartparking.pem" file.txt ec2-user@13.233.151.155:~/
```

### On EC2:

```bash
# Navigate to project
cd ~/SmartParking

# View logs
docker-compose logs -f

# Restart application
docker-compose restart

# Stop application
docker-compose down

# Update and restart
git pull
docker-compose up -d --build

# Run Django commands
docker-compose exec web python manage.py migrate
docker-compose exec web python manage.py createsuperuser
docker-compose exec web python manage.py collectstatic

# Check containers
docker ps
docker-compose ps

# View resource usage
docker stats
```

---

## 🌐 Access Your Application

- **Website**: http://13.233.151.155
- **Admin Panel**: http://13.233.151.155/admin
- **EC2 SSH**: `ssh -i "C:\Users\praka\Downloads\smartparking.pem" ec2-user@13.233.151.155`

---

## 🔥 Quick Fixes

### App not responding?
```bash
cd ~/SmartParking
docker-compose restart
docker-compose logs -f web
```

### Permission denied?
```bash
sudo chmod 600 ~/smartparking.pem
sudo chown -R ec2-user:ec2-user ~/SmartParking
```

### Port 80 already in use?
```bash
sudo lsof -i :80
sudo kill -9 <PID>
docker-compose up -d
```

### GitHub Actions failing?
- Check EC2 security group allows SSH from anywhere (0.0.0.0/0) on port 22
- Verify all 5 GitHub secrets are set correctly
- Check EC2 instance is running

### Docker Hub push failing?
```bash
# On your Windows PC
docker login
# Username: satyampr01
# Password: your-password

# Test push
docker build -t satyampr01/smartparking:test .
docker push satyampr01/smartparking:test
```

---

## 🔒 Security Checklist

- [ ] EC2 Security Group: Allow only ports 22, 80, 443
- [ ] Change SECRET_KEY in .env file
- [ ] Set DEBUG=False in production
- [ ] Use strong password for Docker Hub
- [ ] Protect your .pem file (chmod 600)
- [ ] Enable HTTPS with SSL certificate
- [ ] Regular backups of database

---

## 📊 Monitor Your App

```bash
# Check if app is running
curl http://13.233.151.155

# Check Docker resources
docker stats

# Check disk space
df -h

# Check memory
free -h

# View all logs
docker-compose logs --tail=100
```

---

## 🎯 Next Steps

1. ✅ Setup automatic backups
2. ✅ Configure domain name (if you have one)
3. ✅ Enable HTTPS with Let's Encrypt
4. ✅ Set up monitoring (CloudWatch)
5. ✅ Configure database (PostgreSQL) for production

---

## 💡 Pro Tips

- Every push to `main` branch auto-deploys to EC2
- Use `docker-compose logs -f` to debug issues
- Keep your Docker images updated
- Regular security updates: `sudo yum update -y`
- Monitor EC2 costs in AWS Console

---

## 📞 Quick Reference

```bash
# SSH Command
ssh -i "C:\Users\praka\Downloads\smartparking.pem" ec2-user@13.233.151.155

# Project Location on EC2
cd /home/ec2-user/SmartParking

# View App
curl http://13.233.151.155

# Restart Everything
cd ~/SmartParking && docker-compose restart

# Update App
cd ~/SmartParking && git pull && docker-compose up -d --build
```

---

**🎉 You're all set! Happy coding!**
