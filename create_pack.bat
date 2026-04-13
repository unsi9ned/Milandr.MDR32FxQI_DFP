@echo off
setlocal enabledelayedexpansion

:: ========================================
:: CMSIS Pack Builder for Milandr MDR32FxQI
:: ========================================
:: Builds two packs:
::   1. Milandr.MDR32FxQI_DFP.xxx.pack - Device Family Pack
::   2. Milandr.MDR32FxQI_Examples.xxx.pack - Examples pack
:: ========================================

:: Настройки
set PACK_NAME_DFP=Milandr.MDR32FxQI_DFP
set PACK_NAME_EXAMPLES=Milandr.MDR32FxQI_Examples
set DEFAULT_VERSION=1.3.2-unsi9ned.2
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

:: Запрос версии
set /p PACK_VERSION="Enter version [%DEFAULT_VERSION%]: "
if "%PACK_VERSION%"=="" set PACK_VERSION=%DEFAULT_VERSION%

:: ========================================
:: Сборка DFP пакета
:: ========================================
echo.
echo [1/2] Building DFP Pack...
echo   Pack: %PACK_NAME_DFP%
echo   Version: %PACK_VERSION%
echo.

set OUTPUT_FILE_DFP=%~dp0%PACK_NAME_DFP%.%PACK_VERSION%.pack

if not exist "%~dp0%PACK_NAME_DFP%.pdsc" (
    echo [WARNING] PDSC file not found: %PACK_NAME_DFP%.pdsc
)

:: Создание временной папки для DFP
set TEMP_DIR_DFP=%TEMP%\pack_%RANDOM%
mkdir "%TEMP_DIR_DFP%" 2>nul

:: Копирование всех файлов для DFP (исключая ненужное)
echo Copying DFP files...
for /f "delims=" %%i in ('dir /b /a-d ^| findstr /v "\.bat$ \.pack$ examples\.xml$ \.gitignore$"') do (
    copy "%%i" "%TEMP_DIR_DFP%\" >nul 2>nul
)
for /d %%i in (*) do (
    if /i not "%%i"=="%TEMP_DIR_DFP%" (
        if /i not "%%i"=="Examples" (
            if /i not "%%i"==".git" (
                if /i not "%%i"==".github" (
                    xcopy "%%i\*" "%TEMP_DIR_DFP%\%%i\" /E /I /Y >nul 2>nul
                )
            )
        )
    )
)

:: Упаковка DFP
pushd "%TEMP_DIR_DFP%"
7z a -tzip "%OUTPUT_FILE_DFP%" * -mx=5 >nul
popd

:: Очистка DFP
rmdir /s /q "%TEMP_DIR_DFP%" 2>nul

if exist "%OUTPUT_FILE_DFP%" (
    echo [OK] DFP Pack created: %OUTPUT_FILE_DFP%
    for %%A in ("%OUTPUT_FILE_DFP%") do echo       Size: %%~zA bytes
) else (
    echo [ERROR] Failed to create DFP pack!
)

:: ========================================
:: Сборка Examples пакета
:: ========================================
echo.
echo [2/2] Building Examples Pack...
echo   Pack: %PACK_NAME_EXAMPLES%
echo   Version: %PACK_VERSION%
echo.

set OUTPUT_FILE_EXAMPLES=%~dp0%PACK_NAME_EXAMPLES%.%PACK_VERSION%.pack

if not exist "%~dp0examples.xml" (
    echo [WARNING] examples.xml not found
)

:: Создание временной папки для Examples
set TEMP_DIR_EXAMPLES=%TEMP%\pack_examples_%RANDOM%
mkdir "%TEMP_DIR_EXAMPLES%" 2>nul

:: Копирование examples.xml и переименование в .pdsc
copy "%~dp0examples.xml" "%TEMP_DIR_EXAMPLES%\%PACK_NAME_EXAMPLES%.pdsc" >nul 2>nul

:: Копирование документации
if exist "%~dp0LICENSE.txt" copy "%~dp0LICENSE.txt" "%TEMP_DIR_EXAMPLES%\" >nul 2>nul
if exist "%~dp0README.md" copy "%~dp0README.md" "%TEMP_DIR_EXAMPLES%\" >nul 2>nul
if exist "%~dp0RELEASE.md" copy "%~dp0RELEASE.md" "%TEMP_DIR_EXAMPLES%\" >nul 2>nul

:: Копирование папки Examples
if exist "%~dp0Examples" (
    xcopy "%~dp0Examples" "%TEMP_DIR_EXAMPLES%\Examples\" /E /I /Y >nul 2>nul
)

:: Удаление .gitignore если он случайно попал
if exist "%TEMP_DIR_EXAMPLES%\.gitignore" del "%TEMP_DIR_EXAMPLES%\.gitignore" >nul 2>nul
if exist "%TEMP_DIR_EXAMPLES%\Examples\.gitignore" del "%TEMP_DIR_EXAMPLES%\Examples\.gitignore" >nul 2>nul

:: Упаковка Examples
pushd "%TEMP_DIR_EXAMPLES%"
7z a -tzip "%OUTPUT_FILE_EXAMPLES%" * -mx=5 >nul
popd

:: Очистка Examples
rmdir /s /q "%TEMP_DIR_EXAMPLES%" 2>nul

if exist "%OUTPUT_FILE_EXAMPLES%" (
    echo [OK] Examples Pack created: %OUTPUT_FILE_EXAMPLES%
    for %%A in ("%OUTPUT_FILE_EXAMPLES%") do echo       Size: %%~zA bytes
) else (
    echo [ERROR] Failed to create Examples pack!
)

:: ========================================
:: Завершение
:: ========================================
echo.
echo ========================================
echo   Build completed!
echo ========================================
echo.
echo Output files:
echo   %OUTPUT_FILE_DFP%
echo   %OUTPUT_FILE_EXAMPLES%
echo.

pause