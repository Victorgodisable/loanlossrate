@echo off
echo ========================================
echo LLR Pricing Estimation System
echo PDF Presentation Generator
echo ========================================
echo.

echo Checking Python installation...
python --version
if %errorlevel% neq 0 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python 3.8+ from https://python.org
    pause
    exit /b 1
)

echo.
echo Installing required packages...
pip install -r requirements_pdf.txt

echo.
echo Generating PDF presentation...
python generate_pdf_presentation.py

echo.
echo ========================================
echo PDF generation complete!
echo Check for LLR_Pricing_Estimation_System_Presentation.pdf
echo ========================================
pause

