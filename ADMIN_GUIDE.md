# 🎯 Guide du Panneau d'Administration - Sidatt Portfolio

## ✨ Accès au Panneau Admin

### Méthode 1: Raccourci Clavier
- Appuyez **5 fois rapidement** sur le logo du terminal (en bas à gauche)
- Vous serez redirigé vers la page de connexion

### Méthode 2: Navigation Directe
- Accédez à `/admin` directement via l'URL (si applicable)

### Identifiants Initiaux
- **Mot de passe par défaut**: `admin123`
- **⚠️ Changez ce mot de passe immédiatement** dans les paramètres

---

## 📋 Sections du Panneau Admin

### 1. 📁 **Projects (Projets)**

#### Ajouter un Nouveau Projet
1. Cliquez sur le bouton **+** en bas à droite
2. Remplissez les champs:
   - **Project Name**: Nom du projet
   - **Description (EN)**: Description en anglais
   - **Description (FR)**: Description en français
   - **Description (AR)**: Description en arabe
   - **Technologies**: Séparez par des virgules (ex: `Java, Spring Boot, REST API`)
   - **GitHub URL**: Lien vers le repository
   - **Demo URL**: Lien vers la démo
   - **Category**: Type du projet (Backend, Frontend, AI/ML, etc.)
3. Cliquez sur **Save**

#### Modifier un Projet
1. Cliquez sur l'icône ✏️ sur la carte du projet
2. Modifiez les informations
3. Cliquez sur **Save**

#### Supprimer un Projet
1. Cliquez sur l'icône 🗑️ sur la carte du projet
2. Confirmez la suppression

---

### 2. 🎓 **Skills (Compétences)**

#### Organiser par Catégories
Les compétences sont automatiquement organisées par:
- **Cybersecurity** (Sécurité)
- **Networking** (Réseaux)
- **Development** (Développement)
- **AI/ML** (Intelligence Artificielle)
- **Monitoring** (Surveillance)

#### Ajouter une Compétence
1. Cliquez sur **+** dans la catégorie souhaitée
2. Entrez:
   - **Skill Name**: Nom de la compétence
   - **Category**: Catégorie
   - **Level**: Niveau (1-5 étoiles)
3. Sauvegardez

#### Modifier/Supprimer
- Utilisez les icônes ✏️ et 🗑️ sur chaque compétence

---

### 3. 💼 **Experience (Expériences)**

#### Ajouter une Expérience
1. Cliquez sur **+**
2. Remplissez:
   - **Job Title**: Titre du poste
   - **Company**: Nom de l'entreprise
   - **Description**: Descriptions multilingues
   - **Currently Working Here**: Cochez si c'est un poste actuel
3. Sauvegardez

#### Emplois Actuels
- Cochez "Currently Working Here" pour marquer un emploi en cours
- La date de fin ne sera pas affichée

---

### 4. 📧 **Contact (Contacts)**

#### Gérer les Informations de Contact
1. Remplissez tous les champs:
   - **GitHub URL**
   - **LinkedIn URL**
   - **Email Address**
   - **Twitter URL**
   - **TryHackMe URL**

2. Cliquez sur **Save Contact Information**

#### Utilisation
Ces informations seront affichées dans:
- La section Contact du portfolio
- Les liens sociaux du footer
- Les boutons d'action du hero

---

### 5. 🎨 **Themes (Thèmes)**

#### Voir les Thèmes Disponibles
Les thèmes sont listés avec:
- **Nom du thème**
- **Mode** (Dark/Light)
- **Aperçu des couleurs**
- **Statut**: "Active" pour le thème sélectionné

