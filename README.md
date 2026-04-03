# İslam Kâşifi 🌙

7-12 yaş arası çocuklara yönelik, Siyer, Kur'an, Sahabe ve İlmihal konularında
eğlenceli bilgi yarışması uygulaması.

## Hızlı Başlangıç

```bash
# Bağımlılıkları yükle
npm install

# Geliştirme sunucusunu başlat
npx expo start

# iOS simülatöründe çalıştır (Mac gerektirir)
npx expo run:ios

# Android emülatöründe çalıştır
npx expo run:android
```

## Proje Yapısı

```
islam-kasifi/
├── app/                    # Expo Router ekranları
│   ├── (tabs)/             # Alt navigasyon ekranları
│   │   ├── index.tsx       # Ana menü
│   │   ├── harita.tsx      # Keşif haritası
│   │   └── profil.tsx      # Profil & rozetler
│   ├── quiz/
│   │   ├── [categoryId].tsx # Quiz ekranı
│   │   └── sonuc.tsx        # Sonuç ekranı
│   ├── hosgeldin.tsx        # Karşılama ekranı
│   └── _layout.tsx          # Kök layout
│
├── src/
│   ├── components/          # Yeniden kullanılabilir bileşenler
│   ├── constants/           # Renkler, sabitler
│   ├── data/                # Sorular, kategoriler, rozetler
│   ├── hooks/               # Custom hooks
│   ├── store/               # Zustand state yönetimi
│   └── utils/               # Yardımcı fonksiyonlar
│
├── ios/                     # iOS native dosyalar (expo prebuild)
├── android/                 # Android native dosyalar (expo prebuild)
└── assets/                  # Font, ikon, görseller
```

## Teknoloji Yığını

| Teknoloji | Kullanım |
|-----------|----------|
| Expo SDK 52 | Cross-platform framework |
| Expo Router | Dosya tabanlı navigasyon |
| Zustand | State yönetimi |
| AsyncStorage | Yerel veri saklama |
| React Native SVG | Keşif haritası |
| Lottie | Animasyonlar |
| Expo Haptics | Dokunsal geri bildirim |
| Nunito Font | Çocuk dostu tipografi |

## Soru Havuzu

| Kategori | Soru Sayısı | Kilit |
|----------|-------------|-------|
| Siyer | 25 | Açık |
| Kur'an | 25 | 50 puan |
| Sahabe | 25 | 150 puan |
| İlmihal | 25 | 300 puan |

**Toplam: 100 soru** — Her tur tüm sorular karışık sırada gelir.

## Build & Yayın

```bash
# EAS CLI kurulumu
npm install -g eas-cli
eas login

# Android (Google Play)
eas build --platform android --profile production

# iOS (App Store)
eas build --platform ios --profile production
```

## Önemli Notlar

- Peygamber ve sahabe tasvirleri yer almaz (resmetme hassasiyeti)
- Tüm içerik 7-12 yaş pedagojisine uygundur
- Ödül odaklı dil kullanılır, ceza/başarısızlık vurgusu yoktur
- İçerikler ilahiyat danışmanı onayından geçirilmelidir
