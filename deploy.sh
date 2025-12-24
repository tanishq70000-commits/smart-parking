#!/bin/bash

# EC2 Deployment Script for Amazon Linux
# Run this manually on your EC2 instance for initial setup

echo "=== SmartParking Deployment Script (Amazon Linux) ==="

# Update system
echo "Updating system packages..."
sudo yum update -y

# Install Docker
echo "Installing Docker..."
sudo yum install -y docker
sudo service docker start
sudo systemctl enable docker

# Install Docker Compose
echo "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Add ec2-user to docker group
echo "Adding ec2-user to docker group..."
sudo usermod -aG docker ec2-user

# Install Git
echo "Installing Git..."
sudo yum install -y git

# Clone repository
echo "Cloning SmartParking repository..."
cd /home/ec2-user
git clone https://github.com/YOUR-USERNAME/SmartParking.git
cd SmartParking
echo ""

# Create .env file
echo "Don't forget to create .env file with your configuration!"
echo ""

echo "=== Setup Complete ==="
echo "Next steps:"
echo "1. Clone your GitHub repository"
echo "2. Create .env file from .env.example"
echo "3. Run: docker-compose up -d --build"
echo "4. Configure GitHub Secrets for CI/CD"
