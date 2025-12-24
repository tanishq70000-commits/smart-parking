@echo off
echo ========================================
echo  SmartParking EC2 Setup Guide
echo ========================================
echo.
echo Step 1: Connect to EC2
echo Command: ssh -i "C:\Users\praka\Downloads\smartparking.pem" ec2-user@13.233.151.155
echo.
echo Step 2: After connecting, run these commands:
echo.
echo # Update system
echo sudo yum update -y
echo.
echo # Install Docker
echo sudo yum install -y docker
echo sudo service docker start
echo sudo systemctl enable docker
echo sudo usermod -aG docker ec2-user
echo.
echo # Install Docker Compose
echo sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
echo sudo chmod +x /usr/local/bin/docker-compose
echo.
echo # Install Git
echo sudo yum install -y git
echo.
echo # Logout and login again
echo exit
echo.
echo Step 3: Reconnect and clone repository
echo ssh -i "C:\Users\praka\Downloads\smartparking.pem" ec2-user@13.233.151.155
echo git clone https://github.com/satyam-prakash/smartparking.git
echo cd smartparking
echo.
echo Step 4: Create .env file
echo cat ^> .env ^<^< 'EOF'
echo SECRET_KEY=your-secret-key-here
echo DEBUG=False
echo ALLOWED_HOSTS=13.233.151.155,localhost
echo EOF
echo.
echo Step 5: Start the application
echo docker-compose up -d --build
echo.
pause
