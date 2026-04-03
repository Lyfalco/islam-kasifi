@echo off
echo.
echo ============================================
echo   Islam Kasifi - TEMIZ KURULUM
echo ============================================
echo.
cd /d C:\Users\ozgur\OneDrive\Desktop\projelerim\islam-kasifi

echo [1/6] node_modules temizleniyor...
if exist node_modules rmdir /s /q node_modules

echo [2/6] Build cache temizleniyor...
if exist android\.gradle  rmdir /s /q android\.gradle
if exist android\app\build rmdir /s /q android\app\build
if exist android\build     rmdir /s /q android\build
if exist .expo             rmdir /s /q .expo
if exist package-lock.json del /q package-lock.json

echo [3/6] Paketler kuruluyor (react-native-reanimated YOK)...
call npm install

echo [4/6] Asset dosyalari olusturuluyor...
call node scripts/generate-assets.js

echo [5/6] Expo prebuild (temiz)...
call npx expo prebuild --clean

echo [6/6] Android Gradle sync...
cd android
call gradlew.bat clean
cd ..

echo.
echo ============================================
echo   HAZIR!
echo.
echo   1. Android Studio'yu AC
echo   2. File - Open - android/ klasorunu sec
echo   3. Gradle sync bekleniyor...
echo   4. Run tus (yeşil ucgen)
echo ============================================
echo.
pause
