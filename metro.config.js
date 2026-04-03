// Android Studio / Gradle ile paket oluştururken de Expo Metro ayarlarının kullanılması için
const { getDefaultConfig } = require('expo/metro-config');

module.exports = getDefaultConfig(__dirname);
