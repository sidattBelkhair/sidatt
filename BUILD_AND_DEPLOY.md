# 🚀 Guide de Build et Déploiement Multi-Plateforme

## 📱 Configurations Actuelles

### Plateforme: Linux Desktop ✅
- **Status**: En cours d'exécution
- **Configuration**: Complète

### Plateforme: Web ⏳
- **Status**: À tester
- **Configuration**: Prête

### Plateforme: Android 📱
- **Status**: À compiler
- **Configuration**: Mise à jour
- **Package ID**: `com.sidatt.portfolio`
- **Min SDK**: 21 (Android 5.0)
- **Target SDK**: 34 (Android 14)

### Plateforme: iOS 🍎
- **Status**: À compiler
- **Configuration**: Prête
- **Bundle ID**: À configurer
- **Min Version**: iOS 11+

---

## 🔧 Commandes de Build

### 1. **Web Build**

#### Développement
```bash
flutter run -d chrome
```

#### Production
```bash
flutter build web \
  --release \
  --web-renderer html \
  --no-tree-shake-icons
```

**Optimisations Web**:
- Renderer HTML pour meilleure compatibilité
- Compression des assets
- Service Worker pour offline support
- Progressive Web App (PWA)

### 2. **Android Build**

#### Développement
```bash
flutter run -d android
```

#### Build APK
```bash
flutter build apk \
  --release \
  --split-per-abi
```

#### Build App Bundle (Google Play)
```bash
flutter build appbundle \
  --release \
  --target-platform android-arm64
```

**Configuration Requise**:
```bash
# Générer une clé de signature
keytool -genkey -v -keystore ~/key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload-key
```

**Fichier de configuration** (`android/key.properties`):
```properties
storePassword=<votre_mot_de_passe>
keyPassword=<votre_mot_de_passe>
keyAlias=upload-key
storeFile=/path/to/key.jks
```

### 3. **iOS Build**

#### Développement
```bash
flutter run -d ios
```

#### Build pour Device
```bash
flutter build ios \
  --release \
  --no-codesign
```

#### Build pour App Store
```bash
flutter build ios \
  --release

cd ios
xcodebuild -workspace Runner.xcworkspace \
  -scheme Runner \
  -configuration Release \
  -archivePath build/Runner.xcarchive \
  archive

xcodebuild -exportArchive \
  -archivePath build/Runner.xcarchive \
  -exportOptionsPlist ExportOptions.plist \
  -exportPath build/ipa
```

---

## 🌐 Web Deployment

### Déployer sur Netlify

```bash
# 1. Build pour web
flutter build web --release

# 2. Déployer
cd build/web
netlify deploy --prod --dir .
```

### Déployer sur Firebase Hosting

```bash
# 1. Installer Firebase CLI
npm install -g firebase-tools

# 2. Initialize Firebase
firebase init hosting

# 3. Build
flutter build web --release

# 4. Deploy
firebase deploy --only hosting
```

### Déployer sur Vercel

```bash
# 1. Installer Vercel CLI
npm install -g vercel

# 2. Build
flutter build web --release

# 3. Deploy
vercel build/web
```

---

## 📊 Optimisations Performance

### 1. **Web**
- ✅ Compression Gzip des assets
- ✅ Image optimization
- ✅ Lazy loading
- ✅ Service Worker caching
- ✅ CDN distribution

### 2. **Mobile (Android/iOS)**
- ✅ Code shrinking & obfuscation
- ✅ Resource optimization
- ✅ Proguard rules
- ✅ Size reduction (~50MB target)

---

## 📦 Tailles Estimées

| Plateforme | Format | Taille (Release) |
|-----------|--------|------------------|
| Web | HTML5 | ~15-20 MB |
| Android | APK (arm64) | ~40-50 MB |
| Android | App Bundle | ~35-40 MB |
| iOS | IPA | ~50-60 MB |

---

## 🔐 Sécurité

### Android
- Code obfuscation: **Activé**
- ProGuard rules: **Configuré**
- Network Security: **Cleartext désactivé**
- Permissions: **Minimales**

### iOS
- Code signing: **À configurer**
- Bitcode: **À vérifier**
- App Transport Security: **Activé**

### Web
- HTTPS obligatoire: **Oui**
- CSP Headers: **À configurer**
- CORS: **À configurer**

---

## 🧪 Tests Avant Publication

### Tests de Performance
```bash
# Profiler l'app
flutter run --profile

# Mesurer les performances
dart --observe lib/main.dart
```

### Tests sur Appareils Réels
```bash
# Lister les appareils connectés
flutter devices

# Tester sur un appareil spécifique
flutter run -d <device-id>
```

### Web Testing
```bash
# Test responsive
flutter run -d chrome --web-port=8080

# Test sur différentes résolutions
# - Desktop: 1920x1080
# - Tablet: 768x1024
# - Mobile: 360x800
```

---

## 📋 Checklist Avant Publication

- [ ] Version bumped (`pubspec.yaml`)
- [ ] Icons configurés (Android + iOS)
- [ ] Splash screens configurés
- [ ] Permissions vérifiées
- [ ] Links internes testés
- [ ] Performance optimisée
- [ ] Tests unitaires passent
- [ ] Tests d'intégration passent
- [ ] Pas de logs de debug
- [ ] Privacy policy écrite
- [ ] Terms of service écrits
- [ ] Screenshots app store/google play prêts
- [ ] Description du marketplace prête
- [ ] Build signé (Android/iOS)

---

## 🎯 Stores de Distribution

### Google Play Store
1. **Créer un compte developer** (~$25)
2. **Preparer les assets**
   - Icon 512x512 PNG
   - 2+ Screenshots (portrait)
   - Description, changelog
3. **Build App Bundle**
   ```bash
   flutter build appbundle --release
   ```
4. **Upload sur Play Console**

### Apple App Store
1. **Apple Developer Account** (~$99/année)
2. **Create App ID** dans Apple Developer
3. **Build iOS IPA**
   ```bash
   flutter build ios --release
   ```
4. **Upload via Xcode** ou **Transporter**

### Web
- **Netlify**: Déploiement automatique
- **Vercel**: Déploiement automatique
- **GitHub Pages**: Gratuit
- **Custom Domain**: HTTPS + CDN

---

## 🐛 Troubleshooting

### Android Build Errors
```bash
# Clean et rebuild
flutter clean
flutter pub get
flutter build apk --release
```

### iOS Build Errors
```bash
# Pod issues
cd ios
rm -rf Pods Podfile.lock
cd ..
flutter pub get
flutter build ios --release
```

### Web Build Issues
```bash
# Clear build cache
flutter clean
flutter web-publish
```

---

## 📚 Ressources

- [Flutter Deployment Docs](https://docs.flutter.dev/deployment)
- [Android Publishing](https://docs.flutter.dev/deployment/android)
- [iOS Publishing](https://docs.flutter.dev/deployment/ios)
- [Web Deployment](https://docs.flutter.dev/deployment/web)

---

**Dernière mise à jour**: Février 2026
**Version**: 1.0.0