#### Thèmes Prédéfinis
1. **Dark Terminal** ✅ (Défaut)
   - Vert terminal (#00ff41)
   - Fond noir (#0a0a0a)

2. **Light Professional**
   - Vert professionnel (#1a5f2a)
   - Fond clair (#f5f5f5)

3. **Ocean Blue**
   - Bleu océan (#0066cc)
   - Fond bleu foncé (#0a1428)

4. **Purple Passion**
   - Violet (#7c3aed)
   - Fond violet foncé (#1e1b4b)

#### Créer un Nouveau Thème
1. Cliquez sur **+**
2. Entrez:
   - **Theme Name**: Nom personnalisé
   - **Primary Color**: Couleur principale (cliquez pour ouvrir le sélecteur)
   - **Secondary Color**: Couleur secondaire
   - **Background Color**: Couleur de fond
   - **Mode**: Dark ou Light
3. Sauvegardez

#### Personnaliser une Couleur
1. Cliquez sur le carré de couleur
2. Entrez le code HEX (ex: `FF0000` pour rouge)
3. Confirmez

#### Sélectionner un Thème
1. Cliquez sur **Select** sur la carte du thème
2. Le thème s'applique immédiatement

#### Supprimer un Thème
- ⚠️ Vous devez garder au minimum **1 thème**
- Cliquez sur **Delete** pour le supprimer

---

### 6. ⚙️ **Settings (Paramètres)**

#### Changer le Mot de Passe Admin
1. Entrez **Old Password**: Votre ancien mot de passe
2. Entrez **New Password**: Nouveau mot de passe
3. Entrez **Confirm New Password**: Confirmation
4. Cliquez **Change Password**

#### Statistiques du Portfolio
Voir en temps réel:
- Nombre total de projets
- Nombre total de compétences
- Nombre total d'expériences
- Nombre de thèmes disponibles

#### À Propos du Panneau Admin
- Description complète des fonctionnalités
- Guide rapide des sections

---

## 🔐 Sécurité

### ⚠️ Points Importants
1. **Changez le mot de passe par défaut** immédiatement
2. **Ne partagez pas** le lien admin public
3. **Logout** après chaque session (bouton rouge en haut à droite)
4. Les données **ne sont pas persistantes** (stockage local uniquement)

### Pour la Production
- Implémenter une **base de données** (Firebase, Supabase, etc.)
- Utiliser **JWT tokens** pour l'authentification
- Ajouter **HTTPS** obligatoire
- Activer **2FA** (authentification à deux facteurs)

---

## 💡 Conseils & Astuces

### Organisation des Projets
- Regroupez par **category** (Backend, Frontend, etc.)
- Utilisez des **technologies** cohérentes
- Gardez les **descriptions courtes** et pertinentes

### Gestion des Compétences
- Soyez honnête sur les **niveaux**
- Maintenez à jour les **nouvelles compétences**
- Regroupez par **domaines d'expertise**

### Thèmes Personnalisés
- Testez les **combinaisons de couleurs**
- Assurez-vous du **contraste** pour l'accessibilité
- Utilisez des **codes HEX valides**

### Sauvegarde
- Les données sont sauvegardées dans la **mémoire locale**
- **Exportez vos données** régulièrement
- Utilisez un **service cloud** pour les backups

---

## 🚀 Prochaines Étapes

### À Implémenter
1. ✅ Interface Admin (Fait)
2. ⏳ Persistent storage (Database)
3. ⏳ Export/Import de données
4. ⏳ Aperçu en temps réel
5. ⏳ Gestion des images/médias
6. ⏳ Analyse de visiteurs
7. ⏳ Système de commentaires

---

## 🆘 Troubleshooting

### "Mot de passe invalide"
- Vérifiez la **casse** (sensible)
- Réinitialiser: changez `admin123` dans le code

### Les modifications ne sont pas sauvegardées
- Les données sont stockées en **mémoire locale**
- Elles seront perdues au **rechargement de la page**
- Connectez une base de données pour la persistance

### Le panel admin ne s'ouvre pas
- Appuyez **5 fois rapidement** sur le logo
- Vérifiez la **console** pour les erreurs
- Attendez que l'app soit complètement chargée

---

## 📞 Support

Pour toute question ou problème:
- Contactez l'administrateur du portfolio
- Consultez la documentation Flutter/Provider
- Visitez le repository GitHub

---

**Dernière mise à jour**: Février 2026
**Version Admin Panel**: 1.0.0
