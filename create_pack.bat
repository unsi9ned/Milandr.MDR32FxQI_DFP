@echo off
setlocal enabledelayedexpansion

:: Настройки
set PACK_NAME=Milandr.MDR32FxQI_DFP
set DEFAULT_VERSION=1.3.2-unsi9ned.1
set SEVEN_ZIP_PATH=C:\Program Files\7-Zip

:: Добавляем 7-Zip в PATH временно
set PATH=%SEVEN_ZIP_PATH%;%PATH%

:: Проверка наличия 7z
where 7z >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] 7-Zip not found at %SEVEN_ZIP_PATH%
    echo Please install 7-Zip or check the path.
    pause
    exit /b 1
)

:: Вывод заголовка
cls
echo ========================================
echo   CMSIS Pack Builder
echo ========================================
echo.
echo Pack: %PACK_NAME%
echo.

:: Запрос версии
set /p PACK_VERSION="Enter version [%DEFAULT_VERSION%]: "
if "%PACK_VERSION%"=="" set PACK_VERSION=%DEFAULT_VERSION%

:: Имя выходного файла
set OUTPUT_FILE=%~dp0%PACK_NAME%.%PACK_VERSION%.pack

echo.
echo Source: %~dp0
echo Output: %OUTPUT_FILE%
echo.

:: Проверка наличия pdsc
if not exist "%~dp0%PACK_NAME%.pdsc" (
    echo [WARNING] PDSC file not found: %PACK_NAME%.pdsc
    echo.
)

:: Создание временной папки
set TEMP_DIR=%TEMP%\pack_%RANDOM%
mkdir "%TEMP_DIR%" 2>nul

:: Копирование всех файлов из текущей папки (кроме батника и уже созданных pack)
echo Copying files...
for /f "delims=" %%i in ('dir /b /a-d ^| findstr /v "\.bat$ \.pack$"') do (
    copy "%%i" "%TEMP_DIR%\" >nul 2>nul
)
for /d %%i in (*) do (
    if /i not "%%i"=="%TEMP_DIR%" (
        xcopy "%%i\*" "%TEMP_DIR%\%%i\" /E /I /Y >nul
    )
)

:: Упаковка
echo Creating pack...
pushd "%TEMP_DIR%"
7z a -tzip "%OUTPUT_FILE%" * -mx=5 >nul
popd

:: Очистка
rmdir /s /q "%TEMP_DIR%" 2>nul

:: Результат
echo.
if exist "%OUTPUT_FILE%" (
    echo [OK] Pack created successfully!
    echo File: %OUTPUT_FILE%
    for %%A in ("%OUTPUT_FILE%") do echo Size: %%~zA bytes
) else (
    echo [ERROR] Failed to create pack!
)

echo.
pause