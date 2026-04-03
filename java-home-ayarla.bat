@echo off
chcp 65001 >nul
echo.
echo ╔══════════════════════════════════════════╗
echo ║   JAVA_HOME OTOMATİK AYARLA             ║
echo ║   (Bir kez çalıştır, kalıcı olur)       ║
echo ╚══════════════════════════════════════════╝
echo.

:: Android Studio JDK'sını bul
set "BULUNAN_JDK="

for /d %%i in ("C:\Program Files\Android\Android Studio\jbr") do (
    if exist "%%i\bin\java.exe" set "BULUNAN_JDK=%%i"
)
if defined BULUNAN_JDK goto :ayarla

for /d %%i in ("C:\Program Files\Android\Android Studio\jre") do (
    if exist "%%i\bin\java.exe" set "BULUNAN_JDK=%%i"
)
if defined BULUNAN_JDK goto :ayarla

for /d %%i in ("%LOCALAPPDATA%\Programs\Android Studio\jbr") do (
    if exist "%%i\bin\java.exe" set "BULUNAN_JDK=%%i"
)
if defined BULUNAN_JDK goto :ayarla

for /d %%i in ("C:\Program Files\Java\jdk-21*") do (
    if exist "%%i\bin\java.exe" set "BULUNAN_JDK=%%i"
)
if defined BULUNAN_JDK goto :ayarla

for /d %%i in ("C:\Program Files\Java\jdk-17*") do (
    if exist "%%i\bin\java.exe" set "BULUNAN_JDK=%%i"
)
if defined BULUNAN_JDK goto :ayarla

echo [HATA] Otomatik JDK bulunamadı!
echo.
echo Manuel bul:
echo  1. Android Studio aç
echo  2. File > Project Structure > SDK Location
echo  3. "JDK Location" değerini kopyala
echo  4. Aşağıdaki komutla ayarla (Admin PowerShell):
echo.
echo  [System.Environment]::SetEnvironmentVariable('JAVA_HOME', 'BURAYA_JDK_YOLU', 'Machine')
echo.
pause
exit /b 1

:ayarla
echo [BULUNDU] JDK: %BULUNAN_JDK%
echo.
echo Sistem ortam değişkeni olarak ayarlanıyor...
echo (Admin yetkisi gerekebilir)
echo.

:: Kalıcı olarak sistem genelinde ayarla
setx JAVA_HOME "%BULUNAN_JDK%" /M >nul 2>&1
if errorlevel 1 (
    :: Kullanıcı seviyesinde dene
    setx JAVA_HOME "%BULUNAN_JDK%" >nul 2>&1
    echo [OK] JAVA_HOME kullanıcı seviyesinde ayarlandı (Admin gerekmedi)
) else (
    echo [OK] JAVA_HOME sistem genelinde ayarlandı
)

:: Mevcut oturum için de ayarla
set "JAVA_HOME=%BULUNAN_JDK%"

:: ANDROID_HOME da ayarla
setx ANDROID_HOME "%LOCALAPPDATA%\Android\Sdk" /M >nul 2>&1
if errorlevel 1 (
    setx ANDROID_HOME "%LOCALAPPDATA%\Android\Sdk" >nul 2>&1
)
echo [OK] ANDROID_HOME ayarlandı: %LOCALAPPDATA%\Android\Sdk

echo.
echo ╔══════════════════════════════════════════╗
echo ║  TAMAMLANDI!                             ║
echo ║                                          ║
echo ║  JAVA_HOME: %BULUNAN_JDK%
echo ║                                          ║
echo ║  ÖNEMLİ: PowerShell/CMD'yi              ║
echo ║  kapatıp yeniden açın!                  ║
echo ╚══════════════════════════════════════════╝
echo.
pause
