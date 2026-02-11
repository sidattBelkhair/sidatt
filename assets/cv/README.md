# Fichier CV - Instructions

## Où placer votre CV pour le téléchargement

Placez votre CV dans ce dossier `/assets/cv/` avec le nom de fichier exact :
**`CV_SidattBelkhair.pdf`**

### Formats acceptés :
- `.pdf` (recommandé) - PDF du CV
- `.docx` - Document Word
- `.txt` - Fichier texte

### Exemple de structure :
```
/assets/cv/
├── CV_SidattBelkhair.pdf    ← Placer votre CV ici
└── README.md                 ← Ce fichier
```

## Comment ajouter votre CV :

1. Préparez votre CV en PDF
2. Placez-le dans le dossier `/assets/cv/`
3. Nommez-le exactement : `CV_SidattBelkhair.pdf`
4. Lancez l'application, le bouton "Télécharger CV" fonctionnera

## Configuration dans pubspec.yaml

Assurez-vous que le dossier assets est inclus dans `pubspec.yaml` :

```yaml
flutter:
  assets:
    - assets/cv/CV_SidattBelkhair.pdf
```

## Notes importantes :

- Le fichier doit être exactement nommé `CV_SidattBelkhair.pdf`
- Si vous changez le nom, mettez à jour la variable `cvUrl` dans `lib/widgets/hero_section.dart`
- Pour l'application web, le fichier sera accessible via `assets/cv/CV_SidattBelkhair.pdf`
- Pour les applications mobiles (iOS/Android), vous devrez ajuster le chemin d'accès

---

**Dernière modification :** 11 Février 2026
