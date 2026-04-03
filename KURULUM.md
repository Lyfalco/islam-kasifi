# Android Kurulum & Sorun Giderme Rehberi

## Hata 1: `expo-asset` bulunamadı

**Sebep:** `npm install` tamamlanmamış veya bozulmuş.

```bash
# Temizle ve yeniden yükle
cd C:\Users\ozgur\OneDrive\Desktop\projelerim\islam-kasifi
Remove-Item -Recurse -Force node_modules
Remove-Item package-lock.json
npm install
```

---

## Hata 2: `adaptive-icon.png` bulunamadı (Prebuild başarısız)

**Sebep:** `assets/images/` klasörü boş — PNG ikonlar eksik.

**Çözüm (tek komut):**
```bash
node scripts/generate-assets.js
```

Bu komut şu dosyaları otomatik oluşturur:
- `assets/images/icon.png`           (1024×1024, yeşil)
- `assets/images/adaptive-icon.png`  (1024×1024, yeşil)
- `assets/images/splash.png`         (1242×2436, koyu yeşil)
- `assets/images/favicon.png`        (48×48, yeşil)

Sonra tekrar prebuild çalıştır:
```bash
npx expo prebuild
```

---

## Hata 3: Android emülatör / cihaz bulunamadı

**Sebep:** Android Studio kurulu değil veya emülatör oluşturulmamış.

### Android Studio Kurulum Adımları

**1. Android Studio İndir ve Kur**
- https://developer.android.com/studio adresine git
- `Android Studio Hedgehog` veya üstü sürümü indir
- Kurulum sihirbazında `Standard` kurulumu seç

**2. SDK Kurulumu (Android Studio içinde)**
```
File → Settings → Appearance & Behavior → System Settings → Android SDK

SDK Platforms sekmesi:
  ✓ Android 14.0 (API 34)
  ✓ Android 12.0 (API 31)

SDK Tools sekmesi:
  ✓ Android SDK Build-Tools 34
  ✓ Android Emulator
  ✓ Android SDK Platform-Tools
  ✓ Intel x86 Emulator Accelerator (HAXM) — Intel işlemci için
  ✓ Android SDK Command-line Tools
```

**3. Ortam Değişkenleri (Windows)**

PowerShell'de çalıştır (Admin olarak):
```powershell
# Kullanıcı profil klasörüne Android SDK yolunu ekle
$sdkPath = "$env:LOCALAPPDATA\Android\Sdk"
[Environment]::SetEnvironmentVariable("ANDROID_HOME", $sdkPath, "User")
[Environment]::SetEnvironmentVariable("ANDROID_SDK_ROOT", $sdkPath, "User")

# PATH'e ekle
$current = [Environment]::GetEnvironmentVariable("PATH", "User")
$newPath = "$current;$sdkPath\platform-tools;$sdkPath\emulator;$sdkPath\tools"
[Environment]::SetEnvironmentVariable("PATH", $newPath, "User")

Write-Host "Ortam değişkenleri ayarlandı. PowerShell'i yeniden başlatın."
```

**4. Emülatör Oluştur**
```
Android Studio → Device Manager (sağ kenar) → + Create Virtual Device

Tavsiye edilen:
  - Device: Pixel 7
  - System Image: Android 14 (API 34) — x86_64
  - AVD Name: Pixel7_API34
```

**5. Emülatörü Başlat ve Test Et**
```powershell
# Terminali yeniden başlat, sonra:
adb devices          # emülatör listede görünmeli
npx expo run:android
```

---

## Hata 4: `expo start` açılıyor ama QR kod telefona bağlanmıyor

**Çözüm:** Expo Go uygulamasını telefonuna yükle (App Store / Play Store)
ve telefon ile bilgisayar aynı Wi-Fi ağında olsun.

---

## Tam Kurulum Sırası (Sıfırdan)

```bash
# 1. Bağımlılıkları kur
npm install

# 2. Asset dosyalarını oluştur
node scripts/generate-assets.js

# 3. Android Studio + SDK kurulumu yap (yukarıdaki adımlar)

# 4. Emülatörü başlat (Android Studio → Device Manager)

# 5. Prebuild çalıştır
npx expo prebuild

# 6. Android'de çalıştır
npx expo run:android

# VEYA Expo Go ile hızlı test (emülatör gerekmez):
npx expo start
# QR kodu tara veya 'a' tuşuna bas (emülatör için)
```

---

## iOS Notu

iOS sadece Mac'te build edilebilir. Ancak:
- **EAS Cloud Build** ile Windows'tan da iOS build alabilirsin:
  ```bash
  npm install -g eas-cli
  eas login
  eas build --platform ios --profile preview
  ```
- Build tamamlandığında TestFlight linki alırsın.
