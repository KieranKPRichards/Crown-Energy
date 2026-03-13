@echo off
echo ============================================
echo  Crown Energy Meter Reporting Application
echo ============================================
echo.

:: Find Python 3
where python3 >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    set PYTHON=python3
    goto :found
)
where python >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    set PYTHON=python
    goto :found
)
echo ERROR: Python 3 is not installed.
echo Download from: https://www.python.org/downloads/
pause
exit /b 1

:found
echo Using: %PYTHON%

:: Create virtual environment if it doesn't exist
if not exist "venv" (
    echo Creating virtual environment...
    %PYTHON% -m venv venv
)

:: Activate virtual environment
call venv\Scripts\activate.bat

:: Install dependencies
echo Installing dependencies...
pip install -r requirements.txt --quiet

echo.
echo Starting application...
echo Open your browser to: http://localhost:5000
echo.
python app.py
pause
