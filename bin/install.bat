@echo off
echo 🧪 Checking Python...
where python >nul 2>nul || (
  echo ❌ Python is not installed. Please install Python 3.8+
  exit /b 1
)
python -m prefiq_installer.installer
