@echo off
chcp 65001 >nul
echo.
echo ╔══════════════════════════════════════════╗
echo ║     İSLAM KÂŞİFİ - HIZLI BUILD          ║
echo ║     Expo React Native - Android          ║
echo ╚══════════════════════════════════════════╝
echo.

cd /d C:\Users\ozgur\OneDrive\Desktop\projelerim\islam-kasifi

:: ── JAVA_HOME OTOMATİK BUL ──────────────────────────────────────
echo [JAVA] Java ortamı kontrol ediliyor...

if defined JAVA_HOME (
    echo [OK] JAVA_HOME zaten tanımlı: %JAVA_HOME%
    goto :java_ok
)

:: Android Studio JDK'sını otomatik bul
for /d %%i in ("%LOCALAPPDATA%\Android\Sdk\jdk-*") do (
    set "JAVA_HOME=%%i"
    goto :java_bulundu
)
:: Android Studio içindeki JDK
for /d %%i in ("C:\Program Files\Android\Android Studio\jbr") do (
    set "JAVA_HOME=%%i"
    goto :java_bulundu
)
for /d %%i in ("C:\Program Files\Android\Android Studio\jre") do (
    set "JAVA_HOME=%%i"
    goto :java_bulundu
)
:: Varsayılan JDK konumları
for /d %%i in ("C:\Program Files\Java\jdk-*") do (
    set "JAVA_HOME=%%i"
    goto :java_bulundu
)
for /d %%i in ("C:\Program Files\Eclipse Adoptium\jdk-*") do (
    set "JAVA_HOME=%%i"
    goto :java_bulundu
)

echo [HATA] Java bulunamadı!
echo.
echo Çözüm:
echo  1. Android Studio'yu aç
echo  2. File - Project Structure - SDK Location
echo  3. JDK Location'ı kopyala
echo  4. Aşağıdaki komutu PowerShell'de çalıştır (Admin):
echo     [System.Environment]::SetEnvironmentVariable('JAVA_HOME','JDK_YOLU','Machine')
echo.
pause
exit /b 1

:java_bulundu
echo [OK] Java bulundu: %JAVA_HOME%
set "PATH=%JAVA_HOME%\bin;%PATH%"

:java_ok
:: ── ANDROID SDK ─────────────────────────────────────────────────
if not defined ANDROID_HOME (
    set "ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk"
    set "PATH=%PATH%;%LOCALAPPDATA%\Android\Sdk\platform-tools"
)

echo [OK] ANDROID_HOME: %ANDROID_HOME%
echo.

:: ── METRO SUNUCU KONTROLÜ ────────────────────────────────────────
echo [1/4] Metro sunucusu başlatılıyor (arka planda)...
start "Metro - İslam Kâşifi" /min cmd /c "npx expo start --port 8081"
timeout /t 3 /nobreak >nul
echo [OK] Metro başlatıldı (port 8081)
echo.

:: ── GRADLE CACHE TEMİZLE ────────────────────────────────────────
echo [2/4] Gradle build cache temizleniyor...
cd android
call gradlew.bat clean --quiet 2>nul
cd ..
echo [OK] Cache temizlendi
echo.

:: ── APK BUILD ───────────────────────────────────────────────────
echo [3/4] Debug APK build ediliyor...
echo       (Bu işlem 2-5 dakika sürebilir, bekleyin...)
echo.
cd android
call gradlew.bat assembleDebug
if errorlevel 1 (
    echo.
    echo ╔══════════════════════════════════════════╗
    echo ║  BUILD BAŞARISIZ!                        ║
    echo ║                                          ║
    echo ║  Çözüm deneyin:                          ║
    echo ║  1. Android Studio - Build - Clean       ║
    echo ║  2. Invalidate Caches - Restart          ║
    echo ║  3. Bu scripti tekrar çalıştırın         ║
    echo ╚══════════════════════════════════════════╝
    cd ..
    pause
    exit /b 1
)
cd ..
echo.
echo [OK] APK oluşturuldu!
echo.

:: ── APK YÜKLEMESİ ───────────────────────────────────────────────
echo [4/4] APK cihaza/emülatöre yükleniyor...
set APK_YOLU=android\app\build\outputs\apk\debug\app-debug.apk

adb devices | findstr /i "device" >nul 2>&1
if errorlevel 1 (
    echo [UYARI] Bağlı cihaz/emülatör bulunamadı
    echo         APK hazır, manuel kurulum için:
    echo         %APK_YOLU%
) else (
    call adb install -r %APK_YOLU%
    if errorlevel 1 (
        echo [UYARI] APK yükleme başarısız, ama APK hazır:
        echo         %APK_YOLU%
    ) else (
        echo [OK] Uygulama cihaza yüklendi!
        echo [OK] Uygulamayı başlatılıyor...
        call adb shell am start -n com.islamkasifi.app/.MainActivity
    )
)

echo.
echo ╔══════════════════════════════════════════╗
echo ║  TAMAMLANDI!                             ║
echo ║                                          ║
echo ║  APK: %APK_YOLU%
echo ╚══════════════════════════════════════════╝
echo.
pause
