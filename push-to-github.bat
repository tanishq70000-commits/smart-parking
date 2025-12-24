@echo off
echo ========================================
echo GitHub Push Helper Script
echo ========================================
echo.
echo This script will help you push your code to GitHub.
echo.
echo OPTION 1: Use GitHub Personal Access Token (Recommended)
echo ----------------------------------------------------------
echo 1. Go to: https://github.com/settings/tokens
echo 2. Click "Generate new token" (classic)
echo 3. Give it a name (e.g., "SmartParking Deploy")
echo 4. Select scope: repo (full control of private repositories)
echo 5. Click "Generate token" and COPY IT
echo 6. Use this command:
echo    git push https://YOUR_TOKEN@github.com/tanishq70000-commits/smart-parking.git main
echo.
echo OPTION 2: Use SSH Key
echo ----------------------------------------------------------
echo 1. Generate SSH key: ssh-keygen -t ed25519 -C "your_email@example.com"
echo 2. Add to GitHub: https://github.com/settings/keys
echo 3. Change remote to SSH: git remote set-url origin git@github.com:tanishq70000-commits/smart-parking.git
echo 4. Push: git push -u origin main
echo.
echo ========================================
pause
