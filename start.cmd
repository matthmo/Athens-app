@echo off

echo.
echo Restoring backend python packages
echo.
@REM call python -m pip install -r requirements.txt
@REM if "%errorlevel%" neq "0" (
@REM     echo Failed to restore backend python packages
@REM     exit /B %errorlevel%
@REM )

echo.
echo Restoring frontend npm packages
echo.
cd frontend
@REM call npm install
@REM if "%errorlevel%" neq "0" (
@REM     echo Failed to restore frontend npm packages
@REM     exit /B %errorlevel%
@REM )

echo.
echo Building frontend
echo.
call npm run build
if "%errorlevel%" neq "0" (
    echo Failed to build frontend
    exit /B %errorlevel%
)

echo.    
echo Starting backend    
echo.    
cd ..  
start http://127.0.0.1:50505
call python -m uvicorn app:app  --port 50505 --reload
if "%errorlevel%" neq "0" (    
    echo Failed to start backend    
    exit /B %errorlevel%    
) 
