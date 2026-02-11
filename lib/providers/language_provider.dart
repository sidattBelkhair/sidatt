// providers/language_provider.dart
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('en');
  
  final Map<String, Map<String, String>> _translations = {
    'en': {
      'home': 'Home',
      'about': 'About',
      'skills': 'Skills',
      'projects': 'Projects',
      'experience': 'Experience',
      'contact': 'Contact',
      'terminal': 'Terminal',
      'cybersecurity_engineer': 'Cybersecurity Specialist & Developer',
      'student_rss': 'Student - Networks, Systems & Security',
      'profile_desc': 'Computer science student specialized in networks, systems and security. Experience in monitoring, SOC, pentesting and application development. Co-founder of ConnectSoft, passionate about innovation (AI & Cybersecurity).',
      'view_github': 'View GitHub',
      'download_cv': 'Download CV',
      'tryhackme_profile': 'TryHackMe Profile',
      'skills_categories': 'Technical Skills',
      'cybersecurity': 'Cybersecurity',
      'networking': 'Networking',
      'development': 'Development',
      'ai_ml': 'AI & Machine Learning',
      'monitoring': 'Monitoring',
      'certifications': 'Certifications',
      'languages': 'Languages',
      'experience_title': 'Professional Experience',
      'projects_title': 'Featured Projects',
      'entrepreneurship': 'Entrepreneurship',
      'events': 'Events & Participations',
      'terminal_welcome': 'Welcome to Arch Linux Terminal v1.0.0\nType "help" to see available commands\n',
      'terminal_help': 'Available commands:\n  ls          - List files and directories\n  cat <file>  - Display file contents\n  whoami      - Display user information\n  skills      - Show technical skills\n  projects    - List all projects\n  contact     - Show contact information\n  clear       - Clear terminal\n  neofetch    - Display system info\n  hack        - Simulate hacking sequence (visual only)',
    },
    'fr': {
      'home': 'Accueil',
      'about': 'À propos',
      'skills': 'Compétences',
      'projects': 'Projets',
      'experience': 'Expérience',
      'contact': 'Contact',
      'terminal': 'Terminal',
      'cybersecurity_engineer': 'Spécialiste en  Cybersécurité & Développeur',
      'student_rss': 'Étudiant - Réseaux, Systèmes & Sécurité',
      'profile_desc': 'Étudiant en informatique spécialisé en réseaux, systèmes et sécurité. Expérience en monitoring, SOC, pentesting et développement d\'applications. Co-fondateur de ConnectSoft, passionné par l\'innovation (IA & Cybersécurité).',
      'view_github': 'Voir GitHub',
      'download_cv': 'Télécharger CV',
      'tryhackme_profile': 'Profil TryHackMe',
      'skills_categories': 'Compétences Techniques',
      'cybersecurity': 'Cybersécurité',
      'networking': 'Réseaux',
      'development': 'Développement',
      'ai_ml': 'IA & Apprentissage Automatique',
      'monitoring': 'Monitoring',
      'certifications': 'Certifications',
      'languages': 'Langues',
      'experience_title': 'Expérience Professionnelle',
      'projects_title': 'Projets Phares',
      'entrepreneurship': 'Entrepreneuriat',
      'events': 'Événements & Participations',
      'terminal_welcome': 'Bienvenue sur Terminal Arch Linux v1.0.0\nTapez "help" pour voir les commandes disponibles\n',
      'terminal_help': 'Commandes disponibles:\n  ls          - Lister les fichiers et répertoires\n  cat <file>  - Afficher le contenu du fichier\n  whoami      - Afficher les informations utilisateur\n  skills      - Afficher les compétences techniques\n  projects    - Lister tous les projets\n  contact     - Afficher les informations de contact\n  clear       - Effacer le terminal\n  neofetch    - Afficher les infos système\n  hack        - Simuler une séquence de hacking (visuel uniquement)',
    },
    'ar': {
      'home': 'الرئيسية',
      'about': 'نبذة عني',
      'skills': 'المهارات',
      'projects': 'المشاريع',
      'experience': 'الخبرة',
      'contact': 'تواصل',
      'terminal': 'الطرفية',
      'cybersecurity_engineer': 'مهندس أمن سيبراني ومطور',
      'student_rss': 'طلبة - شبكات، أنظمة وأمن',
      'profile_desc': 'طالب علوم حاسوب متخصص في الشبكات والأنظمة والأمن. خبرة في المراقبة وعمليات مركز الأمن SOC والاختبار الاختراقي وتطوير التطبيقات. أحد مؤسسي ConnectSoft، شغوف بالابتكار (الذكاء الاصطناعي والأمن السيبراني).',
      'view_github': 'عرض GitHub',
      'download_cv': 'تحميل السيرة الذاتية',
      'tryhackme_profile': 'ملف TryHackMe',
      'skills_categories': 'المهارات التقنية',
      'cybersecurity': 'الأمن السيبراني',
      'networking': 'الشبكات',
      'development': 'التطوير',
      'ai_ml': 'الذكاء الاصطناعي والتعلم الآلي',
      'monitoring': 'المراقبة',
      'certifications': 'الشهادات',
      'languages': 'اللغات',
      'experience_title': 'الخبرة المهنية',
      'projects_title': 'المشاريع المميزة',
      'entrepreneurship': 'ريادة الأعمال',
      'events': 'الفعاليات والمشاركات',
      'terminal_welcome': 'مرحباً بك في طرفية أرش لينكس v1.0.0\nاكتب "help" لرؤية الأوامر المتاحة\n',
      'terminal_help': 'الأوامر المتاحة:\n  ls          - عرض الملفات والمجلدات\n  cat <file>  - عرض محتوى الملف\n  whoami      - عرض معلومات المستخدم\n  skills      - عرض المهارات التقنية\n  projects    - عرض جميع المشاريع\n  contact     - عرض معلومات التواصل\n  clear       - مسح الطرفية\n  neofetch    - عرض معلومات النظام\n  hack        - محاكاة عملية اختراق (مرئي فقط)',
    },
  };

  Locale get currentLocale => _currentLocale;
  
  String getTranslation(String key) {
    return _translations[_currentLocale.languageCode]?[key] ?? key;
  }

  void setLocale(String languageCode) {
    _currentLocale = Locale(languageCode);
    notifyListeners();
  }

  void toggleLanguage() {
    if (_currentLocale.languageCode == 'en') {
      _currentLocale = const Locale('fr');
    } else if (_currentLocale.languageCode == 'fr') {
      _currentLocale = const Locale('ar');
    } else {
      _currentLocale = const Locale('en');
    }
    notifyListeners();
  }
}